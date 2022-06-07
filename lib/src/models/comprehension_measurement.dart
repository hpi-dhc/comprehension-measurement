import 'package:comprehension_measurement/src/constants.dart';
import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/models/questiondata.dart';
import 'package:comprehension_measurement/src/models/survey.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class ComprehensionMeasurementModel extends ChangeNotifier {
  ComprehensionMeasurementModel({
    Key? key,
    required this.surveyId,
    required this.questionContext,
    this.feedbackId,
    this.surveyLength = 4,
  });

  Survey? survey;
  final int surveyId;
  final int? feedbackId;
  final int surveyLength;

  Map<int, int> singleChoiceAnswers = {};
  Map<int, Set<int>> multipleChoiceAnswers = {};
  Map<int, String> textAnswers = {};
  final Map<String, List<String>> questionContext;

  var client = SupabaseClient(
    supabaseUrl,
    supabaseKey,
  );

  Future<void> loadSurvey() async {
    await _loadQuestions(surveyId);
  }

  Future<void> loadFeedback() async {
    await _loadQuestions(feedbackId);
  }

  void filterQuestions() {
    survey!.questions.removeWhere(
      (question) =>
          (question.isContextual &&
              !questionContext.containsKey(question.context)) ||
          QuestionData.instance.completedQuestions.contains(question.id),
    );

    if (survey!.questions.length <= surveyLength) {
      QuestionData.instance.completedSurveys.add(surveyId);
    }
  }

  void evaluateQuestions() {
    for (Question question in survey!.questions) {
      if (question.isContextual) {
        for (Answer answer in question.answers) {
          answer.isRight =
              questionContext[question.context]!.contains(answer.answerText);
        }
      }
    }
  }

  void selectQuestions() {
    survey!.questions.shuffle();
    survey!.questions = survey!.questions.take(surveyLength).toList();
  }

  Future<void> _loadQuestions(int? id) async {
    // syntax is equivalent to https://postgrest.org/en/stable/api.html

    if (id == null) {
      return;
    }

    final response = await client
        .from('surveys')
        .select('*,questions(*),questions(*,answers(*))')
        .eq('id', id)
        .single()
        .execute();

    survey = Survey.fromJson(response.data);

    assert(survey != null);

    filterQuestions();
    evaluateQuestions();
    selectQuestions();

    notifyListeners();
  }

  void changeSingleChoiceAnswer(int questionId, int? answerId) async {
    if (answerId == null) {
      return;
    }

    singleChoiceAnswers[questionId] = answerId;

    notifyListeners();
  }

  void changeMultipleChoiceAnswer(int questionId, int? answerId) async {
    if (answerId == null) {
      return;
    }

    if (multipleChoiceAnswers[questionId]!.contains(answerId)) {
      multipleChoiceAnswers[questionId]!.remove(answerId);
    } else {
      multipleChoiceAnswers[questionId]!.add(answerId);
    }

    notifyListeners();
  }

  void changeTextAnswer(int questionId, String? answerText) async {
    if (answerText == null) {
      return;
    }

    textAnswers[questionId] = answerText;

    notifyListeners();
  }

  Future<bool> saveSingleChoiceAnswer(questionId) async {
    final answerId = singleChoiceAnswers[questionId];
    final Question question = survey!.questions.firstWhere(
      (element) => element.id == questionId,
    );

    if (answerId == null) {
      return false;
    }

    if (!question.isContextual) {
      await client.rpc(
        'select_answer',
        params: {'row_id': answerId},
      ).execute();
    }

    if (question.answers
            .firstWhere(
              (element) => element.id == answerId,
            )
            .isRight ??
        false) {
      await client.rpc('increment_correct_answers',
          params: {'row_id': questionId}).execute();
    }
    await client.rpc('increment_total_answers',
        params: {'row_id': questionId}).execute();

    return true;
  }

  Future<bool> saveMultipleChoiceAnswer(int questionId) async {
    final answerIds = multipleChoiceAnswers[questionId];
    final Question question = survey!.questions.firstWhere(
      (element) => element.id == questionId,
    );

    if (answerIds == null || answerIds.isEmpty) {
      return false;
    }

    if (!question.isContextual) {
      for (int answerId in answerIds) {
        await client.rpc(
          'select_answer',
          params: {'row_id': answerId},
        ).execute();
      }
    }

    if (question.answers.every(
      (element) => answerIds.contains(element.id)
          ? element.isRight ?? false
          : !(element.isRight ?? true),
    )) {
      await client.rpc('increment_correct_answers',
          params: {'row_id': questionId}).execute();
    }

    await client.rpc('increment_total_answers',
        params: {'row_id': questionId}).execute();

    return true;
  }

  Future<bool> saveTextAnswer(int questionId) async {
    final answerText = textAnswers[questionId];

    if (answerText == null || answerText == '') {
      return false;
    }
    await client.from('text_answers').insert([
      {
        'answerText': answerText,
        'question_id': questionId,
      },
    ]).execute();

    await client.rpc('increment_total_answers',
        params: {'row_id': questionId}).execute();

    return true;
  }
}

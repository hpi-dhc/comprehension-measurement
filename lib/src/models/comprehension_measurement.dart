import 'package:comprehension_measurement/src/config.dart';
import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/models/surveydata.dart';
import 'package:comprehension_measurement/src/models/survey.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class ComprehensionMeasurementModel extends ChangeNotifier {
  ComprehensionMeasurementModel({
    Key? key,
    required this.surveyId,
    this.questionContext,
    this.feedbackId,
    this.surveyLength = 4,
    required SupabaseConfig supabaseConfig,
  }) {
    _client = SupabaseClient(
      supabaseConfig.supabaseUrl,
      supabaseConfig.supabaseKey,
    );

    questionContext ??= {};
  }

  Survey? survey;
  final int surveyId;
  final int? feedbackId;
  final int surveyLength;

  late SupabaseClient _client;

  Map<int, int> singleChoiceAnswers = {};
  Map<int, Set<int>> multipleChoiceAnswers = {};
  Map<int, String> textAnswers = {};
  Map<String, List<int>>? questionContext;

  Future<void> loadSurvey() async {
    await _loadQuestions(surveyId);
  }

  Future<void> loadFeedback() async {
    await _loadQuestions(feedbackId);
  }

  void _filterQuestions() {
    survey!.questions.removeWhere(
      (question) =>
          (question.isContextual &&
              !questionContext!.containsKey(question.context)) ||
          SurveyData.instance.completedQuestions.contains(question.id),
    );

    if (survey!.questions.length <= surveyLength) {
      SurveyData.instance.completedSurveys.add(surveyId);
    }
  }

  void _evaluateQuestions() {
    for (Question question in survey!.questions) {
      if (question.isContextual) {
        for (Answer answer in question.answers) {
          answer.isCorrect =
              questionContext![question.context]!.contains(answer.id);
        }
      }
    }
  }

  void _selectQuestions() {
    survey!.questions.shuffle();
    survey!.questions = survey!.questions.take(surveyLength).toList();
  }

  Future<void> _loadQuestions(int? id) async {
    // syntax is equivalent to https://postgrest.org/en/stable/api.html

    if (id == null) {
      return;
    }

    questionContext ??= {};

    final response = await _client
        .from('surveys')
        .select('*,questions(*),questions(*,answers(*))')
        .eq('id', id)
        .single()
        .execute();

    survey = Survey.fromJson(response.data);

    assert(survey != null);

    _filterQuestions();
    _evaluateQuestions();
    _selectQuestions();

    notifyListeners();
  }

  void changeSingleChoiceAnswer(int questionId, int? answerId) {
    if (answerId == null) {
      return;
    }

    singleChoiceAnswers[questionId] = answerId;

    notifyListeners();
  }

  void changeMultipleChoiceAnswer(int questionId, int? answerId) {
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

  void changeTextAnswer(int questionId, String? answerText) {
    if (answerText == null) {
      return;
    }

    textAnswers[questionId] = answerText;

    notifyListeners();
  }

  Future<bool> _saveSingleChoiceAnswer(Question question) async {
    final answerId = singleChoiceAnswers[question.id];

    if (answerId == null) {
      return false;
    }

    if (!question.isContextual) {
      await _client.rpc(
        'select_answer',
        params: {'row_id': answerId},
      ).execute();
    }

    if (question.answers
            .firstWhere(
              (element) => element.id == answerId,
            )
            .isCorrect ??
        false) {
      await _client.rpc('increment_correct_answers',
          params: {'row_id': question.id}).execute();
    }
    await _client.rpc('increment_total_answers',
        params: {'row_id': question.id}).execute();

    return true;
  }

  Future<bool> _saveMultipleChoiceAnswer(Question question) async {
    final answerIds = multipleChoiceAnswers[question.id];

    if (answerIds == null || answerIds.isEmpty) {
      return false;
    }

    if (!question.isContextual) {
      for (int answerId in answerIds) {
        await _client.rpc(
          'select_answer',
          params: {'row_id': answerId},
        ).execute();
      }
    }

    if (question.answers.every(
      (element) => answerIds.contains(element.id)
          ? element.isCorrect ?? false
          : !(element.isCorrect ?? true),
    )) {
      await _client.rpc('increment_correct_answers',
          params: {'row_id': question.id}).execute();
    }

    await _client.rpc('increment_total_answers',
        params: {'row_id': question.id}).execute();

    return true;
  }

  Future<bool> _saveTextAnswer(int questionId) async {
    final answerText = textAnswers[questionId];

    if (answerText == null || answerText == '') {
      return false;
    }
    await _client.from('text_answers').insert([
      {
        'answerText': answerText,
        'question_id': questionId,
      },
    ]).execute();

    await _client.rpc('increment_total_answers',
        params: {'row_id': questionId}).execute();

    return true;
  }

  Future<bool> saveAnswer(int questionId) async {
    final Question question = survey!.questions.firstWhere(
      (element) => element.id == questionId,
    );

    switch (question.type) {
      case QuestionType.singleChoice:
        return _saveSingleChoiceAnswer(question);
      case QuestionType.multipleChoice:
        return _saveMultipleChoiceAnswer(question);
      case QuestionType.textAnswer:
        return _saveTextAnswer(questionId);
    }
  }
}

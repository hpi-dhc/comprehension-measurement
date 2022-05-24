import 'package:comprehension_measurement/src/constants.dart';
import 'package:comprehension_measurement/src/models/survey.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class ComprehensionMeasurementModel extends ChangeNotifier {
  Survey? survey;

  Map<int, int> singleChoiceAnswers = {};

  var client = SupabaseClient(
    supabaseUrl,
    supabaseKey,
  );

  static Future<ComprehensionMeasurementModel> fromSurveyId(
      int surveyId) async {
    final model = ComprehensionMeasurementModel();

    model.client = SupabaseClient(
      supabaseUrl,
      supabaseKey,
    );

    // syntax is equivalent to https://postgrest.org/en/stable/api.html

    final response = await model.client
        .from('surveys')
        .select('*,questions(*),questions(*,answers(*))')
        .eq('id', surveyId)
        .single()
        .execute();

    model.survey = Survey.fromJson(response.data);

    return model;
  }

  void changeAnswer(int questionId, int? answerId) async {
    if (answerId == null) {
      return;
    }

    singleChoiceAnswers[questionId] = answerId;

    notifyListeners();
  }

  void saveSingleChoiceAnswer(questionId) async {
    final answerId = singleChoiceAnswers[questionId];

    print(await client
        .from('answers')
        .update({'times_selected': 3})
        .eq('id', answerId)
        .execute());
  }
}

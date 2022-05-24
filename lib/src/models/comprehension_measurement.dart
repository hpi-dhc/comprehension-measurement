import 'package:comprehension_measurement/src/constants.dart';
import 'package:comprehension_measurement/src/models/survey.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class ComprehensionMeasurementModel extends ChangeNotifier {
  Survey? survey;

  static Future<ComprehensionMeasurementModel> fromSurveyId(
      int surveyId) async {
    final model = ComprehensionMeasurementModel();

    final client = SupabaseClient(
      supabaseUrl,
      supabaseKey,
    );

    // syntax is equivalent to https://postgrest.org/en/stable/api.html

    final response = await client
        .from('surveys')
        .select('*,questions(*),questions(*,answers(*))')
        .eq('id', surveyId)
        .single()
        .execute();

    model.survey = Survey.fromJson(response.data);

    return model;
  }
}

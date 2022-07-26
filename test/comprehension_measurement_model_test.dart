import 'package:scio/src/models/answer.dart';
import 'package:scio/src/models/comprehension_measurement_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:supabase/supabase.dart';

import 'supabase_config.dart';

void main() {
  test('Creates model', () async {
    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: supabaseConfig,
    );

    await model.loadSurvey();
    expect(model.survey, isNotNull);
  });

  test('Saves single choice answers', () async {
    final client =
        SupabaseClient(supabaseConfig.supabaseUrl, supabaseConfig.supabaseKey);

    var response =
        await client.from('answers').select('*').eq('id', 1).single().execute();
    final timesSelected = Answer.fromJson(response.data).timesSelected;

    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: supabaseConfig,
    );
    await model.loadSurvey();
    expect(await model.saveAnswer(1), isFalse);

    model.changeSingleChoiceAnswer(1, 1);
    expect(await model.saveAnswer(1), isTrue);

    response =
        await client.from('answers').select('*').eq('id', 1).single().execute();

    final answer = Answer.fromJson(response.data);
    expect(answer.timesSelected, timesSelected + 1);
  });

  test('Saves multiple choice answers', () async {
    final client =
        SupabaseClient(supabaseConfig.supabaseUrl, supabaseConfig.supabaseKey);

    var response =
        await client.from('answers').select('*').eq('id', 3).single().execute();
    final timesSelected = Answer.fromJson(response.data).timesSelected;

    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: supabaseConfig,
    );
    await model.loadSurvey();
    expect(await model.saveAnswer(2), isFalse);

    model.multipleChoiceAnswers[2] = {};

    model.changeMultipleChoiceAnswer(2, 3);
    expect(await model.saveAnswer(2), isTrue);

    response =
        await client.from('answers').select('*').eq('id', 3).single().execute();

    final answer = Answer.fromJson(response.data);
    expect(answer.timesSelected, timesSelected + 1);
  });

  test('Saves text question answers', () async {
    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: supabaseConfig,
    );
    await model.loadSurvey();
    expect(await model.saveAnswer(3), isFalse);

    model.changeTextAnswer(3, 'test');
    expect(await model.saveAnswer(3), isTrue);
  });
}

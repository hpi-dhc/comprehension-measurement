import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:comprehension_measurement/scio.dart';
import 'package:supabase/supabase.dart';

void main() {
  final config = SupabaseConfig(
    'http://localhost:54321',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs',
  );
  test('Creates model', () async {
    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: config,
    );

    await model.loadSurvey();
    expect(model.survey, isNotNull);
  });

  test('Saves single choice answers', () async {
    final client = SupabaseClient(config.supabaseUrl, config.supabaseKey);

    var response =
        await client.from('answers').select('*').eq('id', 1).single().execute();
    final timesSelected = Answer.fromJson(response.data).timesSelected;

    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: config,
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
    final client = SupabaseClient(config.supabaseUrl, config.supabaseKey);

    var response =
        await client.from('answers').select('*').eq('id', 3).single().execute();
    final timesSelected = Answer.fromJson(response.data).timesSelected;

    final model = ComprehensionMeasurementModel(
      surveyId: 1,
      supabaseConfig: config,
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
      supabaseConfig: config,
    );
    await model.loadSurvey();
    expect(await model.saveAnswer(3), isFalse);

    model.changeTextAnswer(3, 'test');
    expect(await model.saveAnswer(3), isTrue);
  });
}

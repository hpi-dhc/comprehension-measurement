import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/types/text_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'text_answer_widget_test.mocks.dart';

Widget createWidgetForTesting(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}

@GenerateMocks([ComprehensionMeasurementModel])
void main() {
  testWidgets('Displays text answer question view', (tester) async {
    const questionId = 1;

    final model = MockComprehensionMeasurementModel();
    when(model.multipleChoiceAnswers).thenReturn({});
    await tester.pumpWidget(createWidgetForTesting(
      TextAnswerWidget(questionId: questionId, model: model),
    ));

    const testString = 'test';

    verifyNever(model.changeTextAnswer(questionId, testString));

    await tester.enterText(find.byType(TextField), testString);

    verify(model.changeTextAnswer(questionId, testString)).called(1);
  });
}

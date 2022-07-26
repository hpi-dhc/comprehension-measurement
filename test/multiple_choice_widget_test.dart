import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/types/multi_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'multiple_choice_widget_test.mocks.dart';

Widget createWidgetForTesting(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}

@GenerateMocks([ComprehensionMeasurementModel])
void main() {
  testWidgets('Displays multiple choice question view', (tester) async {
    final question = Question(
        id: 1,
        title: 'Test question',
        type: QuestionType.multipleChoice,
        answers: [Answer(1, null, 'Test answer', 0)]);

    final model = MockComprehensionMeasurementModel();
    when(model.multipleChoiceAnswers).thenReturn({});
    await tester.pumpWidget(createWidgetForTesting(
      MultipleChoiceWidget(question: question, model: model),
    ));

    verifyNever(model.changeMultipleChoiceAnswer(1, 1));

    final answerFinder = find.text('Test answer');
    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is Checkbox,
    ));

    expect(answerFinder, findsOneWidget);
    verify(model.changeMultipleChoiceAnswer(1, 1)).called(1);
  });
}

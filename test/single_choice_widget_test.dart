import 'package:scio/src/models/answer.dart';
import 'package:scio/src/models/comprehension_measurement_model.dart';
import 'package:scio/src/models/question.dart';
import 'package:scio/src/types/single_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'single_choice_widget_test.mocks.dart';

Widget createWidgetForTesting(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}

@GenerateMocks([ComprehensionMeasurementModel])
void main() {
  testWidgets('Displays single choice question view', (tester) async {
    final question = Question(
        id: 1,
        title: 'Test question',
        type: QuestionType.singleChoice,
        answers: [Answer(1, null, 'Test answer', 0)]);

    final model = MockComprehensionMeasurementModel();
    when(model.singleChoiceAnswers).thenReturn({});
    await tester.pumpWidget(createWidgetForTesting(
      SingleChoiceWidget(question: question, model: model),
    ));

    verifyNever(model.changeSingleChoiceAnswer(1, 1));

    final answerFinder = find.text('Test answer');
    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is Radio<int>,
    ));

    expect(answerFinder, findsOneWidget);
    verify(model.changeSingleChoiceAnswer(1, 1)).called(1);
  });
}

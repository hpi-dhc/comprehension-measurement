import 'package:scio/src/comprehension_measurement_widget.dart';
import 'package:scio/src/models/comprehension_measurement_model.dart';
import 'package:scio/src/models/question.dart';
import 'package:scio/src/models/survey.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'comprehension_measurement_widget_test.mocks.dart';

Widget createWidgetForTesting(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}

@GenerateMocks([ComprehensionMeasurementModel])
void main() {
  testWidgets('Displays empty comprehension widget', (tester) async {
    final model = MockComprehensionMeasurementModel();
    when(model.survey).thenReturn(null);
    await tester.pumpWidget(createWidgetForTesting(
        ChangeNotifierProvider<ComprehensionMeasurementModel>.value(
            value: model,
            child: ComprehensionMeasurementWidget(
                introText: 'introText',
                surveyButtonText: 'surveyButtonText',
                feedbackButtonText: 'feedbackButtonText'))));

    final pageViewFinder = find.byType(ExpandablePageView);
    expect(pageViewFinder, findsOneWidget);
    final ExpandablePageView pageView = tester.firstWidget(pageViewFinder);
    expect(pageView.children?.length, 2);
  });

  testWidgets('Displays survey', (tester) async {
    final singleChoiceQuestion = Question(
        id: 1,
        title: 'Test question',
        type: QuestionType.singleChoice,
        answers: []);

    final multipleChoiceQuestion = Question(
        id: 2,
        title: 'Test question',
        type: QuestionType.multipleChoice,
        answers: []);

    final textQuestion = Question(
        id: 3,
        title: 'Test question',
        type: QuestionType.textAnswer,
        answers: []);

    final survey = Survey(1, 'title',
        [singleChoiceQuestion, multipleChoiceQuestion, textQuestion]);

    final model = MockComprehensionMeasurementModel();
    when(model.survey).thenReturn(survey);
    await tester.pumpWidget(createWidgetForTesting(
        ChangeNotifierProvider<ComprehensionMeasurementModel>.value(
            value: model,
            child: ComprehensionMeasurementWidget(
                introText: 'introText',
                surveyButtonText: 'surveyButtonText',
                feedbackButtonText: 'feedbackButtonText'))));

    final pageViewFinder = find.byType(ExpandablePageView);
    final ExpandablePageView pageView = tester.firstWidget(pageViewFinder);
    expect(pageView.children?.length, 5);
  });
}

import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/types/completion.dart';
import 'package:comprehension_measurement/src/types/intro.dart';
import 'package:comprehension_measurement/src/types/multi_choice.dart';
import 'package:comprehension_measurement/src/types/single_choice.dart';
import 'package:comprehension_measurement/src/types/text_answer.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComprehensionMeasurementWidget extends StatelessWidget {
  ComprehensionMeasurementWidget({
    Key? key,
    required this.introText,
    required this.surveyButtonText,
    required this.feedbackButtonText,
  }) : super(key: key);

  final String introText;
  final String surveyButtonText;
  final String feedbackButtonText;
  final PageController controller = PageController();

  void continueSurvey() {
    controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> buildQuestionWidgets(
      PageController controller,
      BuildContext context,
      ComprehensionMeasurementModel value,
      ThemeData theme) {
    return value.survey?.questions.map(
          (question) {
            Widget questionWidget;

            switch (question.type) {
              case QuestionType.single_choice:
                questionWidget = SingleChoiceWidget(
                  questionId: question.id,
                  model: value,
                );
                break;
              case QuestionType.multiple_choice:
                questionWidget = MultipleChoiceWidget(
                  questionId: question.id,
                  model: value,
                );
                break;
              case QuestionType.text_answer:
                questionWidget = TextAnswerWidget(
                  questionId: question.id,
                  model: value,
                );
                break;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 2,
                  height: 2,
                  color: theme.backgroundColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    question.title,
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 2,
                  color: theme.backgroundColor,
                ),
                questionWidget,
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool shouldSend = false;
                        switch (question.type) {
                          case QuestionType.single_choice:
                            shouldSend = await value.saveSingleChoiceAnswer(
                              question.id,
                            );
                            break;
                          case QuestionType.multiple_choice:
                            shouldSend = await value.saveMultipleChoiceAnswer(
                              question.id,
                            );
                            break;
                          case QuestionType.text_answer:
                            shouldSend = await value.saveTextAnswer(
                              question.id,
                            );
                            break;
                        }
                        if (shouldSend) {
                          continueSurvey();
                        }
                      },
                      child: const Text('Send'),
                    ),
                  ),
                )
              ],
            );
          },
        ).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Consumer<ComprehensionMeasurementModel>(
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(
                          Icons.assignment,
                          color: theme.primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: ExpandablePageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      IntroWidget(
                        text: introText,
                        surveyButtonText: surveyButtonText,
                        feedbackButtonText: feedbackButtonText,
                        model: value,
                        onQuestionsLoaded: continueSurvey,
                      ),
                      ...buildQuestionWidgets(
                          controller, context, value, theme),
                      const CompletionWidget(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

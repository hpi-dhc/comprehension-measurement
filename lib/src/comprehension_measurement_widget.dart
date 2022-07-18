import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/models/surveydata.dart';
import 'package:comprehension_measurement/src/types/completion.dart';
import 'package:comprehension_measurement/src/types/intro.dart';
import 'package:comprehension_measurement/src/types/choice_question.dart';
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
    int i = 0;
    return value.survey?.questions.map(
          (question) {
            Widget questionWidget;

            if (question.type == QuestionType.textAnswer) {
              questionWidget = TextAnswerWidget(
                questionId: question.id,
                model: value,
              );
            } else {
              questionWidget = ChoiceQuestionWidget(
                questionId: question.id,
                model: value,
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    question.title,
                  ),
                ),
                questionWidget,
                Row(
                  children: [
                    Expanded(
                      child: _buildPageIndicator(
                          context, i++, value.survey!.questions.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: theme.primaryColor),
                        onPressed: () async {
                          if (await value.saveAnswer(question.id)) {
                            SurveyData.instance.completedQuestions
                                .add(question.id);
                            await SurveyData.save();
                            continueSurvey();
                          }
                        },
                        child: const Text('Send'),
                      ),
                    ),
                  ],
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
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Consumer<ComprehensionMeasurementModel>(
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: theme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Icon(
                          Icons.assignment,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        color: Colors.white,
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

  Widget _buildPageIndicator(
      BuildContext context, int currentPage, int maxPage) {
    final list = <Widget>[];

    for (int i = 0; i < maxPage; i++) {
      list.add(_indicator(context, i == currentPage));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _indicator(BuildContext context, bool isActive) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? theme.primaryColor : theme.disabledColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

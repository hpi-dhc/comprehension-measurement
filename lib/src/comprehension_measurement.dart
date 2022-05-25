import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/types/single_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComprehensionMeasurementWidget extends StatelessWidget {
  const ComprehensionMeasurementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PageController controller = PageController();
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Consumer<ComprehensionMeasurementModel>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: value.survey!.questions.map(
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
                        questionWidget = SingleChoiceWidget(
                          questionId: question.id,
                          model: value,
                        );
                        break;
                      case QuestionType.text_answer:
                        questionWidget = SingleChoiceWidget(
                          questionId: question.id,
                          model: value,
                        );
                        break;
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.emoji_emotions,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(question.title),
                          ],
                        ),
                        Divider(thickness: 2, color: theme.backgroundColor),
                        questionWidget,
                        ElevatedButton(
                          onPressed: () {
                            value.saveSingleChoiceAnswer(question.id);
                            controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text('Send!'),
                        )
                      ],
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

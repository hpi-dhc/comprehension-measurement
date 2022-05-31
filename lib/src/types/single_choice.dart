import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatelessWidget {
  SingleChoiceWidget({
    Key? key,
    required this.questionId,
    required this.model,
    this.context,
  }) {
    question = model.survey!.questions
        .firstWhere((question) => question.id == questionId);

    if (question.is_contextual) {
      assert(
        question.context != null &&
            context != null &&
            context!.keys.contains(question.context) &&
            context![question.context] != null,
      );
      for (Answer answer in question.answers) {
        answer.is_right =
            context![question.context]!.contains(answer.answer_text);
      }
    }
  }

  final int questionId;
  late Question question;
  final ComprehensionMeasurementModel model;
  final Map<String, List<String>>? context;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(question.answers[index].answer_text),
            value: question.answers[index].id,
            groupValue: model.singleChoiceAnswers[questionId],
            onChanged: (int? value) {
              model.changeSingleChoiceAnswer(questionId, value);
            },
          );
        },
        itemCount: question.answers.length);
  }
}

import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatelessWidget {
  MultipleChoiceWidget({
    Key? key,
    required this.questionId,
    required this.model,
  }) : super(key: key);

  final int questionId;
  final ComprehensionMeasurementModel model;

  @override
  Widget build(BuildContext context) {
    final question = model.survey!.questions
        .where((question) => question.id == questionId)
        .first;

    if (model.multipleChoiceAnswers[questionId] == null) {
      model.multipleChoiceAnswers[questionId] = {};
    }

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.platform,
            value: model.multipleChoiceAnswers[questionId]!
                .contains(question.answers[index].id),
            title: Text(question.answers[index].answer_text),
            onChanged: (bool? value) {
              model.changeMultipleChoiceAnswer(
                  questionId, question.answers[index].id);
            },
          );
        },
        itemCount: question.answers.length);
  }
}
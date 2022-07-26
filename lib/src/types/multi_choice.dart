import 'package:scio/src/models/comprehension_measurement_model.dart';
import 'package:scio/src/models/question.dart';
import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatelessWidget {
  const MultipleChoiceWidget({
    Key? key,
    required this.question,
    required this.model,
  }) : super(key: key);

  final Question question;
  final ComprehensionMeasurementModel model;

  @override
  Widget build(BuildContext context) {
    if (model.multipleChoiceAnswers[question.id] == null) {
      model.multipleChoiceAnswers[question.id] = {};
    }

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.platform,
            value: model.multipleChoiceAnswers[question.id]!
                .contains(question.answers[index].id),
            title: Text(question.answers[index].answerText),
            onChanged: (bool? value) {
              model.changeMultipleChoiceAnswer(
                  question.id, question.answers[index].id);
            },
          );
        },
        itemCount: question.answers.length);
  }
}

import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatelessWidget {
  MultipleChoiceWidget({
    Key? key,
    required this.question,
    required this.model,
    required this.questionId,
  }) : super(key: key);

  final Question question;
  final ComprehensionMeasurementModel model;
  final int questionId;

  @override
  Widget build(BuildContext context) {
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

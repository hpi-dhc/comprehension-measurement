import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatelessWidget {
  SingleChoiceWidget({
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

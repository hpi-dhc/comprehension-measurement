import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatelessWidget {
  const SingleChoiceWidget({
    Key? key,
    required this.question,
    required this.model,
  }) : super(key: key);

  final Question question;
  final ComprehensionMeasurementModel model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(question.answers[index].answerText),
            value: question.answers[index].id,
            groupValue: model.singleChoiceAnswers[question.id],
            onChanged: (int? value) {
              model.changeSingleChoiceAnswer(question.id, value);
            },
          );
        },
        itemCount: question.answers.length);
  }
}

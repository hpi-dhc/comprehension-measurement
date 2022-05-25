import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';

class TextAnswerWidget extends StatelessWidget {
  TextAnswerWidget({
    Key? key,
    required this.questionId,
    required this.model,
  }) : super(key: key);

  final int questionId;
  final ComprehensionMeasurementModel model;

  @override
  Widget build(BuildContext context) {
    if (model.textAnswers[questionId] == null) {
      model.textAnswers[questionId] = '';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        maxLines: null,
        onChanged: (String value) {
          model.changeTextAnswer(questionId, value);
        },
      ),
    );
  }
}

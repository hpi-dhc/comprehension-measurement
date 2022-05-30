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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 8.0,
      ),
      child: TextField(
        maxLines: null,
        onChanged: (String value) {
          model.changeTextAnswer(questionId, value);
        },
      ),
    );
  }
}

import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    Key? key,
    required this.text,
    required this.surveyButtonText,
    required this.feedbackButtonText,
    required this.model,
    required this.callback,
  }) : super(key: key);

  final String text;
  final ComprehensionMeasurementModel model;
  final String surveyButtonText;
  final String feedbackButtonText;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          Text(text),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await model.loadSurvey();
                  callback();
                },
                child: Text(surveyButtonText),
              ),
              ElevatedButton(
                onPressed: () async {
                  await model.loadFeedback();
                  callback();
                },
                child: Text(feedbackButtonText),
              )
            ],
          )
        ],
      ),
    );
  }
}

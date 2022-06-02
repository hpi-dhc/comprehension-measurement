import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/questiondata.dart';
import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    Key? key,
    required this.text,
    required this.surveyButtonText,
    required this.feedbackButtonText,
    required this.model,
    required this.onQuestionsLoaded,
  }) : super(key: key);

  final String text;
  final ComprehensionMeasurementModel model;
  final String surveyButtonText;
  final String feedbackButtonText;
  final Function() onQuestionsLoaded;

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
                  onQuestionsLoaded();
                },
                child: Text(surveyButtonText),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (model.feedbackId == null) {
                    Navigator.pop(context);
                  } else {
                    await model.loadFeedback();
                    onQuestionsLoaded();
                  }
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

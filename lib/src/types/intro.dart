import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    Key? key,
    required this.text,
    required this.surveyButtonText,
    required this.feedbackButtonText,
    required this.controller,
    required this.model,
  }) : super(key: key);

  final String text;
  final PageController controller;
  final ComprehensionMeasurementModel model;
  final String surveyButtonText;
  final String feedbackButtonText;

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
                  await model.loadQuestions(model.surveyId);
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(surveyButtonText),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (model.feedbackId == 0) {
                    Navigator.pop(context);
                  } else {
                    await model.loadQuestions(model.feedbackId);
                    controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
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

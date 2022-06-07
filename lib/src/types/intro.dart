import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/surveydata.dart';
import 'package:flutter/material.dart';

class IntroWidget extends StatefulWidget {
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
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          Text(widget.text),
          const SizedBox(
            height: 16.0,
          ),
          CheckboxListTile(
            title: const Text('Don\'t show this again'),
            value: SurveyData.instance.optOut,
            onChanged: (value) {
              setState(() {
                SurveyData.instance.optOut = value ?? false;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  SurveyData.save();
                  await widget.model.loadSurvey();
                  widget.onQuestionsLoaded();
                },
                child: Text(widget.surveyButtonText),
              ),
              ElevatedButton(
                onPressed: () async {
                  SurveyData.save();
                  if (widget.model.feedbackId == null) {
                    Navigator.pop(context);
                  } else {
                    await widget.model.loadFeedback();
                    widget.onQuestionsLoaded();
                  }
                },
                child: Text(widget.feedbackButtonText),
              )
            ],
          )
        ],
      ),
    );
  }
}

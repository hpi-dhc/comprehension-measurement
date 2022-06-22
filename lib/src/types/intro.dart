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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            child: Text(
              widget.text,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          CheckboxListTile(
            title: Text(
              'Click this checkbox if you want to stop participating in surveys',
              style: theme.textTheme.bodySmall,
            ),
            value: SurveyData.instance.optOut,
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: VisualDensity.compact,
            onChanged: (value) {
              setState(() {
                SurveyData.instance.optOut = value ?? false;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                style: ElevatedButton.styleFrom(primary: theme.primaryColor),
                child: Text(widget.feedbackButtonText),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  SurveyData.save();
                  await widget.model.loadSurvey();
                  widget.onQuestionsLoaded();
                },
                style: ElevatedButton.styleFrom(primary: theme.primaryColor),
                child: Text(widget.surveyButtonText),
              ),
            ],
          )
        ],
      ),
    );
  }
}

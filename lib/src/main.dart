import 'package:comprehension_measurement/src/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> measureComprehension({
  required BuildContext context,
  required int surveyId,
  required String introText,
  required String surveyButtonText,
  int? feedbackId,
  String feedbackButtonText = 'Close',
}) async {
  final model = ComprehensionMeasurementModel(
    surveyId: surveyId,
    feedbackId: feedbackId,
  );

  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
        value: model,
        child: ComprehensionMeasurementWidget(
          introText: introText,
          surveyButtonText: surveyButtonText,
          feedbackButtonText: feedbackButtonText,
        ),
      );
    },
  );
}

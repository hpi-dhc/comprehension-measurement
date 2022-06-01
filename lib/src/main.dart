import 'package:comprehension_measurement/src/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> measureComprehension({
  required BuildContext context,
  required int surveyId,
  required String introText,
  required String surveyButtonText,
  required Map<String, List<String>> questionContext,
  int? feedbackId,
  String feedbackButtonText = 'Close',
}) async {
  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => ComprehensionMeasurementModel(
          surveyId: surveyId,
          feedbackId: feedbackId,
        ),
        child: ComprehensionMeasurementWidget(
          introText: introText,
          surveyButtonText: surveyButtonText,
          feedbackButtonText: feedbackButtonText,
          questionContext: questionContext,
        ),
      );
    },
  );
}

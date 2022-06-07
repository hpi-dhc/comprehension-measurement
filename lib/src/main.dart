import 'package:comprehension_measurement/src/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/config.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> measureComprehension({
  required BuildContext context,
  required int surveyId,
  required String introText,
  required String surveyButtonText,
  Map<String, List<String>> questionContext = const {},
  int? feedbackId,
  String feedbackButtonText = 'Close',
  required SupabaseConfig supabaseConfig,
}) async {
  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => ComprehensionMeasurementModel(
          surveyId: surveyId,
          feedbackId: feedbackId,
          questionContext: questionContext,
          supabaseConfig: supabaseConfig,
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

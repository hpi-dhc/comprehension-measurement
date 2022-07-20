import 'package:comprehension_measurement/scio.dart';
import 'package:flutter/material.dart';

class ComprehensionHelper {
  static bool shouldMeasure = false;
  static Map<String, List<int>> questionContext = {};

  static void attach(
    Future future, {
    required BuildContext context,
    required int surveyId,
    required String introText,
    required String surveyButtonText,
    required SupabaseConfig supabaseConfig,
    int? feedbackId,
    String feedbackButtonText = 'Close',
  }) {
    ComprehensionHelper.shouldMeasure = true;
    future.then((_) => ComprehensionHelper.measure(
          context: context,
          surveyId: surveyId,
          introText: introText,
          surveyButtonText: surveyButtonText,
          supabaseConfig: supabaseConfig,
          feedbackId: feedbackId,
          feedbackButtonText: feedbackButtonText,
        ));
  }

  static void measure({
    required BuildContext context,
    required int surveyId,
    required String introText,
    required String surveyButtonText,
    required SupabaseConfig supabaseConfig,
    int? feedbackId,
    String feedbackButtonText = 'Close',
  }) {
    if (!shouldMeasure) return;
    measureComprehension(
      context: context,
      surveyId: surveyId,
      introText: introText,
      surveyButtonText: surveyButtonText,
      supabaseConfig: supabaseConfig,
      questionContext: questionContext,
      feedbackId: feedbackId,
      feedbackButtonText: feedbackButtonText,
    );
    shouldMeasure = false;
  }
}

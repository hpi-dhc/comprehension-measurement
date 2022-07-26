import 'package:comprehension_measurement/scio.dart';
import 'package:flutter/material.dart';

class ComprehensionHelper {
  factory ComprehensionHelper() => _instance;

  ComprehensionHelper._();

  static final ComprehensionHelper _instance = ComprehensionHelper._();

  static ComprehensionHelper get instance => _instance;

  bool shouldMeasure = false;
  Map<String, List<int>> questionContext = {};

  void attach(
    Future future, {
    required BuildContext context,
    required int surveyId,
    required String introText,
    required String surveyButtonText,
    required SupabaseConfig supabaseConfig,
    int? feedbackId,
    String feedbackButtonText = 'Close',
    bool enablePersistence = true,
  }) {
    ComprehensionHelper.instance.shouldMeasure = true;
    future.then((_) => ComprehensionHelper.instance.measure(
        context: context,
        surveyId: surveyId,
        introText: introText,
        surveyButtonText: surveyButtonText,
        supabaseConfig: supabaseConfig,
        feedbackId: feedbackId,
        feedbackButtonText: feedbackButtonText,
        enablePersistence: enablePersistence));
  }

  void measure({
    required BuildContext context,
    required int surveyId,
    required String introText,
    required String surveyButtonText,
    required SupabaseConfig supabaseConfig,
    int? feedbackId,
    String feedbackButtonText = 'Close',
    bool enablePersistence = true,
  }) {
    if (!instance.shouldMeasure) return;
    measureComprehension(
      context: context,
      surveyId: surveyId,
      introText: introText,
      surveyButtonText: surveyButtonText,
      supabaseConfig: supabaseConfig,
      questionContext: instance.questionContext,
      feedbackId: feedbackId,
      feedbackButtonText: feedbackButtonText,
      enablePersistence: enablePersistence,
    );
    instance.shouldMeasure = false;
  }
}

import 'package:comprehension_measurement/src/comprehension_measurement_widget.dart';
import 'package:comprehension_measurement/src/config.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/models/surveydata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> measureComprehension({
  required BuildContext context,
  required int surveyId,
  required String introText,
  required String surveyButtonText,
  Map<String, List<int>> questionContext = const {},
  int? feedbackId,
  String feedbackButtonText = 'Close',
  required SupabaseConfig supabaseConfig,
}) async {
  await Hive.initFlutter();

  await initSurveyData();

  if (SurveyData.instance.completedSurveys.contains(surveyId) ||
      SurveyData.instance.optOut) {
    return;
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: ChangeNotifierProvider(
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
          ),
        ),
      );
    },
  );
}

import 'package:comprehension_measurement/src/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/questiondata.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> measureComprehension({
  required BuildContext context,
  required int surveyId,
  required String introText,
  required String surveyButtonText,
  Map<String, List<String>> questionContext = const {},
  int? feedbackId,
  String feedbackButtonText = 'Close',
}) async {
  await Hive.initFlutter();

  await initQuestionData();

  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => ComprehensionMeasurementModel(
          surveyId: surveyId,
          feedbackId: feedbackId,
          questionContext: questionContext,
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

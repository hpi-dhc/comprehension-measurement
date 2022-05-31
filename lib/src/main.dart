import 'package:comprehension_measurement/src/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> measureComprehension(BuildContext context, int surveyId,
    Map<String, List<String>> questionContext) async {
  final model = await ComprehensionMeasurementModel.fromSurveyId(surveyId);

  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
        value: model,
        child: ComprehensionMeasurementWidget(questionContext: questionContext),
      );
    },
  );
}

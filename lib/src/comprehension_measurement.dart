import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComprehensionMeasurementWidget extends StatelessWidget {
  const ComprehensionMeasurementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Consumer<ComprehensionMeasurementModel>(
          builder: (context, value, child) {
            return Text(value.survey?.title ?? 'No survey loaded');
          },
        ),
      ),
    );
  }
}

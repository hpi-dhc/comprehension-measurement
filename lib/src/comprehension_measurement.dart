import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/types/single_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComprehensionMeasurementWidget extends StatelessWidget {
  const ComprehensionMeasurementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Consumer<ComprehensionMeasurementModel>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.emoji_emotions,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(value.survey!.questions[0].title),
                    ],
                  ),
                  Divider(thickness: 2, color: theme.backgroundColor),
                  SingleChoiceWidget(questionId: 1, model: value),
                  ElevatedButton(
                      onPressed: () => value.saveSingleChoiceAnswer(1),
                      child: const Text('Send!'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

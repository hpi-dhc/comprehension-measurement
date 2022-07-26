import 'package:comprehension_measurement/src/comprehension_measurement_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:comprehension_measurement/scio.dart';

import 'supabase_config.dart';

Widget createWidgetForTesting(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}

void main() {
  testWidgets('Displays comprehension dialog', (tester) async {
    await tester.pumpWidget(
      createWidgetForTesting(
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => measureComprehension(
              context: context,
              surveyId: 1,
              introText: 'introText',
              surveyButtonText: 'surveyButtonText',
              feedbackButtonText: 'feedbackButtonText',
              feedbackId: 2,
              surveyLength: 6,
              supabaseConfig: supabaseConfig,
              enablePersistence: false,
            ),
            child: const Text('text'),
          );
        }),
      ),
    );

    await tester.tap(find.text('text'));

    await tester.pumpAndSettle();

    final comprehensionFinder = find.byType(ComprehensionMeasurementWidget);
    expect(comprehensionFinder, findsOneWidget);
  });
}

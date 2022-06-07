import 'package:comprehension_measurement/src/models/questiondata.dart';
import 'package:flutter/material.dart';

class CompletionWidget extends StatelessWidget {
  const CompletionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Thank you!'),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Complete'),
            ),
          ),
        ],
      ),
    );
  }
}

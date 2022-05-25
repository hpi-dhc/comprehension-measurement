library comprehension_measurement;

import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

class TextAnswerWidget extends StatefulWidget {
  TextAnswerWidget(
      {Key? key,
      required this.questionId,
      required this.question,
      required this.client})
      : super(key: key);

  final int questionId;
  final String question;
  final SupabaseClient client;
  String? answer;

  String? sendAnswer() {
    return answer;
  }

  @override
  State<TextAnswerWidget> createState() => _TextAnswerWidgetState();
}

class _TextAnswerWidgetState extends State<TextAnswerWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = "Dummy answer";
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.access_alarm_rounded,
                color: theme.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.question),
            ],
          ),
          Divider(thickness: 2, color: theme.backgroundColor),
          TextField(
            controller: textEditingController,
            onChanged: (String value) {
              setState(() {
                widget.answer = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

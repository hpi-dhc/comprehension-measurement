library comprehension_measurement;

import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

class MultipleChoiceWidget extends StatefulWidget {
  MultipleChoiceWidget(
      {Key? key,
      required this.questionId,
      required this.question,
      required this.answers,
      required this.client})
      : super(key: key);

  final int questionId;
  final String question;
  final List<Answer> answers;
  final SupabaseClient client;
  Set<int> answerIds = {};

  Set<int> sendIds() {
    return answerIds;
  }

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
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
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.platform,
                  value: widget.answerIds.contains(widget.answers[index].id),
                  title: Text(widget.answers[index].answer_text),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        widget.answerIds.add(widget.answers[index].id);
                      } else {
                        widget.answerIds.remove(widget.answers[index].id);
                      }
                    });
                  },
                );
              },
              itemCount: widget.answers.length),
        ],
      ),
    );
  }
}

import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

class SingleChoiceWidget extends StatefulWidget {
  SingleChoiceWidget(
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
  int? answerId;

  int? sendId() {
    return answerId;
    /* 
    Example of direct send from widget
    client
        .from('answers')
        .update({'times_selected': 1})
        .eq('id', answerId)
        .execute(); */
  }

  @override
  State<SingleChoiceWidget> createState() => _SingleChoiceWidgetState();
}

class _SingleChoiceWidgetState extends State<SingleChoiceWidget> {
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
                return RadioListTile(
                  title: Text(widget.answers[index].answer_text),
                  value: widget.answers[index].id,
                  groupValue: widget.answerId,
                  onChanged: (int? value) {
                    setState(() {
                      widget.answerId = value;
                      print(value);
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

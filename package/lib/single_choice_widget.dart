library comprehension_measurement;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget({
    Key? key,
    required this.questionId,
    required this.question,
    required this.answers,
    required this.headingTheme,
    required this.textTheme,
    required this.icon,
    required this.endpoint,
  }) : super(key: key);

  final int questionId;
  final String question;
  final List<String> answers;
  final TextStyle? headingTheme;
  final TextStyle? textTheme;
  final IconData icon;
  final Uri endpoint;

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  int? answerId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        elevation: 4,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    widget.icon,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.question, style: widget.headingTheme),
                ],
              ),
              Divider(thickness: 2, color: theme.backgroundColor),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title:
                          Text(widget.answers[index], style: widget.textTheme),
                      value: index,
                      groupValue: answerId,
                      onChanged: (int? value) {
                        setState(() {
                          answerId = value;
                        });
                      },
                    );
                  },
                  itemCount: widget.answers.length),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return theme.primaryColor.withOpacity(0.5);
                          }
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      // TODO: send the answer to the backend
                      http.get(
                        Uri.parse(
                            'https://xrnczlpeghrewcseaxyq.supabase.co/rest/v1/questions?id=eq.1&select=*'),
                        headers: {
                          'apikey':
                              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhybmN6bHBlZ2hyZXdjc2VheHlxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTI5NjIzNTksImV4cCI6MTk2ODUzODM1OX0.3SPL2iHbDRS4m42n6UlOIuV8tFMShi7b9Mzh9l8E4Gs',
                          'Authorization': 'Bearer SUPABASE_KEY'
                        },
                      );
                      Navigator.maybePop(context);
                    },
                    child: Text('Done'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

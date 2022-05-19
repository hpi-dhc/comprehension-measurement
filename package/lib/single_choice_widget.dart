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
          padding: const EdgeInsets.all(8.0),
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
                      http.post(
                        widget.endpoint,
                        body: {
                          'questionId': widget.questionId.toString(),
                          'answerId': answerId.toString(),
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

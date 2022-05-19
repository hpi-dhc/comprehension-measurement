library comprehension_measurement;

import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget(
      {Key? key, required this.question, required this.answers})
      : super(key: key);

  final String question;
  final List<String> answers;

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  String? answer = '';

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.question_mark),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.question),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(widget.answers[index]),
                      value: widget.answers[index],
                      groupValue: answer,
                      onChanged: (String? value) {
                        setState(() {
                          answer = value;
                        });
                      },
                    );
                  },
                  itemCount: widget.answers.length),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseButton(
                    onPressed: () {
                      // TODO: send the answer to the backend
                      print(this.answer);
                      Navigator.maybePop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

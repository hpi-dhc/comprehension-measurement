import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

class SingleChoiceWidget extends StatelessWidget {
  const SingleChoiceWidget({
    Key? key,
    required this.questionId,
    required this.model,
  }) : super(key: key);

  final int questionId;
  final ComprehensionMeasurementModel model;

  @override
  Widget build(BuildContext context) {
    final question = model.survey!.questions
        .where((question) => question.id == questionId)
        .first;

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(question.answers[index].answer_text),
            value: question.answers[index].id,
            groupValue: model.singleChoiceAnswers[questionId],
            onChanged: (int? value) {
              model.changeAnswer(questionId, value);
            },
          );
        },
        itemCount: question.answers.length);
  }
}

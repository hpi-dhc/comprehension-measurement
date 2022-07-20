import 'package:comprehension_measurement/src/models/comprehension_measurement_model.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/types/multi_choice.dart';
import 'package:comprehension_measurement/src/types/single_choice.dart';
import 'package:flutter/material.dart';

class ChoiceQuestionWidget extends StatelessWidget {
  ChoiceQuestionWidget({
    Key? key,
    required this.questionId,
    required this.model,
  }) : super(key: key) {
    question = model.survey!.questions
        .firstWhere((question) => question.id == questionId);

    switch (question.type) {
      case QuestionType.singleChoice:
        child = SingleChoiceWidget(
          question: question,
          model: model,
        );
        break;
      case QuestionType.multipleChoice:
        child = MultipleChoiceWidget(
          question: question,
          model: model,
        );
        break;
      case QuestionType.textAnswer:
        throw FlutterError(
            "Questions of type 'text_answer' can not be displayed using a choice view");
    }
  }

  final int questionId;
  late final Question question;
  final ComprehensionMeasurementModel model;
  late final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

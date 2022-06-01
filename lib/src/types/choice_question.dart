import 'package:comprehension_measurement/src/models/answer.dart';
import 'package:comprehension_measurement/src/models/comprehension_measurement.dart';
import 'package:comprehension_measurement/src/models/question.dart';
import 'package:comprehension_measurement/src/types/multi_choice.dart';
import 'package:comprehension_measurement/src/types/single_choice.dart';
import 'package:flutter/material.dart';

class ChoiceQuestionWidget extends StatelessWidget {
  ChoiceQuestionWidget({
    Key? key,
    required this.questionId,
    required this.model,
    this.questionContext,
  }) {
    question = model.survey!.questions
        .firstWhere((question) => question.id == questionId);

    if (question.is_contextual) {
      for (Answer answer in question.answers) {
        answer.is_right =
            questionContext![question.context]!.contains(answer.answer_text);
      }
    }
    switch (question.type) {
      case QuestionType.single_choice:
        child = SingleChoiceWidget(
          question: question,
          model: model,
          questionId: questionId,
        );
        break;
      case QuestionType.multiple_choice:
        child = MultipleChoiceWidget(
          question: question,
          model: model,
          questionId: questionId,
        );
        break;
    }
  }

  final int questionId;
  late Question question;
  final ComprehensionMeasurementModel model;
  final Map<String, List<String>>? questionContext;
  late final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

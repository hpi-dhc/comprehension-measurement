import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';

part 'question.g.dart';

enum QuestionType {
  single_choice,
  multiple_choice,
  text_answer,
}

@JsonSerializable()
class Question {
  Question({
    required this.id,
    required this.title,
    required this.type,
    required this.answers,
    required this.is_contextual,
    this.context,
  });

  int id;
  String title;
  QuestionType type;
  List<Answer> answers;
  bool is_contextual;
  String? context;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

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
  Question(this.id, this.title, this.type, this.answers);

  int id;
  String title;
  QuestionType type;
  List<Answer> answers;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

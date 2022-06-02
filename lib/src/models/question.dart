import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';

part 'question.g.dart';

enum QuestionType {
  @JsonValue('single_choice')
  singleChoice,
  @JsonValue('multiple_choice')
  multipleChoice,
  @JsonValue('text_answer')
  textAnswer,
}

@JsonSerializable()
class Question {
  Question({
    required this.id,
    required this.title,
    required this.type,
    required this.answers,
    required this.isContextual,
    this.context,
  });

  int id;
  String title;
  QuestionType type;
  List<Answer> answers;

  @JsonKey(name: 'is_contextual')
  bool isContextual;
  String? context;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  Answer(
    this.id,
    this.is_right,
    this.answer_text,
    this.times_selected,
  );

  int id;
  bool? is_right;
  String answer_text;
  int times_selected;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

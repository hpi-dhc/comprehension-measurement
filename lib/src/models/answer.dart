import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  Answer(
    this.id,
    this.isCorrect,
    this.answerText,
    this.timesSelected,
  );

  int id;
  @JsonKey(name: 'is_correct')
  bool? isCorrect;

  @JsonKey(name: 'answer_text')
  String answerText;

  @JsonKey(name: 'times_selected')
  int timesSelected;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

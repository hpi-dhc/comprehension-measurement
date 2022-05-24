import 'package:comprehension_measurement/src/models/question.dart';
import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'survey.g.dart';

@JsonSerializable()
class Survey {
  Survey(this.id, this.title, this.questions);

  int id;
  String title;
  List<Question> questions;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}

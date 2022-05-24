// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) => Survey(
      json['id'] as int,
      json['title'] as String,
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questions': instance.questions,
    };

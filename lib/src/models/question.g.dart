// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['id'] as int,
      json['title'] as String,
      $enumDecode(_$QuestionTypeEnumMap, json['type']),
      (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$QuestionTypeEnumMap[instance.type],
      'answers': instance.answers,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.single_choice: 'single_choice',
  QuestionType.multiple_choice: 'multiple_choice',
  QuestionType.text_answer: 'text_answer',
};

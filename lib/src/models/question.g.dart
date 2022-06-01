// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      title: json['title'] as String,
      type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_contextual: json['is_contextual'] as bool,
      context: json['context'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$QuestionTypeEnumMap[instance.type],
      'answers': instance.answers,
      'is_contextual': instance.is_contextual,
      'context': instance.context,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.single_choice: 'single_choice',
  QuestionType.multiple_choice: 'multiple_choice',
  QuestionType.text_answer: 'text_answer',
};

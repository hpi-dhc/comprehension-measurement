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
      isContextual: json['is_contextual'] as bool,
      context: json['context'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$QuestionTypeEnumMap[instance.type],
      'answers': instance.answers,
      'is_contextual': instance.isContextual,
      'context': instance.context,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'single_choice',
  QuestionType.multipleChoice: 'multiple_choice',
  QuestionType.textAnswer: 'text_answer',
};

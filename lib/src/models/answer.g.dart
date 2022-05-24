// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      json['id'] as int,
      json['is_right'] as bool?,
      json['answer_text'] as String,
      json['times_selected'] as int,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'is_right': instance.is_right,
      'answer_text': instance.answer_text,
      'times_selected': instance.times_selected,
    };

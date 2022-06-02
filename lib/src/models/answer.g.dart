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
      'is_right': instance.isRight,
      'answer_text': instance.answerText,
      'times_selected': instance.timesSelected,
    };

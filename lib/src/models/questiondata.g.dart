// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questiondata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionDataAdapter extends TypeAdapter<QuestionData> {
  @override
  final int typeId = 14;

  @override
  QuestionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionData()
      ..completedQuestions = (fields[0] as Set).cast<int>()
      ..completedSurveys = (fields[1] as Set).cast<int>();
  }

  @override
  void write(BinaryWriter writer, QuestionData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.completedQuestions.toList())
      ..writeByte(1)
      ..write(obj.completedSurveys.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
    return QuestionData()..questionIds = (fields[0] as List?)?.cast<int>();
  }

  @override
  void write(BinaryWriter writer, QuestionData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.questionIds);
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surveydata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyDataAdapter extends TypeAdapter<SurveyData> {
  @override
  final int typeId = 14;

  @override
  SurveyData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveyData()
      ..completedQuestions = (fields[0] as List).cast<int>()
      ..completedSurveys = (fields[1] as List).cast<int>()
      ..optOut = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, SurveyData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.completedQuestions)
      ..writeByte(1)
      ..write(obj.completedSurveys)
      ..writeByte(2)
      ..write(obj.optOut);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

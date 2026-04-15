// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 0;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as int,
      target: fields[1] as String,
      completedDates: (fields[8] as List).cast<DateTime>(),
      subjectAnswers: fields[4] as String,
      answers: (fields[3] as List).cast<String>(),
      answersCounts: (fields[5] as List).cast<int>(),
      datesIdx: (fields[9] as List).cast<int>(),
      isAllweek: fields[10] as bool,
      selectedOptions: (fields[6] as List).cast<int>(),
    )
      ..answerTypeIndex = fields[2] as int
      ..datesList = (fields[7] as List).cast<DateTime>();
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.target)
      ..writeByte(2)
      ..write(obj.answerTypeIndex)
      ..writeByte(3)
      ..write(obj.answers)
      ..writeByte(4)
      ..write(obj.subjectAnswers)
      ..writeByte(5)
      ..write(obj.answersCounts)
      ..writeByte(6)
      ..write(obj.selectedOptions)
      ..writeByte(7)
      ..write(obj.datesList)
      ..writeByte(8)
      ..write(obj.completedDates)
      ..writeByte(9)
      ..write(obj.datesIdx)
      ..writeByte(10)
      ..write(obj.isAllweek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPromotionAdapter extends TypeAdapter<SavedPromotion> {
  @override
  final int typeId = 0;

  @override
  SavedPromotion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPromotion(
      collectionName: fields[1] as String,
      subCategory: fields[2] as String,
      nameSubCategory: fields[3] as String,
      creatTime: fields[4] as String,
      meterage: fields[5] as String,
      roomCount: fields[6] as String,
      floor: fields[7] as String,
      yearBuilt: fields[8] as String,
      hasElevator: fields[9] as bool,
      hasParking: fields[10] as bool,
      hasStorage: fields[11] as bool,
      hasPool: fields[12] as bool,
      location: fields[13] as String,
      showExactLocation: fields[14] as bool,
      thumbnailUrl: fields[15] as dynamic,
      title: fields[16] as String,
      description: fields[17] as String,
      phoneNumber: fields[18] as String,
      chatEnabled: fields[19] as bool,
      callEnabled: fields[20] as bool,
      price: fields[21] as int,
      userOwner: fields[22] as String?,
    )..pricePerMeter = fields[23] as num?;
  }

  @override
  void write(BinaryWriter writer, SavedPromotion obj) {
    writer
      ..writeByte(23)
      ..writeByte(1)
      ..write(obj.collectionName)
      ..writeByte(2)
      ..write(obj.subCategory)
      ..writeByte(3)
      ..write(obj.nameSubCategory)
      ..writeByte(4)
      ..write(obj.creatTime)
      ..writeByte(5)
      ..write(obj.meterage)
      ..writeByte(6)
      ..write(obj.roomCount)
      ..writeByte(7)
      ..write(obj.floor)
      ..writeByte(8)
      ..write(obj.yearBuilt)
      ..writeByte(9)
      ..write(obj.hasElevator)
      ..writeByte(10)
      ..write(obj.hasParking)
      ..writeByte(11)
      ..write(obj.hasStorage)
      ..writeByte(12)
      ..write(obj.hasPool)
      ..writeByte(13)
      ..write(obj.location)
      ..writeByte(14)
      ..write(obj.showExactLocation)
      ..writeByte(15)
      ..write(obj.thumbnailUrl)
      ..writeByte(16)
      ..write(obj.title)
      ..writeByte(17)
      ..write(obj.description)
      ..writeByte(18)
      ..write(obj.phoneNumber)
      ..writeByte(19)
      ..write(obj.chatEnabled)
      ..writeByte(20)
      ..write(obj.callEnabled)
      ..writeByte(21)
      ..write(obj.price)
      ..writeByte(22)
      ..write(obj.userOwner)
      ..writeByte(23)
      ..write(obj.pricePerMeter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPromotionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

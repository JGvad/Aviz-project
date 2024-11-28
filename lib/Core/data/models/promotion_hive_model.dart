import 'package:hive_flutter/hive_flutter.dart';
part 'promotion_hive_model.g.dart';

@HiveType(typeId: 0)
class SavedPromotion {
  @HiveField(1)
  final String collectionName;
  @HiveField(2)
  final String subCategory;
  @HiveField(3)
  final String nameSubCategory;
  @HiveField(4)
  final String creatTime;
  @HiveField(5)
  final String meterage;
  @HiveField(6)
  final String roomCount;
  @HiveField(7)
  final String floor;
  @HiveField(8)
  final String yearBuilt;
  @HiveField(9)
  final bool hasElevator;
  @HiveField(10)
  final bool hasParking;
  @HiveField(11)
  final bool hasStorage;
  @HiveField(12)
  final bool hasPool;
  @HiveField(13)
  final String location;
  @HiveField(14)
  final bool showExactLocation;
  @HiveField(15)
  final dynamic thumbnailUrl;
  @HiveField(16)
  final String title;
  @HiveField(17)
  final String description;
  @HiveField(18)
  final String phoneNumber;
  @HiveField(19)
  final bool chatEnabled;
  @HiveField(20)
  final bool callEnabled;
  @HiveField(21)
  final int price;
  @HiveField(22)
  String? userOwner;
  @HiveField(23)
  num? pricePerMeter;

  SavedPromotion(
      {required this.collectionName,
      required this.subCategory,
      required this.nameSubCategory,
      required this.creatTime,
      required this.meterage,
      required this.roomCount,
      required this.floor,
      required this.yearBuilt,
      required this.hasElevator,
      required this.hasParking,
      required this.hasStorage,
      required this.hasPool,
      required this.location,
      required this.showExactLocation,
      required this.thumbnailUrl,
      required this.title,
      required this.description,
      required this.phoneNumber,
      required this.chatEnabled,
      required this.callEnabled,
      required this.price,
      required this.userOwner}) {
    pricePerMeter = ((price ~/ int.parse(meterage) ~/ 100) * 100);
  }
}

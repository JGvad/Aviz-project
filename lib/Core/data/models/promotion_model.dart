import 'package:aviz/Constants/string_constant.dart';

class PromotionModel {
  final String collectionName;
  final String subCategory;
  final String nameSubCategory;
  final String creatTime;
  final String meterage;
  final String roomCount;
  final String floor;
  final String yearBuilt;
  final bool hasElevator;
  final bool hasParking;
  final bool hasStorage;
  final bool hasPool;
  final String location;
  final bool showExactLocation;
  final dynamic thumbnailUrl;
  final String title;
  final String description;
  final String phoneNumber;
  final bool chatEnabled;
  final bool callEnabled;
  final int price;
  final String? userOwner;
  num? pricePerMeter;

  PromotionModel({
    required this.collectionName,
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
    required this.userOwner,
  }) {
    pricePerMeter = ((price ~/ int.parse(meterage) ~/ 100) * 100);
  }

  factory PromotionModel.fromJson(Map<String, dynamic> jsonMapObject) {
    return PromotionModel(
      collectionName: jsonMapObject['collectionName'],
      subCategory: jsonMapObject['subCategory'],
      nameSubCategory: jsonMapObject['expand']['subCategory']['name'],
      creatTime: jsonMapObject['created'],
      meterage: jsonMapObject['meterage'],
      roomCount: jsonMapObject['roomCount'],
      floor: jsonMapObject['floor'],
      yearBuilt: jsonMapObject['yearBuilt'],
      hasElevator: jsonMapObject['hasElevator'],
      hasParking: jsonMapObject['hasParking'],
      hasStorage: jsonMapObject['hasStorage'],
      hasPool: jsonMapObject['hasPool'],
      location: jsonMapObject['location'],
      showExactLocation: jsonMapObject['showExactLocation'],
      thumbnailUrl:
          '${StringConstant.baseUrl}/files/${jsonMapObject['collectionId'] ?? ''}/${jsonMapObject['id'] ?? ''}/${jsonMapObject['thumbnail'] ?? ''}',
      title: jsonMapObject['title'],
      description: jsonMapObject['description'],
      phoneNumber: jsonMapObject['phoneNumber'],
      callEnabled: jsonMapObject['callEnabled'],
      chatEnabled: jsonMapObject['chatEnabled'],
      userOwner: jsonMapObject['userOwner'],
      price: int.parse(
        jsonMapObject['price'],
      ),
    );
  }
}

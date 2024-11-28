import 'dart:io';

class TemporaryPromotionModel {
  static final TemporaryPromotionModel _instance =
      TemporaryPromotionModel._internal();
  String? subCategoryId;
  String? meterage;
  String? roomCount;
  String? floor;
  String? yearBuilt;
  bool? hasElevator;
  bool? hasParking;
  bool? hasStorage;
  bool? hasPool;
  String? location;
  bool? showExactLocation;
  File? thumbnailUrl;
  String? title;
  String? description;
  String? phoneNumber;
  bool? chatEnabled;
  bool? callEnabled;
  String? price;
  TemporaryPromotionModel._internal();

  static TemporaryPromotionModel get instance => _instance;

  void clear() {
    subCategoryId = null;
    meterage = null;
    roomCount = null;
    floor = null;
    yearBuilt = null;
    hasElevator = null;
    hasParking = null;
    hasStorage = null;
    hasPool = null;
    location = null;
    showExactLocation = null;
    thumbnailUrl = null;
    title = null;
    description = null;
    phoneNumber = null;
    chatEnabled = null;
    callEnabled = null;
    price = null;
  }
}

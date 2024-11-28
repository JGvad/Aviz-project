import 'package:aviz/Constants/string_constant.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final dynamic thumbnail;
  final bool isValidUser;
  UserModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.thumbnail,
      required this.isValidUser});
  factory UserModel.fromJson(Map<String, dynamic> jsonMapObject) {
    return UserModel(
      id: jsonMapObject['id'],
      name: jsonMapObject['name'],
      phone: jsonMapObject['phone'],
      isValidUser: jsonMapObject['isValid'],
      thumbnail:
          '${StringConstant.baseUrl}/files/${jsonMapObject['collectionId'] ?? ''}/${jsonMapObject['id'] ?? ''}/${jsonMapObject['thumbnail'] ?? ''}',
    );
  }
}

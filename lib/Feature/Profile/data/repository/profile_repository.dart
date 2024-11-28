import 'dart:io';

import 'package:aviz/Feature/Profile/data/datasource/profile_datasource.dart';
import 'package:aviz/Feature/Profile/data/model/user_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProfileRepository {
  Future<Either<String, UserModel>> getUserInfo(String userId);
  Future<Either<String, String>> editUserInfo({
    required String userId,
    required String name,
    required String phone,
    required File thumbnail,
  });
}

class ProfileRepository extends IProfileRepository {
  final IProfileDatasource _dataRemote;
  ProfileRepository(this._dataRemote);
  @override
  Future<Either<String, UserModel>> getUserInfo(String userId) async {
    try {
      final UserModel user = await _dataRemote.getUserInfo(userId: userId);
      return right(user);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }

  @override
  Future<Either<String, String>> editUserInfo(
      {required String userId,
      required String name,
      required String phone,
      required File thumbnail}) async {
    try {
      final String result = await _dataRemote.editUserInfo(
        userId: userId,
        name: name,
        phone: phone,
        thumbnail: thumbnail,
      );
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }
}

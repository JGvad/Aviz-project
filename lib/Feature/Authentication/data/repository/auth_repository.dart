import 'package:aviz/Feature/Authentication/data/datasource/auth_datasource.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> registerUser({
    required String username,
    required String name,
    required String password,
    required String passwordConfirm,
    required String phone,
  });
  Future<Either<String, String>> loginUser(String username, String password);
}

class AuthRepository extends IAuthRepository {
  final IAuthDatasource _authDatasource;
  AuthRepository(this._authDatasource);
  @override
  Future<Either<String, String>> loginUser(
      String username, String password) async {
    try {
      final result = await _authDatasource.loginUser(username, password);
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }

  @override
  Future<Either<String, String>> registerUser({
    required String username,
    required String name,
    required String password,
    required String passwordConfirm,
    required String phone,
  }) async {
    try {
      final result = await _authDatasource.registerUser(
        username: username,
        name: name,
        phone: phone,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی برای خطا تعریف نشده');
    }
  }
}

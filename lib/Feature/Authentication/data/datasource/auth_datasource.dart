import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:aviz/UtilNetwork/dio_provider.dart';
import 'package:dio/dio.dart';

abstract class IAuthDatasource {
  Future<String> registerUser({
    required String username,
    required String name,
    required String password,
    required String passwordConfirm,
    required String phone,
  });
  Future<String> loginUser(String username, String password);
}

class AuthDatasource extends IAuthDatasource {
  final Dio _dio = DioProvider.creatDioWithOutHeader();

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      final Response response = await _dio.post(
        '/collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        await AuthManagement.saveToken(response.data['token']);
        await AuthManagement.saveUserId(response.data['record']['id']);

        return 'وارد حساب کاربری شدید';
      }
    } on DioException catch (ex) {
      throw ApiException(
        message: ex.response!.data['message'],
        statusCode: ex.response!.statusCode,
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(message: 'unknown error', statusCode: 0);
    }
    return '';
  }

  @override
  Future<String> registerUser({
    required String username,
    required String name,
    required String password,
    required String passwordConfirm,
    required String phone,
  }) async {
    try {
      final Response response = await _dio.post(
        '/collections/users/records',
        data: {
          'username': username,
          'name': name,
          'password': password,
          'passwordConfirm': password,
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        await loginUser(username, password);

        return 'ثبت نام با موفقیت انجام شد';
      }
    } on DioException catch (ex) {
      throw ApiException(
        message: ex.response!.data['message'],
        statusCode: ex.response!.statusCode,
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(message: 'unknown error', statusCode: 0);
    }
    return '';
  }
}

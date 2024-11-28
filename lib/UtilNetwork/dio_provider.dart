import 'package:aviz/Constants/string_constant.dart';
import 'package:aviz/UtilNetwork/auth_management.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Future<Dio> creatDio() async {
    String? token = await AuthManagement.readToken();
    return Dio(
      BaseOptions(
        baseUrl: StringConstant.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Baerer $token}'
        },
      ),
    );
  }

  static Dio creatDioWithOutHeader() {
    return Dio(
      BaseOptions(
        baseUrl: StringConstant.baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}

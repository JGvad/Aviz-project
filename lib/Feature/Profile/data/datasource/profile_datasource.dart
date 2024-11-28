import 'package:aviz/Feature/Profile/data/model/user_model.dart';
import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:aviz/UtilNetwork/map_handler.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class IProfileDatasource {
  Future<UserModel> getUserInfo({required String userId});
  Future<String> editUserInfo({
    required String userId,
    required String name,
    required String phone,
    required dynamic thumbnail,
  });
}

class ProfileDataRemote extends IProfileDatasource {
  final Dio _dio;
  ProfileDataRemote(this._dio);
  @override
  Future<UserModel> getUserInfo({required String userId}) async {
    final Map<String, String> qParamt = {'filter': 'id = "$userId"'};
    try {
      final Response response = await _dio.get('/collections/users/records',
          queryParameters: qParamt);
      final UserModel user = MapHandler.mapSingleObjectFromJson(
          response.data['items'], UserModel.fromJson);
      return user;
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response!.data['message'],
          statusCode: ex.response!.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }

  @override
  Future<String> editUserInfo({
    required String userId,
    required String name,
    required String phone,
    required dynamic thumbnail,
  }) async {
    final updateData = FormData.fromMap(
      {
        'name': name,
        'phone': phone,
      },
    );

    updateData.files.add(
      MapEntry(
        'thumbnail',
        MultipartFile.fromFileSync(
          thumbnail.path,
          filename: thumbnail.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      ),
    );
    try {
      final Response response = await _dio.patch(
        '/collections/users/records/$userId',
        data: updateData,
      );

      if (response.statusCode == 200) {
        return 'تغییرات اعمال شد';
      } else {
        throw ApiException(
          message: 'Failed with status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        );
      }
    } on DioException catch (ex) {
      throw Exception(ex.response!.data['message']);
      // throw ApiException(
      //   message: ex.response?.data['message'] ?? 'خطای ناشناخته',
      //   statusCode: ex.response?.statusCode ?? 0,
      // );
    } catch (ex) {
      throw ex;
      // throw ApiException(message: 'unknown exception', statusCode: 0);
    }
  }
}

import 'dart:io';

import 'package:aviz/UtilNetwork/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class IAddPromotionDatasource {
  Future<String> addPromotion({
    required String title,
    required String description,
    required File thumbnail,
    required String price,
    required String meterage,
    required String roomCount,
    required String floor,
    required String yearBuilt,
    required String location,
    required String subCategoryId,
    required String phoneNumber,
    required bool hasElevator,
    required bool hasParking,
    required bool hasStorage,
    required bool showExactLocation,
    required bool chatEnabled,
    required bool callEnabled,
    required bool isHot,
    required bool hasPool,
    required String userOwner,
  });
}

class AddPromotionRemote extends IAddPromotionDatasource {
  final Dio _dio;
  AddPromotionRemote(this._dio);

  @override
  Future<String> addPromotion(
      {required String title,
      required String description,
      required File thumbnail,
      required String price,
      required String meterage,
      required String roomCount,
      required String floor,
      required String yearBuilt,
      required String location,
      required String subCategoryId,
      required String phoneNumber,
      required bool hasElevator,
      required bool hasParking,
      required bool hasStorage,
      required bool showExactLocation,
      required bool chatEnabled,
      required bool callEnabled,
      required bool isHot,
      required bool hasPool,
      required String userOwner}) async {
    final fromData = FormData.fromMap(
      {
        'title': title,
        'description': description,
        'price': int.parse(price),
        'meterage': int.parse(meterage),
        'roomCount': roomCount,
        'floor': floor,
        'yearBuilt': yearBuilt,
        'location': location,
        'subCategory': subCategoryId,
        'phoneNumber': phoneNumber,
        'hasElevator': hasElevator,
        'hasParking': hasParking,
        'hasStorage': hasStorage,
        'showExactLocation': showExactLocation,
        'chatEnabled': chatEnabled,
        'callEnabled': callEnabled,
        'isHot': isHot,
        'hasPool': hasPool,
        'userOwner': userOwner
      },
    );
    fromData.files.add(
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
      final Response response =
          await _dio.post('/collections/Prmotion/records', data: fromData);
      if (response.statusCode == 200) {
        return 'با موفقیت ثبت شد';
      }
    } on DioException catch (ex) {
      throw ApiException(
          message: ex.response!.data['message'],
          statusCode: ex.response!.statusCode);
    } catch (ex) {
      throw ApiException(message: 'unknown exception', statusCode: 0);
    }
    return '';
  }
}

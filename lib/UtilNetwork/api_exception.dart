import 'package:dio/dio.dart';

class ApiException {
  String? message;
  int? statusCode;
  Response? response;
  ApiException({this.message, this.statusCode, this.response}) {
    if (statusCode != 400) {
      return;
    }
    //register handling error
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است !';
    }
    //username component
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'نام کاربری دیگری انتخاب کنید';
        }
        if (response?.data['data']['username']['message'] ==
            'Must be in a valid format.') {
          message = 'نام کاربری نامعتیر ';
        }
      }
      //password component
      if (response?.data['data']['passwordConfirm'] != null) {
        if (response!.data['data']['passwordConfirm']['message'] ==
            'Values don\'t match.') {
          message = 'مقادیر رمز باهم مطابقت ندارند';
        }
      }
    }
    //login handling error
    //username component
    if (message == 'Something went wrong while processing your request.') {
      if (response!.data['data']['identity'] != null) {
        if (response!.data['data']['identity']['message'] ==
            'Cannot be blank.') {
          message = 'لطفا موارد خواسته شده را پر کنید';
        }
      }
      //password component
      if (response!.data['data']['password'] != null) {
        if (response!.data['data']['identity']['message'] ==
            'Cannot be blank.') {
          message = 'لطفا موارد خواسته شده را پر کنید';
        }
      }
    }
  }
}

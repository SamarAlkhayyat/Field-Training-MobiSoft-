import 'package:dio/dio.dart';
import 'dart:convert';

class LoginWebServices {
  String baseUrl = 'http://192.168.2.242:7001/MOBILE_SERVICES/resources/moi_services/';
  late Dio dio;

  LoginWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20), //seconds
      receiveTimeout: Duration(seconds: 20)
    );

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> loginData) async {
    try {
      Response response = await dio.post('login',
        data: json.encode(loginData),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print(response.data.toString());
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } catch (e) {
      print("web service error ${e.toString()}");
      return {};
    }
  }
}
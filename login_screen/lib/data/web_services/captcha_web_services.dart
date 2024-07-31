import 'package:dio/dio.dart';
import 'dart:convert';

class CaptchaWebServices {
  String baseUrl = 'http://192.168.2.242:7001/MOBILE_SERVICES/resources/moi_services/';
  late Dio dio;

  CaptchaWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20), //seconds
      receiveTimeout: Duration(seconds: 20)
    );

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> generateCaptcha() async{
    Map<String, dynamic> params = {"CaptchaUsage": "LOGIN"};

    try{
      Response response = await dio.post('GenerateCaptcha',
        data: params,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print("response data image ${response.data.toString()}");

      print(response.data.toString());
      Map<String, dynamic> captchaData = response.data;
      return captchaData;
    }catch(e){
      print("web service error ${e.toString()}");
      return {};
    }
  }
}
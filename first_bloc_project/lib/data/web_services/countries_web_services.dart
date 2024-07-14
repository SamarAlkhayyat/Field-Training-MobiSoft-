import 'package:dio/dio.dart';
import 'dart:convert';

class CountriesWebServices {
  String baseUrl = 'https://62bd3bdc-5889-4a65-a888-36c03c347e98.mock.pstmn.io/';
  late Dio dio;

  CountriesWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20), //seconds
      receiveTimeout: Duration(seconds: 20)
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCountries() async{
    try{
      Response response = await dio.get('getCompanyEmployees');
      print(response.data.toString());
      List<dynamic> itemList = jsonDecode(response.data); // Parse JSON string into List<dynamic>
      return itemList; // Return as Future<List<dynamic>>
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}
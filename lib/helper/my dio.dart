import 'package:dio/dio.dart';

class DioHelper{

  static Dio ?dio;
  static init(){
    dio=Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl:'https://maps.googleapis.com/maps/api/place/autocomplete/json'

      ),
    );
  }


  static Future<Response> GetData({
    required String path,
    required Map<String,dynamic> query
})async{
    return await dio!.get(
      path,
      queryParameters: query
    );
  }

}
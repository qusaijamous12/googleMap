import 'package:dio/dio.dart';

class Diohelper{
  static Dio ?dio;

  static init()async{
   dio=Dio(
     BaseOptions(
       receiveDataWhenStatusError: true,
     )
   );
  }

  static Future<Response> getData({
    required String path,
    required Map<String,dynamic> query
})async{
    return await dio!.get(
      path,
      queryParameters: query

    );
  }


}
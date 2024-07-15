import 'package:dio/dio.dart';
import 'package:task1/constant/constant.dart';
//Places web services
class PlacesWebServices{
  late Dio ?dio;

  PlacesWebServices(){
    BaseOptions options=BaseOptions(
      receiveDataWhenStatusError: true
    );
    dio=Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions({
    String ?place,
    String ?sessionToken
})async{
    try
    {
      Response response=await dio!.get(
        url,
        queryParameters: {
        'input':place,
          'types':'address',
          'components':'country:eg',
          'sessiontoken':sessionToken,
          'key':googleApi
        }

      );
      return response.data['predictions'];

    }
    catch(e){
      print(e.toString());
      return [];

    }

  }




}

////https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&types=geocode&language=fr&key=YOUR_API_KEY
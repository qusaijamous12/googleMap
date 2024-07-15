import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/maps/cubit/state.dart';
import '../../helper/my dio.dart';
import '../../model/placeModelId.dart';
import '../../model/serachModel.dart';

class MapCubit extends Cubit<MapsState>{

  MapCubit():super(InitialMapState());

  static MapCubit get(context)=>BlocProvider.of(context);

  Autogenerated ?autogenerated;
  List<dynamic> serach=[];

  void getData({
    required String value
  }){
    DioHelper.GetData(
        path: 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        query: {
          'input':'${value}',
          'types':'address',
          'components':'country:us',
          'sessiontoken':'asknaksdqwdqjka',
          'key':'AIzaSyBGI1eAkoZxZjlwy523NyuVokdv0hCl_k8'
        }).then((value) {
      autogenerated=Autogenerated.fromJson(value.data);
      print('qusai');
      emit(GetDataSerachSuccessState());


    }).catchError((error){
      print(error.toString());
      print('qusaiss');
      emit(GetDataSerachErrorState());
    });
  }

  PlaceId ?placeId;

  void getLocationOnMap({
    required String placeIdd
}){
    DioHelper.GetData(
        path: 'https://maps.googleapis.com/maps/api/place/details/json',
        query: {
          'place_id':'${placeIdd}',
          'fields':'geometry',
          'key':'AIzaSyBGI1eAkoZxZjlwy523NyuVokdv0hCl_k8'

        }).then((value) {
      placeId=PlaceId.fromJson(value.data);
      print(placeId!.result!.geometry!.location!.lat);
      print(placeId!.result!.geometry!.location!.lng);
      emit(GetInfoPlaceIdSuccess());

    }).catchError((error){
      print(error.toString());
      emit(GetInfoPlaceIdError());

    });
  }









}
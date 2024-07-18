import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:task1/helper/locatedHelper.dart';
import 'package:task1/map/cubit/cubit.dart';
import 'package:task1/map/cubit/state.dart';
import 'package:task1/models/serachModel.dart';

class MapScreen extends StatelessWidget {

  Completer<GoogleMapController> mapController=Completer();
  Future<void> goToMyCurrentLocation(context)async{
    final GoogleMapController controller=await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(MapCubit.get(context).myCameraPosition!));

  }

  Future<void> goToMyNewCurrentLocation(context)async{
    final GoogleMapController controller=await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(MapCubit.get(context).myNewCameraPosition!));

  }

  var floatingController=FloatingSearchBarController();

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit,MapState>(
      listener: (context,MapState){

      },
      builder: (context,MapState){
        var cubit=MapCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ConditionalBuilder(
                    condition: MapState is! LoadingGetMyLocationState,
                    builder: (context)=> GoogleMap(
                      mapType: MapType.normal,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller){
                        mapController.complete(controller);
                        },
                        initialCameraPosition:cubit.myCameraPosition!,
                       markers: MapCubit.get(context).marker,
            
                    ),
                    fallback: (context)=>Center(child: CircularProgressIndicator())),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 20
                  ),
                  child: buildFloatingSearchBar(context),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                        onPressed: (){
                        goToMyCurrentLocation(context);
            
                    },
                      child: Icon(
                        Icons.place,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            
              ],
            ),
          ),
        );
      },
    );

  }
  Widget buildSerachItem(Predictions prediction,context)=>InkWell(
    onTap: (){

      MapCubit.get(context).getPlaceId(placeId: prediction.placeId!,info: prediction.description!);
      floatingController.close();

    },
    child: Row(
      children: [


        Expanded(
          child: Material(
            elevation: 10,
            child: Container(
              height: 50,
              padding: EdgeInsetsDirectional.symmetric(
                  vertical: 10,
                  horizontal: 10
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  border: Border.all(
                      color: Colors.white
                  )
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    color: Colors.black,
                  ),
                  Text(
                    '${prediction.description}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
  Widget buildFloatingSearchBar(context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(

      hint: 'Search...',
      controller: floatingController,
      scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.fastEaseInToSlowEaseOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        MapCubit.get(context).serachPlaces(text: query);
        goToMyNewCurrentLocation(context);

      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.back(),
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),

      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConditionalBuilder(
                    condition: MapCubit.get(context).autogenerated!=null,
                    builder: (context)=>ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildSerachItem(MapCubit.get(context).autogenerated!.predictions![index],context),
                        separatorBuilder: (context,index)=>SizedBox(
                          height: 15,
                        ),
                        itemCount: MapCubit.get(context).autogenerated!.predictions!.length),
                    fallback: (context)=>Center(child: CircularProgressIndicator()))
              ],
            ),
          )
        );
      },
    );
  }

}

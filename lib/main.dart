import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/constant/constant.dart';
import 'package:task1/helper/my%20dio.dart';
import 'package:task1/maps/cubit/cubit.dart';
import 'package:task1/maps/home.dart';

import 'constant/observer.dart';
import 'helper/dioHelper.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>MapCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: MapScreen(),
          ),
        ),
      ),
    );
  }
}



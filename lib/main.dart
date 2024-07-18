import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/helper/diohelper.dart';
import 'package:task1/map/cubit/cubit.dart';
import 'package:task1/map/loginscreen/loginscreen.dart';
import 'package:task1/map/mapScreen/map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task1/map/otbscreen/otp_screen.dart';
import 'constant/observer.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  Diohelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>MapCubit()..getMyCurrentLocation()),
      ],
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



import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/map/loginscreen/cubit/state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(InitialLoginState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  void loginUsingPhone({
    required String phone
}){
    FirebaseAuth.instance.signInWithPhoneNumber(phone).then((value){
      emit(LoginSuccessState());

    }).catchError((error){
      print(error.toString());

      emit(LoginErrorState());

    });

  }

}
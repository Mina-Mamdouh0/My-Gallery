

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gellery/Core/helper/shared_pref_services.dart';
import 'package:my_gellery/Core/unit/constant_data.dart';
import 'package:my_gellery/Feather/auth/data/model/login_model.dart';
import 'package:my_gellery/Feather/auth/data/repository/auth_repository.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit() : super(AppInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  void login({required String email , required String password}){
    emit(LoadingLoginState());
    Map<String ,String > body={
      'email':email,
      'password':password,
    };
    AuthRepository.login(body: body,)
        .then((value){

      if(value.runtimeType==LoginModel){
        SharedPreferencesServices.setDate(key: ConstantData.kLogin, value: true);
        SharedPreferencesServices.setDate(key: ConstantData.kToken, value: value.token??'');
        SharedPreferencesServices.setDate(key: ConstantData.kName, value: value.loginUserModel?.name??'');
        emit(SuccessLoginState());
        debugPrint('Success Login');
      }else{
        debugPrint('Failed Login ');
        emit(FailedLoginState(errorModel: value));
      }
    }).onError((error, stackTrace){
      debugPrint('Error Login : ${error.toString()}');
      emit(ErrorLoginState());
    });
  }

  void logout(){
    SharedPreferencesServices.removeDate(key: ConstantData.kToken);
    SharedPreferencesServices.removeDate(key: ConstantData.kLogin);
    SharedPreferencesServices.removeDate(key: ConstantData.kName);
    emit(SuccessLogoutState());
  }



}








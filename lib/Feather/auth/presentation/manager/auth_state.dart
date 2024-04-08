
import 'package:my_gellery/Feather/auth/data/model/error_model.dart';

abstract class AuthState{}

class AppInitialState extends AuthState{}

class LoadingLoginState extends AuthState{}
class SuccessLoginState extends AuthState{}
class FailedLoginState extends AuthState{
  ErrorModel? errorModel;
  FailedLoginState({this.errorModel});
}
class ErrorLoginState extends AuthState{}

class SuccessLogoutState extends AuthState{}

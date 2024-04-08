
import 'package:my_gellery/Core/api/constant_api.dart';
import 'package:my_gellery/Core/api/http_services.dart';
import 'package:my_gellery/Feather/auth/data/model/error_model.dart';
import 'package:my_gellery/Feather/auth/data/model/login_model.dart';

class AuthRepository{
  static Future login({required Map<String,String> body,}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}auth/login',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,body: body);
    if(data['token'] !=null){
      LoginModel loginModel = LoginModel.jsonData(data);
      return loginModel;
    }else{
      ErrorModel errorModel = ErrorModel.jsonData(data);
      return errorModel;
    }
  }
}
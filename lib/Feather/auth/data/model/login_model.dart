
class LoginModel{
  LoginUserModel? loginUserModel;
  String ? token;

  LoginModel({this.loginUserModel, this.token});

  factory LoginModel.jsonData(data){
    return LoginModel(
      token: data['token'],
      loginUserModel: data['user']!=null ? LoginUserModel.jsonData(data['user']): null
    );
  }


}

class LoginUserModel{
  int ? id;
  String ? name;
  String ? email;
  String ? emailVerifiedAt;
  String ? createdAt;
  String ? updatedAt;

  LoginUserModel({this.id,this.name,this.createdAt,this.email,this.updatedAt,this.emailVerifiedAt});

  factory LoginUserModel.jsonData(data){
    return LoginUserModel(
      id: data['id'],
      name: data['name'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      email: data['email'],
      emailVerifiedAt: data['email_verified_at'],
    );
  }


}


class ErrorModel{
  String ? message;
  ErrorsModel ? errorsModel;

  ErrorModel({this.errorsModel,this.message});

  factory ErrorModel.jsonData(data){
    return ErrorModel(
    message: data['message'],
    errorsModel: data['errors']!=null ? ErrorsModel.jsonData(data['errors']): null,
    );
}

}

class ErrorsModel{
  String ? email;

  ErrorsModel({this.email});

  factory ErrorsModel.jsonData(data){
    return ErrorsModel(
    email: data['email']!=null ? data['email'][0] : null
    );
}

}
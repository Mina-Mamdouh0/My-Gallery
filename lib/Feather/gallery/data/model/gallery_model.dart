
class GalleryModel{
  String ? status;
  String ? message;
  DataGalleryModel  ? dataGalleryModel;

  GalleryModel({this.status, this.message,this.dataGalleryModel});

  factory GalleryModel.jsonData(data){
    return GalleryModel(
        status: data['status'],
        message: data['message'],
        dataGalleryModel: data['data']!=null ? DataGalleryModel.jsonData(data['data']): null
    );
  }
}

class DataGalleryModel{
  List ? images;

  DataGalleryModel({this.images,});

  factory DataGalleryModel.jsonData(data){
    return DataGalleryModel(
        images: data['images'],
    );
  }
}

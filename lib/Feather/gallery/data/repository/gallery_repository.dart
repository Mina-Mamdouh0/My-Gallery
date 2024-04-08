
import 'package:my_gellery/Core/api/constant_api.dart';
import 'package:my_gellery/Core/api/http_services.dart';
import 'package:my_gellery/Feather/auth/data/model/error_model.dart';
import 'package:my_gellery/Feather/auth/data/model/login_model.dart';
import 'package:my_gellery/Feather/gallery/data/model/gallery_model.dart';

class GalleryRepository{
  static Future<GalleryModel?> getMyGallery({required String token,}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}my-gallery',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,headers: {
      'Authorization': 'Bearer $token'
    });
    if((data['status']??'') =='success'){
      GalleryModel galleryModel = GalleryModel.jsonData(data);
      return galleryModel;
    }
  }
}
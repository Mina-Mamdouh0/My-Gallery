
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gellery/Core/api/constant_api.dart';
import 'package:my_gellery/Core/helper/shared_pref_services.dart';
import 'package:my_gellery/Core/unit/constant_data.dart';
import 'package:my_gellery/Feather/gallery/data/repository/gallery_repository.dart';
import 'package:my_gellery/Feather/gallery/presentation/manager/gallery_state.dart';
import 'package:http/http.dart' as http;

class GalleryCubit extends Cubit<GalleryState> {

  GalleryCubit() : super(GalleryInitialState());

  static GalleryCubit get(context) => BlocProvider.of(context);

  List<File> imagesFile = [];

  void selectImage(File file) {
    imagesFile = [];
    imagesFile.add(file);
    emit(SuccessUploadState());
    uploadImage();
  }

  List myImages = [];

  void getMyGallery() {
    emit(LoadingGetImagesState());
    myImages = [];
    String token = SharedPreferencesServices.getDate(
        key: ConstantData.kToken) ?? '';
    GalleryRepository.getMyGallery(token: token).then((value) {
      if ((value?.dataGalleryModel?.images ?? []).isNotEmpty) {
        myImages.addAll(value?.dataGalleryModel?.images ?? []);
      }
      emit(SuccessGetImagesState());
      debugPrint('Success Get Images');
    }).onError((error, stackTrace) {
      emit(ErrorGetImagesState());
      debugPrint('Error Get Images ${error.toString()}');
    });
  }

  void uploadImage() async {
    emit(LoadingUploadImagesState());
    String token = SharedPreferencesServices.getDate(
        key: ConstantData.kToken) ?? '';
    var request = http.MultipartRequest('POST',
      Uri.https(ConstantApi.nameDomain, '${ConstantApi.endPoint}upload',),);
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    for (var element in imagesFile) {
      request.files.add(http.MultipartFile('img',
          File(element.path).readAsBytes().asStream(),
          File(element.path).lengthSync(),
          filename: element.path
              .split("/")
              .last));
    }


    var res = await request.send();
    var response = await http.Response.fromStream(res);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if ((resData['status'] ?? '') == 'success') {
      emit(SuccessUploadImagesState(msg: resData['message'] ?? ''));
      imagesFile=[];
      getMyGallery();
      debugPrint('Success Upload ');
    } else {
      debugPrint('Error Upload');
      emit(ErrorUploadImagesState());
    }
  }
}


abstract class GalleryState{}

class GalleryInitialState extends GalleryState{}

class LoadingGetImagesState extends GalleryState{}
class SuccessGetImagesState extends GalleryState{}
class ErrorGetImagesState extends GalleryState{}


class LoadingUploadImagesState extends GalleryState{}
class SuccessUploadImagesState extends GalleryState{
  String ? msg;
  SuccessUploadImagesState({this.msg});
}
class ErrorUploadImagesState extends GalleryState{}

class SuccessUploadState extends GalleryState{}

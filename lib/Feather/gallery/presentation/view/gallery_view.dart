
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gellery/Core/helper/cache_image.dart';
import 'package:my_gellery/Core/helper/loading_app_custom.dart';
import 'package:my_gellery/Core/helper/shared_pref_services.dart';
import 'package:my_gellery/Core/helper/sussess_app_custom.dart';
import 'package:my_gellery/Core/unit/app_router.dart';
import 'package:my_gellery/Core/unit/assets_data.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/constant_data.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Core/unit/styles.dart';
import 'package:my_gellery/Core/unit/unit.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_cubit.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_state.dart';
import 'package:my_gellery/Feather/auth/presentation/view/widget/auth_button_custom.dart';
import 'package:my_gellery/Feather/gallery/presentation/manager/gallery_cubit.dart';
import 'package:my_gellery/Feather/gallery/presentation/manager/gallery_state.dart';
import 'package:my_gellery/Feather/gallery/presentation/view/widget/gallery_button_custom.dart';
import 'package:image_picker/image_picker.dart';

import 'widget/function/dialog_select_image.dart';


class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  @override
  void initState() {
    BlocProvider.of<GalleryCubit>(context).getMyGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsData.backGroundGallery),
                    fit: BoxFit.fill
                )
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SizeData.s20,vertical: SizeData.s10),
                    child: Image.asset(AssetsData.profile,width: Unit(context).getWidthSize*0.16,height: Unit(context).getWidthSize*0.16),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(SizeData.s20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome \n${SharedPreferencesServices.getDate(key: ConstantData.kName)??''}',
                        style: Styles.textStyle32.copyWith(
                            fontSize: Unit(context).getWidthSize*0.085
                        ),textAlign: TextAlign.start,),
                      SizedBox(height: SizeData.s10,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: BlocConsumer<AuthCubit,AuthState>(
                              builder: (context,state){
                                return ButtonGalleryCustom(
                                  color: ColorData.redColor,
                                  text: 'log out',
                                  image: AssetsData.arrowLeft,
                                  fct: (){
                                    BlocProvider.of<AuthCubit>(context).logout();
                                  },
                                );
                              },
                              listener: (context,state){
                                if(state is SuccessLogoutState){
                                  context.go(AppRouter.kLoginView);
                                }
                              },
                            )
                          ),
                          SizedBox(width: SizeData.s20,),
                          Expanded(
                            child: BlocConsumer<GalleryCubit,GalleryState>(
                              builder: (context,state){
                                var cubit = GalleryCubit.get(context);
                                return (state is LoadingUploadImagesState)?
                                const LoadingAppCustom():ButtonGalleryCustom(
                                  color: ColorData.yellowColor,
                                  text: 'upload',
                                  image: AssetsData.arrowTop,
                                  fct: (){
                                    showDialog(context: context,
                                        barrierDismissible: false,
                                        builder: (context){
                                          return dialog(context: context,
                                              cameraFct: ()async{
                                               XFile?  file =  await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                               if(file!=null){
                                                 cubit.selectImage(File(file.path));
                                               }
                                               Navigator.pop(context);
                                              },
                                              galleryFct: ()async{
                                                List<XFile>?  file =  await ImagePicker().pickMultiImage(maxHeight: 1080,maxWidth: 1080);
                                                if(file.isNotEmpty){
                                                  for (var element in file) {
                                                    cubit.selectImage(File(element.path));
                                                  }
                                                  Navigator.pop(context);

                                                }
                                              });
                                        });

                                  },
                                );
                              },
                              listener: (context,state){
                                 if(state is SuccessUploadImagesState){
                                  showSuccessToast(context: context,msg: state.msg??'');
                                }

                              },
                            ),
                          ),


                        ],
                      ),

                      SizedBox(height: SizeData.s20,),

                      BlocBuilder<GalleryCubit,GalleryState>(
                          builder: (context,state){
                            var cubit = GalleryCubit.get(context);
                            return (state is LoadingGetImagesState)?
                            const LoadingAppCustom()
                                :
                            Expanded(
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20
                                    ),
                                    itemCount: cubit.myImages.length,
                                    itemBuilder: (context,index){
                                      return Container(
                                        decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(SizeData.s20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorData.blackColor.withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius:8
                                            )
                                          ]
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(SizeData.s20),
                                          child: CacheImageCustom(
                                            image: cubit.myImages[index],
                                          ),
                                        ),
                                      );
                            }));

                      })
                    ],
                  ),
                )



              ],
            )

        ),
      )
    );
  }
}

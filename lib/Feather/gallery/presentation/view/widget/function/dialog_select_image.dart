

import 'package:flutter/material.dart';
import 'package:my_gellery/Core/unit/assets_data.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Feather/gallery/presentation/view/widget/button_dialog.dart';

AlertDialog dialog({required BuildContext context,required Function() cameraFct , required Function() galleryFct}) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(vertical: SizeData.s20,horizontal: SizeData.s30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SizeData.s32),
    ),
    backgroundColor: ColorData.whiteColor.withOpacity(0.4),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: CloseButton(),
        ),
        ButtonDialogCustom(
         image: AssetsData.gallery,
         text: 'Gallery',
          color: ColorData.blueColor,
          fct: galleryFct,
        ),

        SizedBox(height: SizeData.s20,),

        ButtonDialogCustom(
          image: AssetsData.camera,
          text: 'Camera',
          color: ColorData.whiteColor,
          fct: cameraFct,
        ),
      ],
    ),
  );
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gellery/Core/helper/loading_app_custom.dart';
import 'package:my_gellery/Core/unit/assets_data.dart';
import 'package:my_gellery/Core/unit/color_data.dart';

class CacheImageCustom extends StatelessWidget {
  BoxFit ? boxFit;
  final String image;
   double? width;
   double? height;
  CacheImageCustom({Key? key, required this.image,  this.width,  this.height,this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: boxFit??BoxFit.fill,
      placeholder: (context, url) => const LoadingAppCustom(),
      errorWidget: (context, url, error) {
        return Image.asset(AssetsData.gallery,color: ColorData.primaryColor,
            width: width,height: height,fit: boxFit??BoxFit.fill);
      },
    );
  }
}

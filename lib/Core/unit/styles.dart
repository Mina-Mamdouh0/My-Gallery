
import 'package:flutter/material.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/font_weiget_data.dart';


abstract class Styles {
  static const fontFamily='ReadexPro';
  static const fontFamily2='BalooThambi2';

  static TextStyle textStyle50 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: 50,
    fontFamily: fontFamily,
    height:0,
  );

  static TextStyle textStyle16 = TextStyle(
    color: ColorData.grayColor,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: 16,
    fontFamily: fontFamily,
    height:0,
  );

  static TextStyle textStyle32 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: 32,
    fontFamily: fontFamily2,
    height:0,
  );






}
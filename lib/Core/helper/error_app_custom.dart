
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/unit.dart';

showErrorToast({String ? msg,required BuildContext context}) {
  return Fluttertoast.showToast(
    msg: msg ?? '',
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Colors.red,
    gravity: ToastGravity.TOP,
    fontSize: Unit(context).getWidthSize * 0.045,
    textColor: ColorData.whiteColor,
  );
}
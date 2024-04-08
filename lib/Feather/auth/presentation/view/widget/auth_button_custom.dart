
import 'package:flutter/material.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Core/unit/styles.dart';
import 'package:my_gellery/Core/unit/unit.dart';

class AuthButtonCustom extends StatelessWidget {
  final String text;
  Function()? fct;
  AuthButtonCustom({Key? key, required this.text, this.fct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: fct,
        padding: EdgeInsets.symmetric(vertical: SizeData.s14,),
        color: ColorData.primaryColor,
        minWidth: double.infinity,
        height: 50,
        elevation: 0.0,
        disabledColor:ColorData.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeData.s40),
        ),
        child: Text(text,
          style: Styles.textStyle50.copyWith(
            fontSize: Unit(context).getWidthSize*0.048,
            color: ColorData.whiteColor
          ), textAlign: TextAlign.center,)
    );
  }
}

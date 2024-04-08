
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:my_gellery/Core/unit/color_data.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Core/unit/styles.dart';
import 'package:my_gellery/Core/unit/unit.dart';


class InputTextCustom extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  bool? obscureText;
  FocusNode? focusNode;
  void Function()? onEditingComplete;

  InputTextCustom({Key? key, required this.controller, required this.inputType,this.focusNode,required this.hintText, this.obscureText,this.onEditingComplete,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      onTap: (){
        if(controller.selection == TextSelection.fromPosition(TextPosition(offset: controller.text.length -1))){
          controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        }
      },
      focusNode: focusNode,
      textInputAction:TextInputAction.next,
      keyboardType:inputType ,
      controller: controller,
      textAlign: TextAlign.start,
      obscureText: obscureText??false,
      style: Styles.textStyle16.copyWith(
        fontSize: Unit(context).getWidthSize*0.042,
        color: ColorData.blackColor
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Styles.textStyle16.copyWith(
          fontSize: Unit(context).getWidthSize*0.042,
        ),
        filled: true,
        fillColor: ColorData.whiteColor,
        contentPadding:const  EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeData.s22),
          borderSide:BorderSide(color:ColorData.whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeData.s22),
          borderSide:BorderSide(color:ColorData.whiteColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeData.s22),
          borderSide:const BorderSide(color:Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeData.s22),
          borderSide:BorderSide(color:ColorData.primaryColor),
        ),
      ),
      validator: (String? val){
        if(val!.isEmpty){
          return 'Field Required';
        }
      },
    );
  }
}

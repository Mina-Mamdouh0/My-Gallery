
import 'package:flutter/material.dart';
import 'package:my_gellery/Core/unit/size_data.dart';
import 'package:my_gellery/Core/unit/styles.dart';
import 'package:my_gellery/Core/unit/unit.dart';

class ButtonDialogCustom extends StatelessWidget {
  final String text;
  final String image;
  final Color color;
  Function()? fct;
  ButtonDialogCustom({Key? key, required this.text, this.fct, required this.image, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fct,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: SizeData.s5,horizontal: SizeData.s10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeData.s16),
            color: color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(SizeData.s5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(SizeData.s20),
              ),
              child: Center(
                child: Image.asset(image,
                height: Unit(context).getWidthSize*0.088,
                width: Unit(context).getWidthSize*0.088,),
              ),
            ),
            SizedBox(width: SizeData.s10,),

            Expanded(
              child: Center(
                child: Text(text,
                  style: Styles.textStyle50.copyWith(
                      fontSize: Unit(context).getWidthSize*0.072
                  ),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

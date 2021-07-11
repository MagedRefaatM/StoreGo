import 'package:store_go/widgets/text_drawer.dart';
import 'package:flutter/material.dart';

class ElevatedButtonDrawer extends StatelessWidget {
  final Color borderSideColor;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final double paddingBottom;
  final Function onPressed;
  final double paddingTop;
  final double borderRadius;
  final Color textColor;
  final double fontSize;
  final String btnText;

  ElevatedButtonDrawer(
      {this.borderSideColor,
      this.backgroundColor,
      this.paddingBottom,
      this.borderRadius,
      this.paddingTop,
      this.fontWeight,
      this.onPressed,
      this.textColor,
      this.fontSize,
      this.btnText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
                side: BorderSide(
                    color: borderSideColor ?? Colors.deepPurpleAccent))),
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? Colors.deepPurpleAccent)),
        onPressed: onPressed ?? () {},
        child: Padding(
          padding: EdgeInsets.only(
              top: paddingTop ?? 15.0, bottom: paddingBottom ?? 15.0),
          child: TextDrawer(
              text: btnText ?? 'حفظ',
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 18.0,
              fontWeight: fontWeight ?? FontWeight.w700),
        ));
  }
}

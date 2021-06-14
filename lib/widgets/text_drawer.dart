import 'package:flutter/material.dart';

class TextDrawer extends StatelessWidget {
  final TextWidthBasis textWidthBasis;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextAlign textAlign;
  final double fontSize;
  final int maxLines;
  final String text;
  final Color color;

  TextDrawer(
      {this.textWidthBasis,
      this.letterSpacing,
      this.textOverflow,
      this.fontWeight,
      this.textAlign,
      this.fontSize,
      this.maxLines,
      this.color,
      this.text});

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle parent =
        DefaultTextStyle.of(context.findRootAncestorStateOfType().context);
    return Text(
      text,
      textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
      overflow: textOverflow ?? parent.overflow,
      textAlign: textAlign ?? parent.textAlign,
      maxLines: maxLines ?? parent.maxLines,
      style: TextStyle(
          fontFamily: 'ArabicUiDisplay',
          letterSpacing: letterSpacing ?? 0.0,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color ?? Colors.black),
    );
  }
}

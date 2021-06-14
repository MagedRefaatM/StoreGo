import 'package:flutter/material.dart';

class TextFieldDrawer extends StatelessWidget {
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final TextInputAction inputAction;
  final Function(String) onChange;
  final TextInputType inputType;
  final bool enableSuggestions;
  final double labelFontSize;
  final FocusNode focusNode;
  final TextAlign textAlign;
  final double hintFontSize;
  final double borderRadius;
  final bool autoCorrect;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final bool autoFocus;
  final int maxLines;
  final bool enabled;

  TextFieldDrawer(
      {this.floatingLabelBehavior,
      this.controller,
      this.onSubmitted,
      this.inputAction,
      this.onChange,
      this.inputType,
      this.enableSuggestions,
      this.labelFontSize,
      this.focusNode,
      this.textAlign,
      this.hintFontSize,
      this.borderRadius,
      this.autoCorrect,
      this.obscureText,
      this.labelText,
      this.hintText,
      this.autoFocus,
      this.maxLines,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: enableSuggestions ?? true,
      textInputAction: inputAction,
      autocorrect: autoCorrect ?? false,
      obscureText: obscureText ?? false,
      keyboardType: inputType,
      controller: controller,
      autofocus: autoFocus ?? false,
      textAlign: textAlign,
      focusNode: focusNode,
      maxLines: maxLines,
      enabled: enabled ?? true,
      onSubmitted: onSubmitted,
      onChanged: onChange,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.all(
              new Radius.circular(borderRadius),
            ),
          ),
          hintStyle: new TextStyle(
            fontSize: hintFontSize,
            fontFamily: 'ArabicUiDisplay',
            fontWeight: FontWeight.w300,
            color: Colors.grey[700],
          ),
          labelStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'ArabicUiDisplay',
              fontSize: labelFontSize ?? 17.0,
              fontWeight: FontWeight.w600),
          hintText: hintText,
          labelText: labelText,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: Colors.white),
    );
  }
}

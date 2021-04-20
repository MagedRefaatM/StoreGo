import 'package:flutter/cupertino.dart';

class SingleAccount {
  String labelString;
  String hintString;
  String imageIconString;
  TextInputType textInputType;
  TextEditingController textEditingController;
  int id;

  SingleAccount(
      {this.labelString,
      this.hintString,
      this.imageIconString,
      this.textInputType,
      this.textEditingController,
      this.id});
}

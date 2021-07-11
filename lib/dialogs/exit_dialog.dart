import 'package:store_go/widgets/text_drawer.dart';
import 'package:flutter/material.dart';

class ExitDialog {
  static Future<bool> showExitDialog(
      BuildContext context, Function exitFunction) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: TextDrawer(
                text: 'تسجيل الخروج',
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22.0),
            content: TextDrawer(
                text: 'هل تريد تسجيل الخروج من التطبيق؟',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 19.0),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: TextDrawer(
                    text: "لا",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: exitFunction,
                child: TextDrawer(
                    text: "نعم",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
            ],
          ),
        ) ??
        false;
  }
}

import 'package:flutter/material.dart';

class ExitDialog {
  static Future<bool> showExitDialog(
      BuildContext context, Function exitFunction) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ArabicUiDisplay',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800),
            ),
            content: Text(
              'هل تريد تسجيل الخروج من التطبيق؟',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ArabicUiDisplay',
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "لا",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: exitFunction,
                child: Text(
                  "نعم",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}

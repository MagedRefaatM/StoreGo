import 'package:flutter/material.dart';

class ExitAddProductDialog {
  static Future<bool> showExitAddProductDialog(
      BuildContext context, Function exitFunction) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        content: Text(
          'تنبيه:سيتم تجاهل إضافة المنتج الحالى، هل تود المتابعة؟',
          textAlign: TextAlign.center,
          maxLines: 2,
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
              "إلغاء",
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
              "متابعة",
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
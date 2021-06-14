import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';

class ExitEditProductDialog {
  static Future<bool> showExitEditProductDialog(
      BuildContext context, Function exitFunction) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            content: TextDrawer(
                text: 'تنبيه:سيتم تجاهل التعديلات الجارية، هل تود المتابعة؟',
                textAlign: TextAlign.center,
                maxLines: 2,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 19.0),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: TextDrawer(
                    text: "إلغاء",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: exitFunction,
                child: TextDrawer(
                    text: "متابعة",
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

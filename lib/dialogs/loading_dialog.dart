import 'package:flutter/material.dart';

class LoadingDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.deepPurpleAccent,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "برجاء الإنتظار",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

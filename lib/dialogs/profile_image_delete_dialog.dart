import 'package:flutter/material.dart';

class DeleteProfileImageDialog {
  static Future<void> showDeleteProfileImageDialog(
      BuildContext context,
      GlobalKey key,
      Function deleteProfileImageFunction,
      Function cancelDelete) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  title:
                      Text('حذف الصورة الشخصية', textAlign: TextAlign.center),
                  elevation: 3.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ArabicUiDisplay',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'هل حقا تود حذف هذة الصورة؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: Text('إلغاء',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0)),
                              onPressed: cancelDelete,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurpleAccent)),
                            ),
                            ElevatedButton(
                              child: Text('تأكيد',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0)),
                              onPressed: deleteProfileImageFunction,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurpleAccent)),
                            )
                          ],
                        )
                      ],
                    )
                  ]));
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog {
  static Future<void> showImageDialog(BuildContext context, GlobalKey key,
      Function getImageFromGallery, Function getImageFromCamera) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  title:
                      Text('تحميل صورة من الهاتف', textAlign: TextAlign.center),
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
                          'إختار مصدر تحميل الصورة',
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
                            ElevatedButton.icon(
                                onPressed: getImageFromCamera,
                                icon: Icon(Icons.camera_enhance_rounded,
                                    color: Colors.white),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                                label: Text('الكاميرا',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0))),
                            ElevatedButton.icon(
                                onPressed: getImageFromGallery,
                                icon: Icon(Icons.image, color: Colors.white),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                                label: Text('المعرض',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0)))
                          ],
                        )
                      ],
                    )
                  ]));
        });
  }
}

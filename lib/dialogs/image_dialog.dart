import 'package:store_go/drawers//text_drawer.dart';
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
                  title: TextDrawer(
                      text: 'تحميل صورة من الهاتف',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0),
                  elevation: 3.0,
                  backgroundColor: Colors.deepPurpleAccent,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextDrawer(
                            text: 'إختار مصدر تحميل الصورة',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0),
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
                                label: TextDrawer(
                                    text: 'الكاميرا',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0)),
                            ElevatedButton.icon(
                                onPressed: getImageFromGallery,
                                icon: Icon(Icons.image, color: Colors.white),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                                label: TextDrawer(
                                    text: 'المعرض',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0)),
                          ],
                        )
                      ],
                    )
                  ]));
        });
  }
}

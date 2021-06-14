import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';

class ProfileImageDialog {
  static Future<void> showProfileImageDialog(
      BuildContext context,
      GlobalKey key,
      Function addNewProfileImageFunction,
      Function deleteProfileImageFunction,
      Function cancelFunction) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  title: TextDrawer(
                      text: 'تعديل الصورة الشخصية',
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
                            text: 'قم بإختيار إحدى العمليات لتنفيذها',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: TextDrawer(
                                    text: 'تعديل الصورة',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                                onPressed: addNewProfileImageFunction,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                              ),
                              ElevatedButton.icon(
                                icon: Icon(Icons.delete, color: Colors.white),
                                label: TextDrawer(
                                    text: 'حذف الصورة',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                                onPressed: deleteProfileImageFunction,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                              ),
                              ElevatedButton.icon(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                label: TextDrawer(
                                    text: 'رجوع',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                                onPressed: cancelFunction,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ]));
        });
  }
}

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
                  title:
                      Text('تعديل الصورة الشخصية', textAlign: TextAlign.center),
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
                          'قم بإختيار إحدى العمليات لتنفيذها',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: Text('تعديل الصورة',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0)),
                                onPressed: addNewProfileImageFunction,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                              ),
                              ElevatedButton.icon(
                                icon: Icon(Icons.delete, color: Colors.white),
                                label: Text('حذف الصورة',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0)),
                                onPressed: deleteProfileImageFunction,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurpleAccent)),
                              ),
                              ElevatedButton.icon(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                label: Text('رجوع',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0)),
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

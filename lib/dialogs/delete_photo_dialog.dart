import 'package:store_go/widgets/text_drawer.dart';
import 'package:flutter/material.dart';

class DeleteProductImageDialog {
  static Future<void> showDeleteProductImageDialog(
      BuildContext context,
      GlobalKey key,
      Function deleteProductImageFunction,
      Function cancelDelete) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  title: TextDrawer(
                      text: 'حذف صورة المنتج',
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
                            text: 'هل حقا تود حذف هذة الصورة؟',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: TextDrawer(
                                  text: 'إلغاء',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0),
                              onPressed: cancelDelete,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurpleAccent)),
                            ),
                            ElevatedButton(
                              child: TextDrawer(
                                  text: 'تأكيد',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0),
                              onPressed: deleteProductImageFunction,
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

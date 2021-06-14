import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';

class NewInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextDrawer(
              text: 'طلب جديد',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 26.0),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextDrawer(
                    text: 'إنشاء طلب جديد وإرساله للعميل',
                    textAlign: TextAlign.center,
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
                SizedBox(height: 10.0),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextDrawer(
                        text: 'أحصل على رابط للطلب وإرساله لعملائك للدفع',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        letterSpacing: 1.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 21.0)),
                SizedBox(height: 20.0),
                Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(
                                        color: Colors.deepPurpleAccent))),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent)),
                        onPressed: () {},
                        child: TextDrawer(
                            text: 'إنشاء فاتورة',
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 19.0))),
              ]),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }
}

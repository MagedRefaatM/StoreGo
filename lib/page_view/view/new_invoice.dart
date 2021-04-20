import 'package:flutter/material.dart';

class NewInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'طلب جديد',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'ArabicUiDisplay',
                fontSize: 26.0,
                color: Colors.black),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'إنشاء طلب جديد وإرساله للعميل',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                    fontFamily: 'ArabicUiDisplay',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  'أحصل على رابط للطلب وإرساله لعملائك للدفع',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21.0,
                      letterSpacing: 1.0,
                      fontFamily: 'ArabicUiDisplay',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(20.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: BorderSide(color: Colors.deepPurpleAccent))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white))),
                    onPressed: () {},
                    child: Text('إنشاء فاتورة',
                        style: TextStyle(
                            fontSize: 19.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w800))),
              ),
            ],
          ),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }
}

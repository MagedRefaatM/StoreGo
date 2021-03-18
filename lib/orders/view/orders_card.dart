import 'package:flutter/material.dart';

class OrdersCard extends StatelessWidget {
  final int requestNumber;
  final int requestNumberOfProducts;

  final Color requestStateColor;

  final String requestProductPrice;
  final String requestDate;
  final String requestCustomerName;
  final String requestState;

  OrdersCard(
      {this.requestNumber,
      this.requestNumberOfProducts,
      this.requestProductPrice,
      this.requestDate,
      this.requestStateColor,
      this.requestCustomerName,
      this.requestState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0),
                  child: Text(
                    requestCustomerName,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ArabicUiDisplay',
                        fontSize: 16.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                      child: Text(
                        '$requestProductPrice',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'ArabicUiDisplay',
                            fontSize: 18.0),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'ريال',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                      child: Text(
                        '$requestNumberOfProducts',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'ArabicUiDisplay',
                            fontSize: 16.0),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'منتج',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '$requestNumber#',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'طلب',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w400,
                            fontSize: 23.0),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: requestStateColor))),
                      backgroundColor:
                          MaterialStateProperty.all(requestStateColor)),
                  onPressed: () {},
                  child: Text(
                    requestState,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'ArabicUiDisplay',
                        fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    requestDate,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'ArabicUiDisplay',
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400],
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
      ),
    );
  }
}

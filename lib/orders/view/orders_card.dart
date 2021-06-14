import 'package:store_go/drawers//text_drawer.dart';
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
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 10.0),
                          child: TextDrawer(
                              text: requestCustomerName,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 10.0),
                                child: TextDrawer(
                                    text: requestProductPrice.toString(),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0)),
                            SizedBox(width: 6.0),
                            TextDrawer(
                                text: 'ريال',
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 10.0),
                                child: TextDrawer(
                                    text: requestNumberOfProducts.toString(),
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0)),
                            SizedBox(width: 6.0),
                            TextDrawer(
                                text: 'منتج',
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                          ])
                    ]),
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
                                child: TextDrawer(
                                    text: '$requestNumber#',
                                    textAlign: TextAlign.center,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0)),
                            SizedBox(width: 10.0),
                            Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextDrawer(
                                    text: 'طلب',
                                    textAlign: TextAlign.center,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23.0)),
                          ]),
                      TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: requestStateColor))),
                              backgroundColor:
                                  MaterialStateProperty.all(requestStateColor)),
                          onPressed: () {},
                          child: TextDrawer(
                              text: requestState,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0)),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextDrawer(
                              text: requestDate,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0))
                    ])
              ]),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
        ));
  }
}

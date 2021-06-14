import 'package:store_go/widgets/text_drawer.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Function productClickHandler;
  final double opacityValue;
  final Color statusColor;
  final String imageLink;
  final String status;
  final String name;
  final quantity;
  final price;

  ProductItem(
      {this.productClickHandler,
      this.opacityValue,
      this.statusColor,
      this.imageLink,
      this.name,
      this.status,
      this.quantity,
      this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: productClickHandler,
                child: Container(
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 3.0),
                            child: TextDrawer(
                                text: status,
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 3.0),
                        child: Opacity(
                          opacity: opacityValue,
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.all(6.0),
                                child: TextDrawer(
                                    text: quantity.toString(),
                                    textAlign: TextAlign.center,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.deepOrangeAccent),
                              )),
                        )),
                  ]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(imageLink),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Expanded(
              flex: 1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextDrawer(
                        text: name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                    SizedBox(height: 2.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 7.0),
                              child: TextDrawer(
                                  text: 'ريال',
                                  textAlign: TextAlign.center,
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0)),
                          SizedBox(width: 8.0),
                          TextDrawer(
                              text: price.toString(),
                              textAlign: TextAlign.center,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0)
                        ])
                  ]),
            )
          ],
        ));
  }
}

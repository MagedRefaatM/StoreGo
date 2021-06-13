import 'package:flutter/material.dart';

class ImageItemDrawer extends StatelessWidget {
  final Function onRemoveImageClicked;
  final Function onAddImageClicked;
  final String currentImageLink;

  ImageItemDrawer(
      {this.onRemoveImageClicked,
      this.onAddImageClicked,
      this.currentImageLink});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.0, top: 5.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.remove, color: Colors.white),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      onTap: onRemoveImageClicked,
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.edit, color: Colors.white),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                      onTap: onAddImageClicked,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              image: NetworkImage(currentImageLink), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

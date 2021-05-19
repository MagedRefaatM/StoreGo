import 'package:flutter/material.dart';
import 'dart:io';

class DocumentCell extends StatelessWidget {
  final Color documentContainerColor;
  final Function deleteFunction;
  final String documentUrl;

  DocumentCell(
      {this.documentContainerColor, this.documentUrl, this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.clear, color: Colors.white),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
                onTap: deleteFunction,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image(
                    image: FileImage(File(documentUrl)),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: 100,
                  ))
            ],
          ),
        ),
        decoration: BoxDecoration(
          // color: documentContainerColor,
          color: documentContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

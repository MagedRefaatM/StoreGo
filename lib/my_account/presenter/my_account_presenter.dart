import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyAccountPresenter {
  // documentType 0 => commercial document
  // documentType 1 => bank document

  Color documentCellColorHandler(int documentType, int cellIndex) {
    if (documentType == 0) {
      if (cellIndex % 2 != 0)
        return Colors.green[50];
      else
        return Colors.white;
    } else {
      if (cellIndex % 2 != 0)
        return Colors.green[50];
      else
        return Colors.white;
    }
  }

  void checkUploadDocumentsMax(
      int uploadListLength, Function upload, Function onMaxReach) {
    if (uploadListLength != 5)
      upload();
    else
      onMaxReach();
  }

  int getCorrectDocumentIndex(int documentType) {
    if (documentType == 0)
      return MyAccountLocalData.commercialDocumentIndex;
    else
      return MyAccountLocalData.bankDocumentIndex;
  }

  void increaseDocumentIndex(int documentType) {
    if (documentType == 0)
      MyAccountLocalData.commercialDocumentIndex += 1;
    else
      MyAccountLocalData.bankDocumentIndex += 1;
  }

  // fileType application => it's a pdf
  Widget previewingFileHandler(String fileType, String filePath) {
    if (fileType == 'application')
      return PDFView(
          filePath: filePath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          nightMode: false);
    else
      return Image(
        image: FileImage(File(filePath)),
        fit: BoxFit.cover,
      );
  }

  void decreaseDocumentIndex(int documentType) {
    if (documentType == 0)
      MyAccountLocalData.commercialDocumentIndex -= 1;
    else
      MyAccountLocalData.bankDocumentIndex -= 1;
  }

  String getTextFieldText(TextEditingController controller, String labelText) {
    if (controller.text.isEmpty)
      return labelText;
    else if (labelText == null)
      return '';
    else
      return controller.text;
  }

  String getPhoneNumber(String controllerText, String labelText) {
    if (controllerText == null)
      return labelText;
    else if (labelText == null)
      return '';
    else
      return controllerText;
  }

  List<Document> getDocumentsList(
      List<Document> apiList, List<Document> newList) {
    if (apiList.length == 0 && newList.length == 0)
      return [];
    else if (apiList.length != 0 && newList.length == 0)
      return apiList;
    else if (newList.length != 0 && apiList.length == 0)
      return newList;
    else {
      apiList.addAll(newList);
      return apiList;
    }
  }

  void checkConnectionState(
      bool connectionState,
      bool dataState,
      Function successUpdate,
      Function onDataError,
      Function connectionTimeOut) {
    if (connectionState == true && dataState == true)
      successUpdate();
    else if (connectionState == true && dataState == false)
      onDataError();
    else
      connectionTimeOut();
  }
}

import '../../verification/data_layer/data_model/account_info_response.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class MyAccountPresenter {
  // documentType 0 => commercial document
  // documentType 1 => bank document

  void checkUploadDocumentsMax(
      int uploadListLength, Function upload, Function onMaxReach) {
    if (uploadListLength != 5)
      upload();
    else
      onMaxReach();
  }

  // fileType application => it's a pdf
  Widget previewingFileHandler(String fileType, String fileLink) {
    if (fileType == 'application')
      return SfPdfViewer.network(fileLink);
    else
      return Image(
        image: NetworkImage(fileLink),
        fit: BoxFit.cover,
      );
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

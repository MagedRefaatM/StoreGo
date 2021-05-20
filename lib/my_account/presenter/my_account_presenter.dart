import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:flutter/material.dart';

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

  void checkConnectionState(bool connectionState, Function successUpdate,
      Function connectionTimeOut) {
    if (connectionState == false)
      connectionTimeOut();
    else
      successUpdate();
  }
}

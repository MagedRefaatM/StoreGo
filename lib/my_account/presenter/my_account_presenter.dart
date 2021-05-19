import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:flutter/material.dart';

class MyAccountPresenter {
  // documentType 0 => commercial
  // documentType 1 => bank

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
}

import 'package:flutter/material.dart';
import 'package:store_go/products/model/data/products_local_data.dart';

class ProductsPresenter {
  String getProductStatus(int status) {
    if (status == 0)
      return 'غير معروض';
    else
      return 'معروض';
  }

  Color getProductStatusColor(dynamic status) {
    if (status == 0 || status == '0')
      return Colors.red;
    else
      return Colors.deepPurpleAccent;
  }

  double getQuantityVisibilityStatus(dynamic quantity) {
    if (quantity == null)
      return 0.0;
    else
      return 1.0;
  }

  int getProductQuantityState(bool quantityState) {
    if (quantityState == false)
      return 1;
    else
      return 0;
  }

  String getProductDisplayedState(dynamic status) {
    if (status == 1 || status == '1')
      return 'معروض';
    else
      return 'غير معروض';
  }

  int getProductDisplayState(bool displayState) {
    if (displayState == false)
      return 1;
    else
      return 0;
  }

  bool getQuantityToggleState(dynamic productQuantity) {
    if (productQuantity == '' ||
        productQuantity == null ||
        productQuantity == 'null')
      return true;
    else
      return false;
  }

  bool getDisplayStateToggle(dynamic displayStatus) {
    if (displayStatus == 0 || displayStatus == '0')
      return true;
    else
      return false;
  }

  bool getTextFieldDisplayStatus(bool quantityState) {
    if (quantityState == true)
      return false;
    else
      return true;
  }

  bool editTextFieldStatus(bool oldStatus) {
    if (oldStatus == true)
      return false;
    else
      return true;
  }

  String getProductDescription(String description) {
    if (description == null || description.isEmpty)
      return 'لا يوجد';
    else
      return description;
  }

  String getProductQuantity(dynamic quantity) {
    if (quantity == '' || quantity.toString() == 'null' || quantity == null)
      return 'غير محدد';
    else
      return quantity.toString();
  }

  String displayQuantityTextFieldLabel(dynamic quantity) {
    if (quantity == '' || quantity.toString() == 'null' || quantity == null)
      return '';
    else
      return quantity.toString();
  }

  String getBalance(String balance) {
    if (balance == 'غير محدد')
      return '- ';
    else
      return balance;
  }

  String getTextFieldText(TextEditingController controller, String labelText) {
    if (controller.text.isEmpty)
      return labelText;
    else
      return controller.text;
  }

  String subStringImageString(String imageString) {
    const start = "products/";
    final startIndex = imageString.indexOf(start);
    return imageString.substring(startIndex + start.length);
  }

  Widget getCurrentDisplayedWidget(
      int otherImagesListLength, Widget widget1, Widget widget2) {
    if (otherImagesListLength == 0 || otherImagesListLength == null)
      return widget2;
    else
      return widget1;
  }

  double getMainImageDeleteButtonOpacity(bool mainImageStatus) {
    if (mainImageStatus == false)
      return 0.0;
    else
      return 1.0;
  }

  double getAdditionalImageDeleteButtonOpacity(bool otherToolOpacity) {
    if (!otherToolOpacity)
      return 0.0;
    else
      return 1.0;
  }

  Function productUpdateHandler(
      bool isProductUpdated, Function actionOne, Function actionTwo) {
    if (isProductUpdated == true)
      return actionOne;
    else
      return actionTwo;
  }

  ImageProvider loadingImageTypeHandler(
      bool imagesStatus, String localImagePath, String networkLinkPath) {
    if (imagesStatus == false)
      return AssetImage(localImagePath);
    else
      return NetworkImage(networkLinkPath);
  }

  String productCategoryController(int categoryId) {
    if (categoryId == null)
      return '';
    else
      return categoryId.toString();
  }

  String priceTextController(TextEditingController priceController) {
    if (priceController.text.isEmpty)
      return '0.0';
    else
      return priceController.text.trim().toString();
  }

  String descriptionTextController(
      TextEditingController descriptionController) {
    if (descriptionController.text.isEmpty)
      return 'لا يتوافر';
    else
      return descriptionController.text.toString();
  }

  String quantityTextController(
      TextEditingController quantityController, bool quantityState) {
    if (quantityState) {
      return 'null';
    } else {
      if (quantityController.text.toString().isEmpty ||
          quantityController.text == null)
        return '0';
      else
        return quantityController.text.toString();
    }
  }

  void handleScrollDirection(
      ScrollController scrollController, Function bottomHandler) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      bottomHandler();
    }
  }

  void validateProductAddition(
      bool mainImageStatus,
      String productName,
      String productPrice,
      Function failureHandlerFunction,
      Function successHandlerFunction) {
    if (!mainImageStatus &&
        (productName.isEmpty || productName == null) &&
        (productPrice.isEmpty || productPrice == null)) {
      ProductsLocalData.additionMessage = 'برجاء تحديد خصائص المنتج قبل الإضافة';
      failureHandlerFunction();
    } else if (!mainImageStatus) {
      ProductsLocalData.additionMessage = 'برجاء إضافة صورة رئيسية للمنتج';
      failureHandlerFunction();
    } else if (productName.isEmpty || productName == null) {
      ProductsLocalData.additionMessage = 'برجاء إضافة اسم للمنتج قبل الإضافة';
      failureHandlerFunction();
    } else if (productPrice.isEmpty || productPrice == null) {
      ProductsLocalData.additionMessage = 'برجاء إضافة سعر للمنتج قبل الإضافة';
      failureHandlerFunction();
    } else
      successHandlerFunction();
  }

  void validateProductUpdate(bool mainImageStatus,
      Function failureHandlerFunction, Function successHandlerFunction) {
    if (!mainImageStatus) {
      ProductsLocalData.updateMessage = 'برجاء إضافة صورة رئيسية للمنتج اولا';
      failureHandlerFunction();
    } else
      successHandlerFunction();
  }

  String getCurrentProductStatus(bool displayStatus) {
    if(!displayStatus)
      return 'معروض';
    else
      return 'غير معروض';
  }
}

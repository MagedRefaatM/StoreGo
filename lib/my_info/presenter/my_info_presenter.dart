import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:flutter/material.dart';

class MyInfoPresenter {
  String getTextFieldText(TextEditingController controller, String labelText) {
    if (controller.text.isEmpty)
      return labelText;
    else
      return controller.text;
  }

  String handleUserPassword(TextEditingController passwordController) {
    if (passwordController.text.isEmpty || passwordController.text == null) {
      MyInfoLocalData.passwordChangeState = false;
      return '';
    } else {
      MyInfoLocalData.passwordChangeState = true;
      return passwordController.text;
    }
  }

  void serviceCallHandler(bool networkConnectionState, bool dataState,
      Function successCall, Function failureCall, Function networkFailure) {
    if (networkConnectionState && dataState)
      successCall();
    else if (networkConnectionState && !dataState)
      failureCall();
    else
      networkFailure();
  }

  void updateBehaviorHandler(
      bool passwordChangeState, Function postLogout, Function updateUserToken) {
    if (passwordChangeState)
      postLogout();
    else
      updateUserToken();
  }

  void checkImageState(
      int imageState, Function onImageExists, Function onImageEmpty) {
    if (imageState == 0)
      onImageEmpty();
    else
      onImageExists();
  }

  String handleProfileImageName(String imageName) {
    if (imageName == null)
      return '';
    else
      return imageName;
  }
}

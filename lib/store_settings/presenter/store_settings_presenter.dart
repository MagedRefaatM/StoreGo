import 'package:flutter/material.dart';

class StoreSettingsPresenter {
  bool getStoreSettingsState(int currentState) {
    if (currentState == 1)
      return false;
    else
      return true;
  }

  String getCurrentStoreState(bool toggleState) {
    if (!toggleState)
      return 'مفعل';
    else
      return 'غير مفعل';
  }

  String handleDefaultLabel(String labelText) {
    if (labelText == 'غير محدد')
      return '';
    else
      return labelText;
  }

  int getStoreState(bool currentStoreState) {
    if (currentStoreState)
      return 0;
    else
      return 1;
  }

  String getTextFieldText(TextEditingController controller, String labelText) {
    if (controller.text.isEmpty)
      return handleDefaultLabel(labelText);
    else
      return controller.text;
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
}

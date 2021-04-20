import 'package:flutter/material.dart';

class TaxesPresenter {
  bool getTaxesState(int currentState) {
    if (currentState == 1)
      return false;
    else
      return true;
  }

  String getCurrentTaxesState(bool toggleState) {
    if (!toggleState)
      return 'مفعلة';
    else
      return 'غير مفعلة';
  }

  double getTaxesOpacityAmount(bool togglesState) {
    if (!togglesState)
      return 1.0;
    else
      return 0.0;
  }

  bool getInteractionState(bool toggleState) {
    if (!toggleState)
      return false;
    else
      return true;
  }

  String handleDefaultLabel(String labelText) {
    if (labelText == 'غير محدد')
      return '';
    else
      return labelText;
  }

  int getStoreState(bool currentStoreState) {
    if (currentStoreState == true)
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

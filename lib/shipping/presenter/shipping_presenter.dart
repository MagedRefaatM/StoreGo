import 'package:store_go/settings/model/entities/manager_settings_response.dart';

class ShippingPresenter {
  bool getShippingState(int currentState) {
    if (currentState == 1)
      return false;
    else
      return true;
  }

  double getShippingOpacityAmount(bool toggleState) {
    if (!toggleState)
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

  void handleDecreasingShippingAreasLength(int currentAreasListLength,
      Function decreasingShippingAreas, Function turnOffOpacity) {
    if (currentAreasListLength != 1)
      decreasingShippingAreas();
    else if (currentAreasListLength == 1) turnOffOpacity();
  }

  int getStoreState(bool currentStoreState) {
    if (currentStoreState)
      return 0;
    else
      return 1;
  }

  void fillAdditionalAreasList(ShippingPriceList singleListItem,
      Function fillListItem, List<ShippingPriceList> list) {
    if (singleListItem.name != null && singleListItem.price != null) {
      if (list.contains(singleListItem) == false) {
        fillListItem();
      }
    }
  }

  void handleScreenBackPress(bool updateClickedState, Function onUpdateOccurred,
      Function onIgnoreUpdate) {
    if (updateClickedState)
      onUpdateOccurred();
    else
      onIgnoreUpdate();
  }

  void handleDeleteListIndex(
      List<ShippingPriceList> workingOnList,
      List<ShippingPriceList> additionalList,
      Function removeItemNormally,
      Function turnOffOpacity) {
    if ((workingOnList.length == 0 || workingOnList.length == null) &&
        additionalList.length >= 1)
      removeItemNormally();
    else if (workingOnList.length == null ||
        workingOnList.length == 0 && additionalList.length == null ||
        additionalList.length == 0)
      turnOffOpacity();
    else
      removeItemNormally();
  }

  void handleListElementsRestore(
      List<ShippingPriceList> deletedItems,
      List<ShippingPriceList> majorList,
      Function onNoDeleteOccurred,
      Function onSingleItemDeleted,
      Function onAllItemsDeleted) {
    if (deletedItems.length == null || deletedItems.length == 0)
      onNoDeleteOccurred();
    else if ((majorList.length != null || majorList.length != 0) &&
        (deletedItems.length != 0 || deletedItems.length != null))
      onSingleItemDeleted();
    else
      onAllItemsDeleted();
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

  checkMainListLength(int mainListLength, Function turnOffOpacity) {
    if (mainListLength == 0 || mainListLength == null) turnOffOpacity();
  }

  void handleToggleOpacity(
      bool currentToggleState,
      int mainListLength,
      int additionalListLength,
      Function turnOnOpacity,
      Function showError,
      Function normalAction) {
    if (currentToggleState == true &&
        mainListLength == 0 &&
        additionalListLength == 0)
      turnOnOpacity();
    else if (currentToggleState == true &&
        (mainListLength != 0 || additionalListLength != 0))
      showError();
    else
      normalAction();
  }
}

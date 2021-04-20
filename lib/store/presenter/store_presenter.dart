import 'package:store_go/store/model/data/store_local_data.dart';

class StorePresenter {
  void currentOptionClickFunction(int optionId, Function myWallet,
      Function customers, Function products, bool isOptionClicked) {
    if (isOptionClicked && optionId == 1)
      myWallet();
    else if (isOptionClicked && optionId == 2)
      customers();
    else if (isOptionClicked && optionId == 3) products();
  }

  void handleCurrentConnectionState(bool connectionState, bool dataState,
      Function onSuccess, Function onError) {
    if (connectionState == true && dataState == true)
      onSuccess();
    else if (connectionState == true && dataState == false) {
      StoreLocalData.currentStateMessage = 'حدث خطأ غير متوقع';
      onError();
    } else if (connectionState == false && dataState == false) {
      StoreLocalData.currentStateMessage =
          'برجاء التأكد من إتصال الانترنت لديك';
      onError();
    }
  }
}

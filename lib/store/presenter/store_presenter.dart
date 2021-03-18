import 'package:store_go/store/model/data/store_local_data.dart';

class StorePresenter {
  Function currentOptionClickFunction(
      int optionId, Function myWallet, Function customers, Function products) {
    if (optionId == 1)
      return myWallet();
    else if (optionId == 2)
      return customers();
    else
      return products();
  }

  void handleCurrentConnectionState(bool connectionState, bool dataState, Function onSuccess, Function onError) {
    if(connectionState == true && dataState == true)
      onSuccess();
    else if (connectionState == true && dataState == false){
      StoreLocalData.currentStateMessage = 'حدث خطأ غير متوقع';
      onError();
    }
    else if (connectionState == false && dataState == false){
      StoreLocalData.currentStateMessage = 'برجاء التأكد من إتصال الانترنت لديك';
      onError();
    }
  }
}

import 'package:store_go/settings/model/entities/shipping_model.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class ShippingLocalData {
  String updateStoreServiceLink = 'https://dev.storego.io/api/v1/update-store';
  String loggedInUserToken;
  String toastMessage;

  static bool networkConnectionState;
  static bool updateOccurred;
  static bool updateState;

  static ShippingModel shippingModel;

  ShippingLocalData() {
    loggedInUserToken = LoginLocalData.userToken;
  }
}

import 'package:store_go/settings/model/entities/manager_settings_response.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';

class ShippingModel {
  List<ShippingPriceList> shippingAreas =
      SettingsLocalData.managerSettings.data.shippingPriceList;

  dynamic shippingEnableState =
      SettingsLocalData.managerSettings.data.enableShippingPriceList;
}

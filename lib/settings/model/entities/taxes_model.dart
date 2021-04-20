import 'package:store_go/settings/model/data/settings_local_data.dart';

class TaxesModel {
  int taxNumber =
      int.parse(SettingsLocalData.managerSettings.data.taxNumber) ?? 00;
  double taxFare =
      double.parse(SettingsLocalData.managerSettings.data.taxValue) ?? 0.0;

  dynamic taxesEnableState = SettingsLocalData.managerSettings.data.enableTax;
}

import 'package:store_go/settings/model/data/settings_local_data.dart';

class StoreSettingsModel {
  String storeNotificationEmail =
      SettingsLocalData.managerSettings.data.notificationEmail ?? 'غير محدد';
  String storeDescription =
      SettingsLocalData.managerSettings.data.description ?? 'غير محدد';
  String storeBillNotes =
      SettingsLocalData.managerSettings.data.billNotes ?? 'غير محدد';
  String storeBillName =
      SettingsLocalData.managerSettings.data.billName ?? 'غير محدد';
  String storeName = SettingsLocalData.managerSettings.data.name ?? 'غير محدد';

  dynamic storeEnableState = SettingsLocalData.managerSettings.data.enableStore;
}

import 'package:store_go/settings/model/data/settings_local_data.dart';

class DisplaySettingsModel {
  String bottomImageName =
      SettingsLocalData.managerSettings.data.footerLogoName ?? '';
  String whatsappNumber =
      SettingsLocalData.managerSettings.data.whatsappNumber ??
          'لا يوجد رقم مضاف';
  String browserImageName =
      SettingsLocalData.managerSettings.data.faviconName ?? '';
  String instagramLink = SettingsLocalData.managerSettings.data.instagramUrl ??
      'لا يوجد رابط مدخل';
  String coverImageName =
      SettingsLocalData.managerSettings.data.bannerName ?? '';
  String facebookLink =
      SettingsLocalData.managerSettings.data.facebookUrl ?? 'لا يوجد رابط مدخل';
  String snapchatLink =
      SettingsLocalData.managerSettings.data.snapchatUrl ?? 'لا يوجد رابط مدخل';
  String twitterLink =
      SettingsLocalData.managerSettings.data.twitterUrl ?? 'لا يوجد رابط مدخل';
  String youtubeLink =
      SettingsLocalData.managerSettings.data.youtubeUrl ?? 'لا يوجد رابط مدخل';
  String logoImageName = SettingsLocalData.managerSettings.data.logoName ?? '';
  String bottomLogo = SettingsLocalData.managerSettings.data.footerLogo ?? '';
  String browserIcon = SettingsLocalData.managerSettings.data.favicon ?? '';
  String tiktokLink =
      SettingsLocalData.managerSettings.data.tiktokUrl ?? 'لا يوجد رابط مدخل';
  String coverImage = SettingsLocalData.managerSettings.data.banner ?? '';
  String logoImage = SettingsLocalData.managerSettings.data.logo ?? '';
}

import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:flutter/material.dart';

class DisplaySettingsPresenter {
  String getImageHintText(int index) {
    if (index == 0)
      return 'صورة الغلاف';
    else if (index == 1)
      return 'الشعار';
    else if (index == 2)
      return 'أيقونة المتصفح';
    else
      return 'الشعار السفلى';
  }

  bool getImageStatus(String imageString) {
    if (imageString == '' || imageString == null)
      return false;
    else
      return true;
  }

  String handleImageName(String currentImageName) {
    if (currentImageName == '' || currentImageName == null)
      return 'images/no_image.jpg';
    else
      return currentImageName;
  }

  ImageProvider loadingImageTypeHandler(
      bool imagesStatus, String localImagePath, String networkLinkPath) {
    if (imagesStatus == false)
      return AssetImage(localImagePath);
    else
      return NetworkImage(networkLinkPath);
  }

  void uploadImageStatesHandler(
      bool networkConnectionState,
      bool uploadImageState,
      Function successUpload,
      Function failureUpload,
      Function networkFailure) {
    if (networkConnectionState && uploadImageState)
      successUpload();
    else if (networkConnectionState && !uploadImageState)
      failureUpload();
    else
      networkFailure();
  }

  void handleSocialAccountsFilling() {
    switch (DisplaySettingsLocalData.currentTextFieldId) {
      case 1:
        DisplaySettingsLocalData.displaySettingsModel.facebookLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 2:
        DisplaySettingsLocalData.displaySettingsModel.instagramLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 3:
        DisplaySettingsLocalData.displaySettingsModel.snapchatLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 4:
        DisplaySettingsLocalData.displaySettingsModel.tiktokLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 5:
        DisplaySettingsLocalData.displaySettingsModel.twitterLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 6:
        DisplaySettingsLocalData.displaySettingsModel.youtubeLink =
            DisplaySettingsLocalData.submittedString;
        break;
      case 7:
        DisplaySettingsLocalData.displaySettingsModel.whatsappNumber =
            DisplaySettingsLocalData.submittedString;
        break;
    }
  }

  String returnTextFieldText(String labelString) {
    if (labelString == 'لا يوجد رابط مدخل' || labelString == 'لا يوجد رقم مضاف')
      return '';
    else
      return labelString;
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

import 'package:store_go/display_settings/model/service/update_store_display_settings.dart';
import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:store_go/display_settings/model/entities/upload_image_response.dart';
import 'package:store_go/display_settings/presenter/display_settings_presenter.dart';
import 'package:store_go/display_settings/model/entities/store_settings_image.dart';
import 'package:store_go/display_settings/model/service/upload_selected_image.dart';
import 'package:store_go/display_settings/model/entities/single_account_cell.dart';
import 'package:store_go/display_settings/view/social_account_cell.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/widgets/elevated_button_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/dialogs/image_dialog.dart';
import 'package:store_go/widgets/text_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:io';

class DisplaySettings extends StatefulWidget {
  @override
  _DisplaySettingsState createState() => _DisplaySettingsState();
}

class _DisplaySettingsState extends State<DisplaySettings> {
  final _updateDisplaySettings = UpdateDisplaySettings();
  final _uploadSelectedImage = UploadSelectedImage();
  final _loadingKeyLoader = GlobalKey<State>();
  final _imageKeyLoader = GlobalKey<State>();
  final _loadingKey = GlobalKey<State>();
  final _presenter = DisplaySettingsPresenter();
  final _picker = ImagePicker();

  final _accounts = [
    SingleAccount(
        labelString: DisplaySettingsLocalData.displaySettingsModel.facebookLink,
        hintString: 'قم بإدخال رابط فيسبوك جديد',
        imageIconString: 'images/facebook_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 1),
    SingleAccount(
        labelString:
            DisplaySettingsLocalData.displaySettingsModel.instagramLink,
        hintString: 'قم بإدخال رابط أنستجرام جديد',
        imageIconString: 'images/instagram_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 2),
    SingleAccount(
        labelString: DisplaySettingsLocalData.displaySettingsModel.snapchatLink,
        hintString: 'قم بإدخال رابط سناب شات جديد',
        imageIconString: 'images/snapchat_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 3),
    SingleAccount(
        labelString: DisplaySettingsLocalData.displaySettingsModel.tiktokLink,
        hintString: 'قم بإدخال رابط تيكتوك جديد',
        imageIconString: 'images/tiktok_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 4),
    SingleAccount(
        labelString: DisplaySettingsLocalData.displaySettingsModel.twitterLink,
        hintString: 'قم بإدخال رابط تويتر جديد',
        imageIconString: 'images/twitter_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 5),
    SingleAccount(
        labelString: DisplaySettingsLocalData.displaySettingsModel.youtubeLink,
        hintString: 'قم بإدخال رابط قناة يوتيوب جديد',
        imageIconString: 'images/youtube_icon.png',
        textInputType: TextInputType.emailAddress,
        id: 6),
    SingleAccount(
        labelString:
            DisplaySettingsLocalData.displaySettingsModel.whatsappNumber,
        hintString: 'قم بإدخال رقم واتساب جديد',
        imageIconString: 'images/whatsapp_icon.png',
        textInputType: TextInputType.number,
        id: 7),
  ];

  List<StoreSettingsImage> storeSettingsImages = [];

  DisplaySettingsLocalData localData;

  var singleStoreSettingsImage = StoreSettingsImage();
  var currentId;

  @override
  void initState() {
    localData = DisplaySettingsLocalData();
    storeSettingsImages = [
      StoreSettingsImage(
          imageId: 0,
          imageState: _presenter.getImageStatus(
              DisplaySettingsLocalData.displaySettingsModel.coverImage),
          imageName: _presenter.handleImageName(
              DisplaySettingsLocalData.displaySettingsModel.coverImageName),
          imagePath:
              '${DisplaySettingsLocalData.displaySettingsModel.coverImage}'),
      StoreSettingsImage(
          imageId: 1,
          imageState: _presenter.getImageStatus(
              DisplaySettingsLocalData.displaySettingsModel.logoImage),
          imageName: _presenter.handleImageName(
              DisplaySettingsLocalData.displaySettingsModel.logoImageName),
          imagePath:
              '${DisplaySettingsLocalData.displaySettingsModel.logoImage}'),
      StoreSettingsImage(
          imageId: 2,
          imageState: _presenter.getImageStatus(
              DisplaySettingsLocalData.displaySettingsModel.browserIcon),
          imageName: _presenter.handleImageName(
              DisplaySettingsLocalData.displaySettingsModel.browserImageName),
          imagePath:
              '${DisplaySettingsLocalData.displaySettingsModel.browserIcon}'),
      StoreSettingsImage(
          imageId: 3,
          imageState: _presenter.getImageStatus(
              DisplaySettingsLocalData.displaySettingsModel.bottomLogo),
          imageName: _presenter.handleImageName(
              DisplaySettingsLocalData.displaySettingsModel.bottomImageName),
          imagePath:
              '${DisplaySettingsLocalData.displaySettingsModel.bottomLogo}')
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 37),
                      TextDrawer(
                          text: 'إعدادات المظهر',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 21.0),
                      GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey[500],
                            size: 40.0,
                          ),
                          onTap: () => Navigator.pop(context))
                    ],
                  ),
                  SizedBox(height: 50.0),
                  inflateStoreImagesList(),
                  SizedBox(height: 70.0),
                  inflateSocialAccountsList(),
                  SizedBox(height: 15.0),
                  ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: ElevatedButtonDrawer(
                          onPressed: updateDisplaySettings)),
                  SizedBox(height: 15.0)
                ],
              ),
            )),
      ),
    );
  }

  Widget inflateStoreImagesList() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(storeSettingsImages.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _presenter.loadingImageTypeHandler(
                              storeSettingsImages[index].imageState,
                              storeSettingsImages[index].imageName,
                              storeSettingsImages[index].imagePath)),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      border: Border.all(
                        color: Colors.grey[300],
                      )),
                ),
                onTap: () {
                  singleStoreSettingsImage = storeSettingsImages[index];
                  currentId = storeSettingsImages[index].imageId;
                  getImage();
                },
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
                flex: 1,
                child: TextDrawer(
                    text: _presenter.getImageHintText(index),
                    textAlign: TextAlign.center,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[900]))
          ],
        );
      }),
    );
  }

  void getImage() {
    ImageDialog.showImageDialog(
        context, _imageKeyLoader, getImageFromGallery, getImageFromCamera);
  }

  Future getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile.path);
    uploadImageToServer(DisplaySettingsLocalData.uploadFileServiceLink,
        localData.userLoggedInToken, image, image.path.toString(), 'image');
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    File image = File(pickedFile.path);
    uploadImageToServer(DisplaySettingsLocalData.uploadFileServiceLink,
        localData.userLoggedInToken, image, image.path.toString(), 'image');
  }

  void uploadImageToServer(String uploadLink, String userToken,
      File selectedFile, String path, String selectedType) {
    LoadingDialog.showLoadingDialog(context, _loadingKeyLoader);
    _uploadSelectedImage
        .uploadImage(uploadLink, userToken, selectedFile, path, selectedType)
        .then((uploadResponse) => _presenter.uploadImageStatesHandler(
            DisplaySettingsLocalData.networkConnectionState,
            DisplaySettingsLocalData.imageUploadState,
            () => successImageUpload(uploadResponse),
            () => dataFailure(),
            () => connectionTimeOut()));
  }

  successImageUpload(UploadImageResponse uploadResponse) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    updateStoreSettingsImage(uploadResponse.path, uploadResponse.fileName);
  }

  updateStoreSettingsImage(String returnedPath, String returnedFileName) {
    final otherNewImage =
        storeSettingsImages.firstWhere((item) => item.imageId == currentId);
    // productOtherImagesNames.add(returnedFileName);
    setState(() {
      otherNewImage.imageName = returnedFileName;
      otherNewImage.imagePath = returnedPath;
      otherNewImage.imageState = true;
    });
  }

  Widget inflateSocialAccountsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      padding: EdgeInsets.only(bottom: 10.0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _accounts
                .map((account) => SocialAccountCell(
                      textFieldLabel: account.labelString,
                      textFieldHint: account.hintString,
                      imageIconName: account.imageIconString,
                      textInputType: account.textInputType,
                      socialAccountID: account.id,
                      onSubmitMethod: () =>
                          _presenter.handleSocialAccountsFilling(),
                    ))
                .toList());
      },
    );
  }

  updateDisplaySettings() {
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _updateDisplaySettings
        .getUpdateResponse(
            DisplaySettingsLocalData.updateStoreServiceLink,
            localData.userLoggedInToken,
            storeSettingsImages[1].imageName ?? '',
            storeSettingsImages[0].imageName ?? '',
            storeSettingsImages[3].imageName ?? '',
            storeSettingsImages[2].imageName ?? '',
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.facebookLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.instagramLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.snapchatLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.tiktokLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.twitterLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.youtubeLink),
            _presenter.returnTextFieldText(
                DisplaySettingsLocalData.displaySettingsModel.whatsappNumber))
        .then((value) => _presenter.serviceCallHandler(
            DisplaySettingsLocalData.networkConnectionState,
            DisplaySettingsLocalData.updateState,
            () => successStoreUpdate(),
            () => dataFailure(),
            () => connectionTimeOut()));
  }

  successStoreUpdate() {
    Navigator.of(context).pop();
    DisplaySettingsLocalData.hintMessage = 'تم الحفظ';
    showToast();
    updateManagerSettingsModel();
  }

  void updateManagerSettingsModel() {
    SettingsLocalData.managerSettings.data.bannerName =
        storeSettingsImages[0].imageName;
    SettingsLocalData.managerSettings.data.banner =
        storeSettingsImages[0].imagePath;

    SettingsLocalData.managerSettings.data.logoName =
        storeSettingsImages[1].imageName;
    SettingsLocalData.managerSettings.data.logo =
        storeSettingsImages[1].imagePath;

    SettingsLocalData.managerSettings.data.faviconName =
        storeSettingsImages[2].imageName;
    SettingsLocalData.managerSettings.data.favicon =
        storeSettingsImages[2].imagePath;

    SettingsLocalData.managerSettings.data.footerLogoName =
        storeSettingsImages[3].imageName;
    SettingsLocalData.managerSettings.data.footerLogo =
        storeSettingsImages[3].imagePath;
  }

  dataFailure() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    DisplaySettingsLocalData.hintMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  connectionTimeOut() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    DisplaySettingsLocalData.hintMessage =
        'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  void showToast() {
    Toast.show(DisplaySettingsLocalData.hintMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}

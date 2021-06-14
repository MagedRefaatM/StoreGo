import 'package:store_go/my_info/model/services/files/delete_selected_image.dart';
import 'package:store_go/my_info/model/services/files/upload_selected_image.dart';
import 'package:store_go/my_info/model/entities/update_profile_response.dart';
import 'package:store_go/my_info/model/services/update_manager_profile.dart';
import 'package:store_go/my_info/model/entities/upload_image_response.dart';
import 'package:store_go/my_info/model/entities/delete_image_response.dart';
import 'package:store_go/my_info/model/services/logout_api_service.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:store_go/my_info/presenter/my_info_presenter.dart';
import 'package:store_go/dialogs/profile_image_delete_dialog.dart';
import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/dialogs/profile_image_dialog.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/dialogs/image_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:io';

class MyInfo extends StatefulWidget {
  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  final _userPhoneNumberController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _uploadProfileImage = UploadSelectedImage();
  final _deleteProfileImage = DeleteSelectedImage();
  final _getUpdateResponse = GetUpdateProfileResponse();
  final _getLogoutResponse = LogoutAPIService();
  final _imageSelectionKey = GlobalKey<State>();
  final _profileDeleteKey = GlobalKey<State>();
  final _profileImageKey = GlobalKey<State>();
  final _imagePicker = ImagePicker();
  final _loadingKey = GlobalKey<State>();
  final _presenter = MyInfoPresenter();

  MyInfoLocalData localData;

  @override
  void initState() {
    localData = MyInfoLocalData();
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
                            text: 'معلوماتى',
                            maxLines: 1,
                            textAlign: TextAlign.end,
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
                    SizedBox(height: 30.0),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              radius: 80.5,
                              backgroundColor: Colors.grey[300],
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    MyInfoLocalData.managerProfileInfo.image),
                              ),
                            ),
                            onTap: () =>
                                ProfileImageDialog.showProfileImageDialog(
                                    context,
                                    _profileImageKey,
                                    () => getImage(),
                                    () => deleteImage(),
                                    () => Navigator.of(context).pop()),
                          ),
                          SizedBox(height: 5.0),
                          TextDrawer(
                              text: 'الصورة الشخصية',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0),
                        ]),
                    SizedBox(height: 20.0),
                    drawProfileSectionsTextField(
                        TextInputAction.next,
                        TextInputType.name,
                        'اسم جديد',
                        MyInfoLocalData.managerProfileInfo.name,
                        false,
                        _userNameController),
                    SizedBox(height: 10.0),
                    drawProfileSectionsTextField(
                        TextInputAction.next,
                        TextInputType.emailAddress,
                        'بريد إلكترونى جديد',
                        MyInfoLocalData.managerProfileInfo.email,
                        false,
                        _userEmailController),
                    SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 60,
                                  child: Center(
                                      child: TextDrawer(
                                          text: '+966',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0)),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[400]),
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                ))),
                        SizedBox(width: 5.0),
                        Expanded(
                            flex: 4,
                            child: drawProfileSectionsTextField(
                                TextInputAction.next,
                                TextInputType.number,
                                'رقم جوال جديد',
                                MyInfoLocalData.managerProfileInfo.mobile,
                                false,
                                _userPhoneNumberController)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    drawProfileSectionsTextField(
                        TextInputAction.done,
                        TextInputType.name,
                        "كلمة مرور جديدة",
                        'أدخل كلمة مرور جديدة لتغيير كلمة المرور',
                        true,
                        _userPasswordController),
                    SizedBox(height: 15.0),
                    ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Colors.deepPurpleAccent))),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent)),
                            onPressed: () => updateManagerProfile(),
                            child: Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
                                child: TextDrawer(
                                    text: 'حفظ',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700)))),
                    SizedBox(height: 15.0)
                  ],
                )),
          )),
    );
  }

  Widget drawProfileSectionsTextField(
      TextInputAction inputAction,
      TextInputType inputType,
      String hintString,
      String labelString,
      bool obscureTextState,
      TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextFieldDrawer(
        textAlign: TextAlign.center,
        inputAction: inputAction,
        inputType: inputType,
        obscureText: obscureTextState,
        controller: controller,
        maxLines: 1,
        borderRadius: 5.0,
        hintFontSize: 17.0,
        hintText: hintString,
        labelText: labelString,
      ),
    );
  }

  void getImage() {
    ImageDialog.showImageDialog(
        context, _imageSelectionKey, getImageFromGallery, getImageFromCamera);
  }

  Future getImageFromGallery() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile.path);
    uploadImageToServer(localData.uploadImagesServiceLink,
        localData.loggedInUserToken, image, image.path.toString(), 'image');
  }

  Future getImageFromCamera() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
    File image = File(pickedFile.path);
    uploadImageToServer(localData.uploadImagesServiceLink,
        localData.loggedInUserToken, image, image.path.toString(), 'image');
  }

  void uploadImageToServer(String uploadLink, String userToken,
      File selectedFile, String path, String selectedType) {
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _uploadProfileImage
        .uploadImage(uploadLink, userToken, selectedFile, path, selectedType)
        .then((uploadResponse) => _presenter.serviceCallHandler(
            MyInfoLocalData.networkConnectionState,
            MyInfoLocalData.imageUploadedState,
            () => successImageUpload(uploadResponse),
            () => failureImageUpload(),
            () => imageUploadConnectionTimeout()));
  }

  successImageUpload(UploadImageResponse uploadResponse) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    setState(() {
      MyInfoLocalData.managerProfileInfo.imageName = uploadResponse.fileName;
      MyInfoLocalData.managerProfileInfo.image = uploadResponse.path;
    });
  }

  failureImageUpload() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    localData.updateMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  imageUploadConnectionTimeout() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    localData.updateMessage = 'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  void deleteImage() {
    _presenter.checkImageState(MyInfoLocalData.managerProfileInfo.imageStatus,
        () => onImageExists(), () => onImageEmpty());
  }

  void onImageExists() => DeleteProfileImageDialog.showDeleteProfileImageDialog(
      context,
      _profileDeleteKey,
      removeMainImage,
      () => Navigator.of(context).pop());

  void onImageEmpty() {
    Navigator.of(context).pop();
    localData.updateMessage = 'لا توجد صورة شخصية مضافة';
    showToast();
  }

  void removeMainImage() {
    MyInfoLocalData.managerProfileInfo.imageStatus = 0;
    Navigator.of(context).pop();
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _deleteProfileImage
        .getDeleteResponse(
            localData.deleteImageServiceLink,
            localData.loggedInAcceptLanguage,
            MyInfoLocalData.managerProfileInfo.imageName,
            localData.loggedInUserToken)
        .then((deleteResponse) => _presenter.serviceCallHandler(
            MyInfoLocalData.networkConnectionState,
            MyInfoLocalData.imageDeleteState,
            () => successMainImageDelete(deleteResponse),
            () => failureMainImageDelete(),
            () => deleteConnectionTimeout()));
  }

  successMainImageDelete(DeleteResponseData deleteResponse) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    setState(() =>
        MyInfoLocalData.managerProfileInfo.image = deleteResponse.defaultImage);
  }

  failureMainImageDelete() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    localData.updateMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  deleteConnectionTimeout() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    localData.updateMessage = 'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  updateManagerProfile() {
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _getUpdateResponse
        .getUpdateResponse(
            localData.updateManagerProfileLink,
            localData.loggedInAcceptLanguage,
            localData.loggedInUserToken,
            _presenter.getTextFieldText(
                _userNameController, MyInfoLocalData.managerProfileInfo.name),
            _presenter.getTextFieldText(
                _userEmailController, MyInfoLocalData.managerProfileInfo.email),
            _presenter.handleUserPassword(_userPasswordController),
            _presenter.getTextFieldText(_userPhoneNumberController,
                MyInfoLocalData.managerProfileInfo.mobile),
            _presenter.handleProfileImageName(
                MyInfoLocalData.managerProfileInfo.imageName))
        .then((updateResponse) => _presenter.serviceCallHandler(
            MyInfoLocalData.networkConnectionState,
            MyInfoLocalData.updateState,
            () => successProfileUpdate(updateResponse),
            () => failureProfileUpdate(),
            () => profileUpdateTimeout()));
  }

  successProfileUpdate(UpdateProfileResponse updateResponse) {
    Navigator.of(context).pop();
    localData.updateMessage = 'تم الحفظ';
    showToast();
    _presenter.updateBehaviorHandler(MyInfoLocalData.passwordChangeState,
        () => postLogoutRequest(), () => updateUserInfo(updateResponse));
  }

  failureProfileUpdate() {
    Navigator.of(context).pop();
    localData.updateMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  profileUpdateTimeout() {
    Navigator.of(context).pop();
    localData.updateMessage = 'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  updateUserInfo(UpdateProfileResponse updateResponse) {
    LoginLocalData.userImageLink = updateResponse.user.image;
    LoginLocalData.userToken = updateResponse.user.token;
    LoginLocalData.userEmail = updateResponse.user.email;
    LoginLocalData.userName = updateResponse.user.name;
    LoginLocalData.userId = updateResponse.user.id.toString();
  }

  postLogoutRequest() {
    _getLogoutResponse
        .getLogoutResponse(localData.logoutServiceLink,
            localData.loggedInAcceptLanguage, localData.loggedInUserToken)
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, '/login_page', (route) => false));
  }

  void showToast() {
    Toast.show(localData.updateMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userPasswordController.dispose();
    _userPhoneNumberController.dispose();
    _userEmailController.dispose();
    super.dispose();
  }
}

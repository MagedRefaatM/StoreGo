import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/my_account/model/service/update_account_service.dart';
import 'package:store_go/my_account/model/service/upload_file_service.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:store_go/my_account/presenter/my_account_presenter.dart';
import 'package:store_go/drawers/elevated_button_drawer.dart';
import 'package:store_go/my_account/view/document_cell.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:mime/mime.dart';
import 'dart:io';

class MyAccountInfo extends StatefulWidget {
  @override
  _MyAccountInfoState createState() => _MyAccountInfoState();
}

class _MyAccountInfoState extends State<MyAccountInfo> {
  var currentSelectedLicence =
      MyAccountLocalData.accountInformation.licenseType;
  var currentSelectedBank = MyAccountLocalData.banksList
      .firstWhere((element) =>
          element.id == int.parse(MyAccountLocalData.accountInformation.bankId))
      .name;
  var selectedBankId;

  final _accountOwnerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _englishNameController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _arabicNameController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _ibanController = TextEditingController();

  final _keyLoader = new GlobalKey<State>();
  final _updateAccount = UpdateAccountService();
  final _uploadFile = UploadSelectedFile();
  final _presenter = MyAccountPresenter();

  final licenceTypes = ["Commercial Record", "Freelance"];
  final banks = MyAccountLocalData.banksList;

  List<Document> commercialDocuments =
      MyAccountLocalData.accountInformation.businessDocuments ?? [];
  List<Document> bankDocuments =
      MyAccountLocalData.accountInformation.bankDocuments ?? [];

  Document documentCell;
  MyAccountLocalData localData;

  @override
  void initState() {
    localData = MyAccountLocalData();
    selectedBankId = MyAccountLocalData.banksList
        .firstWhere((element) => element.name == currentSelectedBank)
        .id;
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                    SizedBox(height: 90.0),
                    Center(
                        child: TextDrawer(
                            text: 'معلومات النشاط التجارى',
                            maxLines: 1,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                            fontSize: 21.0)),
                    SizedBox(height: 20.0),
                    drawSectionText('نوع الترخيص'),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                iconSize: 0.0,
                                hint: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 30.0),
                                          ),
                                          Container(
                                              child: TextDrawer(
                                                  text: "السجل التجارى",
                                                  textAlign: TextAlign.start,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18.0))
                                        ])),
                                value: currentSelectedLicence,
                                isDense: true,
                                isExpanded: true,
                                onChanged: (newValue) => setState(
                                    () => currentSelectedLicence = newValue),
                                items: licenceTypes.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: TextDrawer(text: value));
                                }).toList(),
                              )));
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    drawSectionText("الرقم الضريبى (إختيارى)"),
                    SizedBox(height: 10.0),
                    drawTextField(
                        "الرقم الضريبى",
                        MyAccountLocalData
                                .accountInformation.vatRegistrationNumber ??
                            "الرقم الضريبى",
                        _taxNumberController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText("تاريخ إنتهاء السجل التجارى"),
                    SizedBox(height: 10.0),
                    drawTextField(
                        "تاريخ إنتهاء السجل التجارى",
                        MyAccountLocalData.accountInformation
                                .commercialRegistryExpiryDate ??
                            "تاريخ إنتهاء السجل التجارى",
                        _expireDateController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText("(EN) الأسم التجارى"),
                    SizedBox(height: 10.0),
                    drawTextField(
                        "(EN) الأسم التجارى",
                        MyAccountLocalData.accountInformation.businessNameEn ??
                            "(EN) الأسم التجارى",
                        _englishNameController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText("(AR) الأسم التجارى"),
                    SizedBox(height: 10.0),
                    drawTextField(
                        "(AR) الأسم التجارى",
                        MyAccountLocalData.accountInformation.businessNameAr ??
                            "(AR) الأسم التجارى",
                        _arabicNameController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText("العنوان"),
                    SizedBox(height: 10.0),
                    drawTextField(
                        "العنوان",
                        MyAccountLocalData.accountInformation.businessAddress ??
                            "العنوان",
                        _addressController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText("الهاتف"),
                    SizedBox(height: 10.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, bottom: 1.5),
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
                                            Radius.circular(5.0)))),
                              )),
                          SizedBox(width: 5.0),
                          Expanded(
                              flex: 4,
                              child: drawTextField(
                                  'الهاتف',
                                  MyAccountLocalData
                                          .accountInformation.businessMobile ??
                                      "الهاتف",
                                  _phoneNumberController,
                                  TextInputType.number,
                                  TextInputAction.done)),
                        ]),
                    SizedBox(height: 60.0),
                    Padding(
                        padding: EdgeInsets.only(right: 11.0),
                        child: drawSectionText(
                            "حمل الوثائق المطلوبة (حد أقصى 5 ملفات)")),
                    TextDrawer(
                        text: '... سجل تجارى ، وثيقة عمل حر ، بطاقة هوية',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0),
                    SizedBox(height: 15.0),
                    inflateUploadDocumentsButton(commercialDocuments, 0),
                    SizedBox(height: 10.0),
                    inflateCommercialDocumentsList(),
                    SizedBox(height: 50.0),
                    Container(
                        child: Divider(
                      color: Colors.black,
                      height: 1.0,
                    )),
                    SizedBox(height: 50.0),
                    Center(
                        child: TextDrawer(
                            text: 'معلومات الحساب البنكى',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                            fontSize: 21.0,
                            color: Colors.black)),
                    SizedBox(height: 5.0),
                    TextDrawer(
                        text:
                            'هذا الحساب سيستخدم لتسوية المدفوعات الواصلة لك عبر أجهزة نقاط البيع',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    SizedBox(height: 20.0),
                    drawSectionText('البنك'),
                    SizedBox(height: 10.0),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                iconSize: 0.0,
                                hint: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 30.0),
                                        ),
                                        Container(
                                            child: TextDrawer(
                                                text: "حدد البنك",
                                                textAlign: TextAlign.start,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.0)),
                                      ],
                                    )),
                                value: currentSelectedBank,
                                isDense: true,
                                isExpanded: true,
                                onChanged: (newValue) => setState(() {
                                  currentSelectedBank = newValue;
                                  selectedBankId = MyAccountLocalData.banksList
                                      .firstWhere((element) =>
                                          element.name == currentSelectedBank)
                                      .id;
                                }),
                                items: banks.map((bank) {
                                  return DropdownMenuItem<String>(
                                      value: bank.name,
                                      child: TextDrawer(text: bank.name));
                                }).toList(),
                              )),
                            );
                          },
                        )),
                    SizedBox(height: 20.0),
                    drawSectionText('(IBAN) رقم الحساب المصرفى'),
                    SizedBox(height: 10.0),
                    drawTextField(
                        '(IBAN) رقم الحساب المصرفى',
                        MyAccountLocalData.accountInformation.ibanNumber ??
                            "(IBAN) رقم الحساب المصرفى",
                        _ibanController,
                        TextInputType.text,
                        TextInputAction.next),
                    SizedBox(height: 20.0),
                    drawSectionText('اسم صاحب الحساب'),
                    SizedBox(height: 10.0),
                    drawTextField(
                        'اسم صاحب الحساب',
                        MyAccountLocalData.accountInformation.beneficiaryName ??
                            "اسم صاحب الحساب",
                        _accountOwnerNameController,
                        TextInputType.name,
                        TextInputAction.done),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.only(right: 11.0),
                        child: drawSectionText(
                            "حمل الوثائق المطلوبة (حد أقصى 5 ملفات)")),
                    TextDrawer(
                        text:
                            'حمل صورة بطاقة الايبان أو كشف حساب موضح فيه رقم الايبان وإسم المنشأة',
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0),
                    SizedBox(height: 15.0),
                    inflateUploadDocumentsButton(bankDocuments, 1),
                    SizedBox(height: 10.0),
                    inflateBanksDocumentsList(),
                    SizedBox(height: 60.0),
                    ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child:
                            ElevatedButtonDrawer(onPressed: updateAccountInfo)),
                    SizedBox(height: 20.0)
                  ],
                )),
          )),
    );
  }

  Widget drawSectionText(String sectionText) {
    return TextDrawer(
        text: sectionText,
        maxLines: 1,
        textAlign: TextAlign.center,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 15.0);
  }

  Widget drawTextField(
      String hintText,
      String labelText,
      TextEditingController controller,
      TextInputType type,
      TextInputAction action) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFieldDrawer(
        textAlign: TextAlign.center,
        inputAction: action,
        inputType: type,
        controller: controller,
        maxLines: 1,
        borderRadius: 5.0,
        hintFontSize: 15.0,
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }

  Widget inflateUploadDocumentsButton(
      List<Document> workingOnList, int documentType) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: GestureDetector(
          child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: Image.asset("images/upload.png")),
                    Expanded(
                        flex: 1,
                        child: TextDrawer(
                            text: 'حدد الملف للتحميل',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0)),
                  ]),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[600], width: 0.5),
                borderRadius: BorderRadius.circular(5),
              )),
          onTap: () => _presenter.checkUploadDocumentsMax(
              workingOnList.length,
              () => openFileExplorer(workingOnList, documentType),
              () => onMaximumDocumentsReach())),
    );
  }

  Widget inflateCommercialDocumentsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: commercialDocuments
                .map((document) => DocumentCell(
                      deleteFunction: () =>
                          setState(() => commercialDocuments.remove(document)),
                      filePreviewWidget: _presenter.previewingFileHandler(
                          fileTypeGetter(document.fullUrl), document.fullUrl),
                    ))
                .toList());
      },
    );
  }

  Widget inflateBanksDocumentsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: bankDocuments
                .map((document) => DocumentCell(
                      deleteFunction: () =>
                          setState(() => bankDocuments.remove(document)),
                      filePreviewWidget: _presenter.previewingFileHandler(
                          fileTypeGetter(document.fullUrl), document.fullUrl),
                    ))
                .toList());
      },
    );
  }

  void onMaximumDocumentsReach() {
    MyAccountLocalData.stateMessage = 'تم الوصول للحد الأقصى للوثائق المطلوبة';
    showToast();
  }

  void openFileExplorer(List<Document> list, int documentType) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'png']);
    File file = File(result.files.single.path);
    uploadFile(file, list, documentType);
  }

  void uploadFile(File file, List<Document> list, int documentType) {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _uploadFile.uploadFile(localData.uploadFileLink, file).then(
        (uploadResponse) => _presenter.checkConnectionState(
            MyAccountLocalData.networkConnectionState,
            MyAccountLocalData.dataSuccessState,
            () =>
                prepareNewDocumentList(list, uploadResponse.data, documentType),
            () => dataError(),
            () => connectionTimeout()));
  }

  void prepareNewDocumentList(
      List<Document> workingOnList, String path, int documentType) {
    Navigator.of(context).pop();
    documentCell = Document();
    documentCell.filePath = path;
    documentCell.fullUrl = '${MyAccountLocalData.sureBiiDomain}$path';
    documentCell.id = null;
    setState(() => workingOnList.add(documentCell));
  }

  String fileTypeGetter(String filePath) {
    String mimeStr = lookupMimeType(filePath);
    var fileType = mimeStr.split('/');
    return fileType[0].toString();
  }

  void updateAccountInfo() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _updateAccount
        .updateAccountInformation(
            localData.accountInfoUpdateLink,
            localData.userLoggedInApplicationId,
            localData.userLoggedInApplicationSecret,
            'all',
            _presenter.getTextFieldText(_ibanController,
                MyAccountLocalData.accountInformation.ibanNumber),
            _presenter.getTextFieldText(_accountOwnerNameController,
                MyAccountLocalData.accountInformation.beneficiaryName),
            currentSelectedLicence,
            _presenter.getTextFieldText(
                _expireDateController,
                MyAccountLocalData
                    .accountInformation.commercialRegistryExpiryDate),
            _presenter.getTextFieldText(_englishNameController,
                MyAccountLocalData.accountInformation.businessNameEn),
            _presenter.getTextFieldText(_arabicNameController,
                MyAccountLocalData.accountInformation.businessNameAr),
            _presenter.getTextFieldText(_addressController,
                MyAccountLocalData.accountInformation.businessAddress),
            int.parse(_presenter.getTextFieldText(_phoneNumberController,
                MyAccountLocalData.accountInformation.businessMobile)),
            selectedBankId,
            commercialDocuments,
            bankDocuments)
        .then((value) => _presenter.checkConnectionState(
            MyAccountLocalData.networkConnectionState,
            MyAccountLocalData.dataSuccessState,
            () => updateSuccess(),
            () => dataError(),
            () => connectionTimeout()));
  }

  void updateSuccess() {
    Navigator.of(context).pop();
    MyAccountLocalData.stateMessage = 'تم الحفظ';
    showToast();
  }

  void dataError() {
    Navigator.of(context).pop();
    MyAccountLocalData.stateMessage =
        'حدث خطأ ما برجاء التأكد من البيانات المدخلة';
    showToast();
  }

  void connectionTimeout() {
    Navigator.of(context).pop();
    MyAccountLocalData.stateMessage = 'برجاء التأكد من الاتصال بالإنترنت';
    showToast();
  }

  void showToast() {
    Toast.show(MyAccountLocalData.stateMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    _accountOwnerNameController.dispose();
    _phoneNumberController.dispose();
    _englishNameController.dispose();
    _expireDateController.dispose();
    _arabicNameController.dispose();
    _taxNumberController.dispose();
    _addressController.dispose();
    _ibanController.dispose();
    super.dispose();
  }
}

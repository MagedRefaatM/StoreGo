import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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

  final _accountOwnerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _englishNameController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _arabicNameController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _IBANController = TextEditingController();

  final licenceTypes = ["Commercial Record", "Freelance"];
  final banksCategories = MyAccountLocalData.banksList;

  List<dynamic> businessDocuments =
      MyAccountLocalData.accountInformation.businessDocuments ?? [];
  List<dynamic> bankDocuments =
      MyAccountLocalData.accountInformation.bankDocuments ?? [];

  String _fileName;
  List<PlatformFile> _paths;
  FileType _pickingType = FileType.any;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 25.0, right: 15.0),
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
                    Text('معلوماتى',
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'ArabicUiDisplay',
                            fontSize: 21.0,
                            color: Colors.black)),
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
                  child: Text('معلومات النشاط التجارى',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 21.0,
                          color: Colors.black)),
                ),
                SizedBox(height: 20.0),
                drawSectionText('نوع الترخيص'),
                SizedBox(height: 10.0),
                Container(
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 0.0,
                            hint: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30.0),
                                  ),
                                  Container(
                                    child: Text("السجل التجارى",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'ArabicUiDisplay',
                                            fontSize: 18.0,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            value: currentSelectedLicence,
                            isDense: true,
                            isExpanded: true,
                            onChanged: (newValue) => setState(
                                () => currentSelectedLicence = newValue),
                            items: licenceTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
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
                    MyAccountLocalData
                            .accountInformation.commercialRegistryExpiryDate ??
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
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 11.0),
                        child: Text(
                          '+966',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]),
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                        flex: 3,
                        child: drawTextField(
                            'الهاتف',
                            MyAccountLocalData
                                    .accountInformation.businessMobile ??
                                "الهاتف",
                            _phoneNumberController,
                            TextInputType.number,
                            TextInputAction.done)),
                  ],
                ),
                SizedBox(height: 60.0),
                Padding(
                    padding: EdgeInsets.only(right: 11.0),
                    child: drawSectionText(
                        "حمل الوثائق المطلوبة (حد أقصى 5 ملفات)")),
                Text(
                  '... سجل تجارى ، وثيقة عمل حر ، بطاقة هوية',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset("images/upload.png"),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'حدد الملف للتحميل',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'ArabicUiDisplay',
                                  fontSize: 15.0),
                            )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[600], width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onTap: openFileExplorer,
                ),
                SizedBox(height: 50.0),
                Container(
                    child: Divider(
                  color: Colors.black,
                  height: 1.0,
                )),
                SizedBox(height: 50.0),
                Center(
                  child: Text('معلومات الحساب البنكى',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 21.0,
                          color: Colors.black)),
                ),
                SizedBox(height: 5.0),
                Text(
                  'هذا الحساب سيستخدم لتسوية المدفوعات الواصلة لك عبر أجهزة نقاط البيع',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16,
                      color: Colors.grey),
                ),
                SizedBox(height: 20.0),
                drawSectionText('البنك'),
                SizedBox(height: 10.0),
                Container(
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 0.0,
                            hint: Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30.0),
                                  ),
                                  Container(
                                    child: Text("حدد البنك",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'ArabicUiDisplay',
                                            fontSize: 18.0,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            value: currentSelectedBank,
                            isDense: true,
                            isExpanded: true,
                            onChanged: (newValue) =>
                                setState(() => currentSelectedBank = newValue),
                            items: banksCategories.map((bank) {
                              return DropdownMenuItem<String>(
                                value: bank.name,
                                child: Text(bank.name),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                drawSectionText('(IBAN) رقم الحساب المصرفى'),
                SizedBox(height: 10.0),
                drawTextField(
                    '(IBAN) رقم الحساب المصرفى',
                    MyAccountLocalData.accountInformation.ibanNumber ??
                        "(IBAN) رقم الحساب المصرفى",
                    _IBANController,
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
                Text(
                  'حمل صورة بطاقة الايبان أو كشف حساب موضح فيه رقم الايبان وإسم المنشأة',
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset("images/upload.png"),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'حدد الملف للتحميل',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'ArabicUiDisplay',
                                  fontSize: 15.0),
                            )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[600], width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onTap: openFileExplorer,
                ),
                SizedBox(height: 60.0),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.deepPurpleAccent))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text('حفظ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w700,
                            )),
                      )),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawSectionText(String sectionText) {
    return Text(
      sectionText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'ArabicUiDisplay',
          fontSize: 15.0,
          color: Colors.black),
    );
  }

  Widget drawTextField(
      String hintText,
      String labelText,
      TextEditingController controller,
      TextInputType type,
      TextInputAction action) {
    return TextField(
      textAlign: TextAlign.end,
      textInputAction: action,
      keyboardType: type,
      controller: controller,
      maxLines: 1,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
          hintStyle: new TextStyle(
            fontSize: 15.0,
            fontFamily: 'ArabicUiDisplay',
            fontWeight: FontWeight.w300,
            color: Colors.grey[700],
          ),
          labelStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'ArabicUiDisplay',
              fontSize: 17.0,
              fontWeight: FontWeight.w600),
          hintText: hintText,
          labelText: labelText,
          fillColor: Colors.white),
    );
  }

  void openFileExplorer() async {
    _paths = (await FilePicker.platform.pickFiles(
      type: _pickingType,
      allowMultiple: false,
    ))
        ?.files;
    setState(() => _fileName =
        _paths != null ? _paths.map((e) => e.name).toString() : '...');
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
    _IBANController.dispose();
    super.dispose();
  }
}

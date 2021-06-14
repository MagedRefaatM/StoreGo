import 'package:store_go/verification/model/service/account_information_service.dart';
import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/verification/model/entities/banks_info_response.dart';
import 'package:store_go/verification/model/data/verification_local_data.dart';
import 'package:store_go/verification/presenter/verification_presenter.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:store_go/verification/model/service/logout_service.dart';
import 'package:store_go/verification/model/service/banks_service.dart';
import 'package:store_go/my_account/view/my_account_info.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:store_go/dialogs/exit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _accountInfoService = AccountInformationService();
  final _logoutAPIService = LogoutAPIService();
  final _banksAPIService = BanksInformationService();
  final _presenter = VerificationPresenter();
  final _keyLoader = new GlobalKey<State>();

  var message = '';

  VerificationLocalData localData;

  @override
  void initState() {
    localData = VerificationLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ExitDialog.showExitDialog(context, postLogoutRequest),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15.0),
              Expanded(
                  flex: 1,
                  child: TextDrawer(
                      text: 'التحقق من الحساب',
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.0,
                      color: Colors.black)),
              Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.all(9.0),
                      child: TextDrawer(
                          text:
                              "للبدء بإستقبال المدفوعات لابد من تفعيل حسابكم من خلال توفير نسخة من السجل التجارى أو وثيقة العمل الحر والهوية الشخصية و أن تكون كافة الوثائق سارية المفعول وتوفير رقم حساب بنكى بإسم مطابق لأسم منشأته فى السجلات والوثائق وقت تقديم الطلب",
                          textWidthBasis: TextWidthBasis.parent,
                          maxLines: 6,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 21.5,
                          textAlign: TextAlign.center))),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(20.0)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          side: BorderSide(
                                              color: Colors.deepPurpleAccent))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurpleAccent)),
                              onPressed: getAccountInfo,
                              child: TextDrawer(
                                  text: 'التحقق من حسابى',
                                  fontSize: 19.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800))),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'تخطي',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontFamily: 'ArabicUiDisplay',
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, '/page_view_controller')),
                        ),
                      ),
                      TextDrawer(
                          text: message,
                          textAlign: TextAlign.center,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0)
                    ],
                  )),
            ],
          ))),
    );
  }

  void getAccountInfo() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _accountInfoService
        .getAccountInformation(
            localData.accountInfoServiceLink,
            localData.userLoggedInApplicationId,
            localData.userLoggedInApplicationSecret)
        .then((accountInfoResponse) => _presenter.accountInfoResponseHandler(
            VerificationLocalData.networkConnectionPass,
            VerificationLocalData.dataConnectionPass,
            () => getAllBanks(accountInfoResponse),
            () => failureAccountConnection(),
            () => dataFailureConnection()));
  }

  void getAllBanks(AccountInformationResponse accountResponse) {
    _banksAPIService
        .getBanksList(
            localData.banksCategoryServiceLink,
            localData.userLoggedInApplicationId,
            localData.userLoggedInApplicationSecret)
        .then((banksResponse) => _presenter.accountInfoResponseHandler(
            VerificationLocalData.networkConnectionPass,
            VerificationLocalData.dataConnectionPass,
            () => navigatesToAccountInfoPage(accountResponse, banksResponse),
            () => failureAccountConnection(),
            () => dataFailureConnection()));
  }

  void navigatesToAccountInfoPage(
      AccountInformationResponse informationResponse,
      BanksInformationResponse banksResponse) {
    MyAccountLocalData.accountInformation = informationResponse.data;
    MyAccountLocalData.banksList = banksResponse.data;
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAccountInfo()));
  }

  void dataFailureConnection() {
    Navigator.of(context).pop();
    setState(() => message = 'حدث خطأ ما برجاء إعادة المحاولة');
  }

  void failureAccountConnection() {
    Navigator.of(context).pop();
    setState(() => message = 'برجاء التأكد من إتصال الإنترنت بهاتفك');
  }

  void postLogoutRequest() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _logoutAPIService
        .getLogoutResponse(localData.logoutServiceLink,
            localData.userLoggedInLanguage, localData.userLoggedInToken)
        .then((logoutResponse) => _presenter.logoutServiceHandler(
            VerificationLocalData.networkConnectionPass,
            successLogout,
            connectionTimeOut));
  }

  void successLogout() {
    Navigator.of(context).pop();
    Navigator.of(context).pop(true);
  }

  void connectionTimeOut() {
    Navigator.of(context).pop(false);
    Navigator.of(context).pop(false);
    setState(() => message = 'برجاء التأكد من إتصال الإنترنت بهاتفك');
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/verification/model/data/verification_local_data.dart';
import 'package:store_go/verification/model/service/logout_service.dart';
import 'package:store_go/verification/presenter/verification_presenter.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _logoutAPIService = LogoutAPIService();
  final _presenter = VerificationPresenter();
  final _keyLoader = new GlobalKey<State>();

  var message = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'التحقق من الحساب',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 26.0,
                      color: Colors.black),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    margin: EdgeInsets.all(9.0),
                    child: Text(
                      "للبدء بإستقبال المدفوعات لابد من تفعيل حسابكم من خلال توفير نسخة من السجل التجارى أو وثيقة العمل الحر والهوية الشخصية و أن تكون كافة الوثائق سارية المفعول وتوفير رقم حساب بنكى بإسم مطابق لأسم منشأته فى السجلات والوثائق وقت تقديم الطلب",
                      textWidthBasis: TextWidthBasis.parent,
                      maxLines: 6,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 21.5),
                      textAlign: TextAlign.center,
                    )),
              ),
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
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent))),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurpleAccent),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white)),
                            ),
                            onPressed: () {},
                            child: Text('التحقق من حسابى',
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w800))),
                      ),
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
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'ArabicUiDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  )),
            ],
          ))),
    );
  }

  Future<bool> _onBackPress() {
    setState(() => message = '');
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ArabicUiDisplay',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800),
            ),
            content: Text(
              'هل تريد تسجيل الخروج من التطبيق؟',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ArabicUiDisplay',
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "لا",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: postLogoutRequest,
                child: Text(
                  "نعم",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void postLogoutRequest() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _logoutAPIService
        .getLogoutResponse(
            VerificationLocalData.logoutServiceLink,
            VerificationLocalData.userLoggedInLanguage,
            VerificationLocalData.userLoggedInToken)
        .then((logoutResponse) => _presenter.logoutServiceHandler(
            VerificationLocalData.networkConnectionPass,
            successLogout,
            connectionTimeOut));
  }

  void successLogout() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    Navigator.of(context).pop(true);
  }

  void connectionTimeOut() {
    Navigator.of(context).pop(false);
    Navigator.of(context).pop(false);
    setState(() => message = 'برجاء التأكد من إتصال الإنترنت بهاتفك');
  }
}

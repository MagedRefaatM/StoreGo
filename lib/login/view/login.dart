import 'package:store_go/login/model/service/login_api_service.dart';
import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/login/presenter/login_presenter.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _loginAPIService = LoginAPIService();
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _presenter = LoginPresenter();
  final _keyLoader = GlobalKey<State>();

  var message = '';

  @override
  void initState() {
    _emailFocus.addListener(_onFocusChange);
    _passwordFocus.addListener(_onFocusChange);
    LoginLocalData.loginPassed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image(
                  image: AssetImage('images/icon.png'),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextDrawer(
                        text: 'دخول المسجلين',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                      child: TextFieldDrawer(
                          textAlign: TextAlign.center,
                          controller: _emailController,
                          focusNode: _emailFocus,
                          inputAction: TextInputAction.next,
                          hintFontSize: 22.0,
                          borderRadius: 10.0,
                          autoFocus: true,
                          inputType: TextInputType.emailAddress,
                          maxLines: 1,
                          hintText: "بريدك الالكتورني"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                      child: TextFieldDrawer(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        borderRadius: 10.0,
                        hintFontSize: 22.0,
                        hintText: "كلمة المرور",
                        enableSuggestions: false,
                        autoCorrect: false,
                        obscureText: true,
                        onSubmitted: (String string) => onSubmitClicked(string),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                        child: ElevatedButton(
                            onPressed: () {
                              LoginLocalData.userEmail =
                                  _emailController.text.trim().toString();
                              LoginLocalData.userPassword =
                                  _passwordController.text.toString();
                              onLoginClick();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(20.0)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: Colors.deepPurpleAccent)))),
                            child: TextDrawer(
                                text: 'دخول',
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 17.0))),
                    TextDrawer(
                        text: message ?? '.',
                        textAlign: TextAlign.center,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0)
                  ]),
            ),
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextDrawer(
                        text: 'إبداء عملك التجاري',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w700,
                        fontSize: 23.0),
                    TextDrawer(
                        text: 'لا تخسر عميلك وسهل عملية الشراء والدفع',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0),
                    SizedBox(height: 8.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1.5))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(20.0)),
                            ),
                            onPressed: () {},
                            child: TextDrawer(
                                text: 'سجل الان',
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 19.0)))
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange() => setState(() => message = '');

  void onSubmitClicked(String textFieldValue) {
    LoginLocalData.userEmail = _emailController.text.trim().toString();
    LoginLocalData.userPassword = textFieldValue;
    onLoginClick();
  }

  void onLoginClick() {
    setState(() {
      _presenter.verifyingLoginConstrains(postLoginRequest);
      message = LoginLocalData.loginMessage;
    });
  }

  void postLoginRequest() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _loginAPIService
        .getLoginResponse(
            LoginLocalData.loginServiceLink,
            LoginLocalData.loginAcceptLanguage,
            LoginLocalData.userEmail.trim(),
            LoginLocalData.userPassword)
        .then((loginResponse) => _presenter.loginCallSuccessCheck(
            LoginLocalData.loginPassed,
            LoginLocalData.networkConnectionPass,
            authorizedLogin,
            unAuthorizedLogin,
            onNetworkFailed,
            loginResponse));
  }

  void authorizedLogin() {
    Navigator.of(context).pop();

    _emailController.clear();
    _passwordController.clear();

    message = '-';

    Navigator.pushNamed(context, '/verification_page');
  }

  void onNetworkFailed() {
    Navigator.of(context).pop();
    setState(() {
      _emailController.text = '';
      _passwordController.text = '';
      message = _presenter.networkFailure();
    });
  }

  void unAuthorizedLogin() {
    Navigator.of(context).pop();
    setState(() => message = _presenter.unAuthorizedLogin());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }
}

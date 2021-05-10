import 'package:store_go/login/model/service/login_api_service.dart';
import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/login/presenter/login_presenter.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
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
                  Text(
                    'دخول المسجلين',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'ArabicUiDisplay',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                    child: TextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          hintText: "بريدك الالكتورني",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                    child: TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      onSubmitted: (String string) {
                        LoginLocalData.userEmail =
                            _emailController.text.trim().toString();
                        LoginLocalData.userPassword = string;
                        onLoginClick();
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          hintText: "كلمة المرور",
                          fillColor: Colors.white),
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
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.deepPurpleAccent)))),
                        child: Text('دخول',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w900,
                            ))),
                  ),
                  Text(
                    message ?? '.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'ArabicUiDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'إبداء عملك التجاري',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23.0,
                        letterSpacing: 1.0,
                        fontFamily: 'ArabicUiDisplay',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Text(
                    'لا تخسر عميلك وسهل عملية الشراء والدفع',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 1.0,
                        fontFamily: 'ArabicUiDisplay',
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.deepPurpleAccent, width: 1.5))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(20.0)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'سجل الان',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 19.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange() => setState(() => message = '');

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

import 'package:store_go/login/business_logic_layer/login_cubit.dart';
import 'package:store_go/login/business_logic_layer/login_state.dart';
import 'package:store_go/widgets/text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/widgets/text_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordController;
  TextEditingController _emailController;
  LoginCubit _loginCubit;
  GlobalKey _keyLoader;

  String message = '';

  @override
  void initState() {
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _keyLoader = GlobalKey<State>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15.0),
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset('images/icon.png')),
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
                        inputAction: TextInputAction.next,
                        hintFontSize: 22.0,
                        borderRadius: 10.0,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        hintText: "بريدك الالكتورني"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                    child: TextFieldDrawer(
                      controller: _passwordController,
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
                      onSubmitted: (String password) =>
                          _loginCubit.login(_emailController.text, password),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                      child: ElevatedButton(
                          onPressed: () => BlocProvider.of<LoginCubit>(context)
                              .login(_emailController.text,
                                  _passwordController.text),
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
                  BlocConsumer(
                    bloc: _loginCubit,
                    listener: (context, state) {
                      if (state is InvalidInputs)
                        message = state.errorMessage;
                      else if (state is Loading)
                        LoadingDialog.showLoadingDialog(context, _keyLoader);
                      else if (state is LoginError) {
                        Navigator.of(context).pop();
                        message = state.errorMessage;
                      } else if (state is ConnectionTimeout) {
                        Navigator.of(context).pop();
                        message = state.timeoutMessage;
                      }
                      if (state is LoginSuccess) {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/verification_page');
                      }
                    },
                    builder: (context, state) {
                      return TextDrawer(
                          text: message.toString() ?? '.',
                          textAlign: TextAlign.center,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0);
                    },
                  )
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
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20.0)),
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

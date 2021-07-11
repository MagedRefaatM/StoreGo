import 'package:store_go/verification/business_logic_layer/verification_cubit.dart';
import 'package:store_go/verification/business_logic_layer/verification_state.dart';
import 'package:store_go/my_account/presentation_layer/my_account_info.dart';
import 'package:store_go/my_account/business_logic_layer/account_bloc.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/widgets/text_drawer.dart';
import 'package:store_go/dialogs/exit_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  var _keyLoader;
  VerificationCubit _verificationCubit;
  var message;

  @override
  void initState() {
    _verificationCubit = BlocProvider.of<VerificationCubit>(context);
    message = '';
    _keyLoader = GlobalKey<State>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          ExitDialog.showExitDialog(context, _verificationCubit.logout),
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
                              onPressed: _verificationCubit.getAccountInfo,
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
                      BlocConsumer(
                        bloc: _verificationCubit,
                        listener: (context, state) {
                          if (state is Loading)
                            LoadingDialog.showLoadingDialog(
                                context, _keyLoader);
                          else if (state is AccountInfoError) {
                            message = state.errorMessage;
                          } else if (state is ConnectionTimeout) {
                            Navigator.of(context).pop();
                            message = state.timeoutMessage;
                          }
                          else if (state is AccountInfoSuccess) {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider<AccountBloc>(
                                      create: (context) => AccountBloc(),
                                      child: MyAccountInfo(
                                          accountInformation:
                                              state.accountInformation,
                                          banksList: state.banksList),
                                    )));
                          }
                          else if (state is LogoutError) {
                            Navigator.of(context).pop();
                            message = state.errorMessage;
                          }
                          else if (state is LogoutSuccess) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(true);
                          }
                        },
                        builder: (context, state) {
                          return TextDrawer(
                              text: message,
                              textAlign: TextAlign.center,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0);
                        },
                      )
                    ],
                  )),
            ],
          ))),
    );
  }
}

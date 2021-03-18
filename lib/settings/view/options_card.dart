import 'package:flutter/material.dart';
import 'package:store_go/dialogs/exit_dialog.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/settings/model/service/logout_api_service.dart';

class OptionCard extends StatefulWidget {
  final String optionName;
  final IconData optionIcon;
  final int optionId;

  OptionCard({this.optionName, this.optionIcon, this.optionId});

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  LogoutAPIService _logoutAPIService;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _logoutAPIService = LogoutAPIService();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => optionClickHandler(widget.optionId),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(
                    widget.optionIcon,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      widget.optionName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 21.5,
                          fontFamily: 'ArabicUiDisplay',
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
        ),
      ),
    );
  }

  void optionClickHandler(int optionId) {
    if (optionId == 7) ExitDialog.showExitDialog(context, postLogoutRequest);
  }

  Future<bool> exit() {
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
                onTap: () {
                  postLogoutRequest();
                },
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

  // Logout option click handler methods
  void postLogoutRequest() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _logoutAPIService
        .getLogoutResponse(SettingsLocalData.logoutServiceLink,
            SettingsLocalData.userLoggedInAcceptLanguage, SettingsLocalData.userLoggedInToken)
        .then((logoutResponse) {
      if (logoutResponse.isNotEmpty)
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      successLogout(logoutResponse);
    });
  }

  void successLogout(String message) {
    setState(() => Navigator.pushNamedAndRemoveUntil(
        context, '/login_page', (route) => false));
  }
}

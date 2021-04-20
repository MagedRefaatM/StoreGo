import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  final Function settingHandler;
  final IconData settingIcon;
  final String settingName;

  SettingsTab({this.settingHandler, this.settingIcon, this.settingName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: settingHandler,
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
                    settingIcon,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      settingName,
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
}

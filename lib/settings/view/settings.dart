import 'package:flutter/material.dart';
import 'file:///C:/Users/maged.refaat/AndroidStudioProjects/store_go/lib/settings/model/entities/single_option.dart';
import 'options_card.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<SingleOption> options = [
    SingleOption('معلوماتى', Icons.arrow_back_ios_sharp, 1),
    SingleOption('إعدادات المتجر', Icons.arrow_back_ios_sharp, 2),
    SingleOption('الضرائب', Icons.arrow_back_ios_sharp, 3),
    SingleOption('الشحن', Icons.arrow_back_ios_sharp, 4),
    SingleOption('أقسام المتجر', Icons.arrow_back_ios_sharp, 5),
    SingleOption('إعدادات المظهر', Icons.arrow_back_ios_sharp, 6),
    SingleOption('تسجيل الخروج', Icons.add_to_home_screen, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'الإعدادات',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'ArabicUiDisplay',
                  fontSize: 26.0,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 14,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: options
                        .map((option) => OptionCard(
                              optionName: option.name,
                              optionIcon: option.icon,
                              optionId: option.id,
                            ))
                        .toList()),
              ),
            ),
          )
        ],
      )),
    );
  }
}

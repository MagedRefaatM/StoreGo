import 'package:flutter/material.dart';

class StoreOptions extends StatelessWidget {
  String optionName;
  IconData optionIcon;
  int optionId;
  double optionOpacityVisibility;
  double optionMoneyAccountAmount;
  Function optionClickHandler;

  StoreOptions(
      {this.optionName,
      this.optionIcon,
      this.optionId,
      this.optionOpacityVisibility,
      this.optionMoneyAccountAmount,
      this.optionClickHandler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: optionClickHandler,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    optionIcon,
                    color: Colors.grey[800],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: optionOpacityVisibility,
                          child: Text(
                            'ريال',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 18.0,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Opacity(
                            opacity: optionOpacityVisibility,
                            child: Text(
                              '$optionMoneyAccountAmount',
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 23.0,
                                  fontFamily: 'ArabicUiDisplay',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Text(
                          optionName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 21.5,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                )
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

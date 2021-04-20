import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:flutter/material.dart';

class SocialAccountCell extends StatelessWidget {
  final String textFieldLabel;
  final String textFieldHint;
  final String imageIconName;
  final TextInputType textInputType;
  final socialAccountID;
  final onSubmitMethod;

  SocialAccountCell(
      {this.textFieldLabel,
      this.textFieldHint,
      this.imageIconName,
      this.textInputType,
      this.socialAccountID,
      this.onSubmitMethod});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: 58.0, maxWidth: 58.0),
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Image.asset(imageIconName))),
                decoration: BoxDecoration(
                    color: Color(0xffeeeeee),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[300],
                    )),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              flex: 6,
              child: TextField(
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                keyboardType: textInputType,
                maxLines: 1,
                onSubmitted: (String textFieldText) {
                  DisplaySettingsLocalData.currentTextFieldId = socialAccountID;
                  DisplaySettingsLocalData.submittedString =
                      textFieldText ?? '';
                  onSubmitMethod();
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.grey[300], width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'ArabicUiDisplay',
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[800],
                    ),
                    labelStyle: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'ArabicUiDisplay',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    hintText: textFieldHint,
                    labelText: textFieldLabel,
                    fillColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

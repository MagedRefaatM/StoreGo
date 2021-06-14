import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/taxes/model/service/update_store_taxes.dart';
import 'package:store_go/taxes/model/data/taxes_local_data.dart';
import 'package:store_go/taxes/presenter/taxes_presenter.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Taxes extends StatefulWidget {
  @override
  _TaxesState createState() => _TaxesState();
}

class _TaxesState extends State<Taxes> {
  final _storeTaxesAmountController = TextEditingController();
  final _storeTaxNumberController = TextEditingController();
  final _updateStoreTaxes = UpdateStoreTaxes();
  final _loadingKey = GlobalKey<State>();
  final _presenter = TaxesPresenter();

  TaxesLocalData localData;

  bool isStateToggleChecked;

  @override
  void initState() {
    localData = TaxesLocalData();
    isStateToggleChecked = _presenter.getTaxesState(
        int.parse(TaxesLocalData.taxesModel.taxesEnableState.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 37),
                      TextDrawer(
                          text: 'الضرائب',
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          fontWeight: FontWeight.w700,
                          fontSize: 21.0,
                          color: Colors.black),
                      GestureDetector(
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.grey[500], size: 40.0),
                          onTap: () => Navigator.pop(context))
                    ]),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextDrawer(
                        text:
                            '(${_presenter.getCurrentTaxesState(isStateToggleChecked)})',
                        maxLines: 1,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        textAlign: TextAlign.end),
                    SizedBox(width: 10.0),
                    TextDrawer(
                        text: 'تفعيل الضرائب',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        textAlign: TextAlign.end),
                    SizedBox(width: 5.0),
                    FlutterSwitch(
                      value: isStateToggleChecked,
                      activeColor: Colors.grey[300],
                      inactiveColor: Colors.deepPurpleAccent,
                      onToggle: (val) {
                        setState(() {
                          isStateToggleChecked = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Opacity(
                  opacity:
                      _presenter.getTaxesOpacityAmount(isStateToggleChecked),
                  child: IgnorePointer(
                    ignoring:
                        _presenter.getInteractionState(isStateToggleChecked),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 17.0, bottom: 17.0),
                                  child: TextDrawer(
                                      text: '%',
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[400]),
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                )),
                            SizedBox(width: 10.0),
                            Expanded(
                                flex: 3,
                                child: TextFieldDrawer(
                                    textAlign: TextAlign.center,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.number,
                                    controller: _storeTaxesAmountController,
                                    maxLines: 1,
                                    borderRadius: 5.0,
                                    hintFontSize: 17.0,
                                    hintText: "نسبة الضرائب",
                                    labelFontSize: 17.0,
                                    labelText: TaxesLocalData.taxesModel.taxFare
                                        .toString())),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        TextFieldDrawer(
                            textAlign: TextAlign.center,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.number,
                            controller: _storeTaxNumberController,
                            maxLines: 1,
                            borderRadius: 5.0,
                            hintFontSize: 17.0,
                            hintText: "الرقم الضريبى",
                            labelFontSize: 17.0,
                            labelText:
                                TaxesLocalData.taxesModel.taxNumber.toString())
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.deepPurpleAccent))),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurpleAccent)),
                      onPressed: updateStoreTaxes,
                      child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: TextDrawer(
                              text: 'حفظ',
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateStoreTaxes() {
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _updateStoreTaxes
        .getUpdateResponse(
            localData.updateStoreServiceLink,
            localData.loggedInUserToken,
            _presenter.getStoreState(isStateToggleChecked),
            _presenter.getTextFieldText(_storeTaxesAmountController,
                TaxesLocalData.taxesModel.taxFare.toString()),
            _presenter.getTextFieldText(_storeTaxNumberController,
                TaxesLocalData.taxesModel.taxNumber.toString()))
        .then((updateResponse) => _presenter.serviceCallHandler(
            TaxesLocalData.networkConnectionState,
            TaxesLocalData.updateState,
            () => successStoreUpdate(),
            () => dataFailure(),
            () => connectionTimeOut()));
  }

  successStoreUpdate() {
    Navigator.of(context).pop();
    localData.toastMessage = 'تم الحفظ';
    showToast();
    updateManagerSettingsModel();
  }

  updateManagerSettingsModel() {
    SettingsLocalData.managerSettings.data.enableTax =
        _presenter.getStoreState(isStateToggleChecked);
    SettingsLocalData.managerSettings.data.taxValue =
        _presenter.getTextFieldText(_storeTaxesAmountController,
            TaxesLocalData.taxesModel.taxFare.toString());
    SettingsLocalData.managerSettings.data.taxNumber =
        _presenter.getTextFieldText(_storeTaxNumberController,
            TaxesLocalData.taxesModel.taxNumber.toString());
  }

  dataFailure() {
    Navigator.of(context).pop();
    localData.toastMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  connectionTimeOut() {
    Navigator.of(context).pop();
    localData.toastMessage = 'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  void showToast() {
    Toast.show(localData.toastMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    _storeTaxNumberController.dispose();
    _storeTaxesAmountController.dispose();
    super.dispose();
  }
}

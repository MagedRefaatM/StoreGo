import 'package:store_go/store/model/entities/single_store_option.dart';
import 'package:store_go/store/model/service/get_products_service.dart';
import 'package:store_go/store/model/data/store_local_data.dart';
import 'package:store_go/store/presenter/store_presenter.dart';
import 'package:store_go/store/view/store_option.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/products/view/products.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<SingleStoreOption> options = [
    SingleStoreOption('محفظتى', Icons.arrow_back_ios_sharp, 1, 1.0, 0.0),
    SingleStoreOption('العملاء', Icons.arrow_back_ios_sharp, 2, 0.0, 0.0),
    SingleStoreOption('المنتجات', Icons.arrow_back_ios_sharp, 3, 0.0, 0.0)
  ];

  final _keyLoader = new GlobalKey<State>();
  final _getProducts = GetProducts();
  final _presenter = StorePresenter();

  StoreLocalData localData;

  @override
  void initState() {
    localData = StoreLocalData();
    StoreLocalData.networkConnectionState = false;
    StoreLocalData.optionClickChecker = false;
    StoreLocalData.validDataState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              TextDrawer(
                  text: 'المتجر',
                  fontWeight: FontWeight.w600,
                  fontSize: 26.0,
                  color: Colors.black),
              SizedBox(height: 20.0),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80.5,
                      backgroundColor: Colors.grey[300],
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            NetworkImage(localData.userLoggedInImageLink),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: TextDrawer(
                            text: '${localData.userLoggedInName} Store',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0)),
                  ]),
              SizedBox(height: 15.0),
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey[200]))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[200]),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    'https://${localData.userLoggedInName}.storego.io',
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 18.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w500),
                                //TODO: make onTap opens the link in external browser
                                recognizer: TapGestureRecognizer()
                                  // ..onTap = () => launch('https://faisals4.storego.io')
                                  ..onTap = () {}),
                          ),
                          SizedBox(width: 6.0),
                          TextDrawer(
                              text: 'رابط متجرك',
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              maxLines: 1)
                        ]),
                  )),
              SizedBox(height: 15.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextDrawer(
                                //TODO: take the data from the constructor
                                text: '31',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.black),
                            TextDrawer(
                                text: 'منتج',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.black)
                          ],
                        )),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 35.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextDrawer(
                                //TODO: take the data from the constructor
                                text: '390',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.black),
                            TextDrawer(
                                text: 'طلب مكتمل',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.black)
                          ],
                        )),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 35.0),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextDrawer(
                                    //TODO: take the data from the constructor
                                    text: '430',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    color: Colors.black),
                                TextDrawer(
                                    text: 'طلب',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20.0,
                                    color: Colors.black)
                              ],
                            )),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(10),
                        )))
              ]),
              SizedBox(height: 15.0),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: options
                      .map((option) => StoreOption(
                          optionName: option.name,
                          optionIcon: option.icon,
                          optionOpacityVisibility: option.opacityVisibility,
                          optionMoneyAccountAmount: option.moneyAccountAmount,
                          optionId: option.id,
                          optionClickHandler: () =>
                              _presenter.currentOptionClickFunction(
                                  StoreLocalData.optionId,
                                  onMyWalletClicked,
                                  onCustomersClicked,
                                  onProductsCLicked,
                                  StoreLocalData.optionClickChecker)))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }

  void onMyWalletClicked() {}

  void onCustomersClicked() {}

  void onProductsCLicked() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getProducts
        .getProducts(localData.productsServiceLink, localData.userLoggedInToken,
            '8', '1', '1')
        .then((productsResponse) {
      StoreLocalData.requestResponse = productsResponse;
      _presenter.handleCurrentConnectionState(
          StoreLocalData.networkConnectionState,
          StoreLocalData.validDataState,
          onConnectionSuccess,
          onConnectionError);
    });
  }

  void onConnectionError() {
    Navigator.of(context).pop();
    Toast.show(StoreLocalData.currentStateMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  void onConnectionSuccess() {
    //TODO: in the future you've to use presenter to know which option is clicked
    Navigator.of(context).pop();
    StoreLocalData.storeProducts = StoreLocalData.requestResponse.data;
    StoreLocalData.totalStoreProducts =
        StoreLocalData.requestResponse.totalProducts;
    StoreLocalData.totalPages = StoreLocalData.requestResponse.totalPages;
    StoreLocalData.totalDisplayedProducts =
        StoreLocalData.requestResponse.totalActive;
    StoreLocalData.totalNotDisplayedProducts =
        StoreLocalData.requestResponse.totalNotActive;
    StoreLocalData.totalEmptyQuantityProducts =
        StoreLocalData.requestResponse.totalEmpty;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Products()));
  }
}

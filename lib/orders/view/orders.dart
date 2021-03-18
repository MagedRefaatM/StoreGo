import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_go/orders/model/data/orders_local_data.dart';
import 'package:store_go/orders/model/service/get_orders.dart';
import 'package:store_go/orders/presenter/orders_presenter.dart';

import 'orders_card.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final _getOrders = GetOrders();
  final _presenter = OrdersPresenter();
  final _ordersScrollController = ScrollController();

  Widget currentDisplayedWidget;

  @override
  void initState() {
    OrdersLocalData.ordersDataReadyChecker = false;
    OrdersLocalData.ordersNetworkCallChecker = false;
    handleCurrentView();
    getFilteredOrders(8, OrdersLocalData.currentDisplayedOrdersPageFilter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _ordersScrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الطلبات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 26.0,
                      color: Colors.black),
                ),
                SizedBox(height: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7.0),
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: 'الكل',
                                    style: TextStyle(
                                        color: _presenter.fourthPageTextColor,
                                        fontSize: 16.0,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => setState(() {
                                            _presenter.inflateRequestTap(3);
                                            OrdersLocalData.ordersList.clear();
                                            OrdersLocalData
                                                .currentDisplayedOrdersPage = 1;
                                            OrdersLocalData
                                                .currentDisplayedOrdersPageFilter = 4;
                                            handleCurrentView();
                                            getFilteredOrders(8, 4);
                                          })),
                              ),
                            ),
                            Opacity(
                              opacity: _presenter.fourthPageIndicatorOpacity,
                              child: Container(
                                height: 1.5,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text:
                                      'تم الشحن(${OrdersLocalData.totalShippedOrdersNumber})',
                                  style: TextStyle(
                                      color: _presenter.thirdPageTextColor,
                                      fontSize: 16.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => setState(() {
                                          _presenter.inflateRequestTap(2);
                                          OrdersLocalData.ordersList.clear();
                                          OrdersLocalData
                                              .currentDisplayedOrdersPage = 1;
                                          OrdersLocalData
                                              .currentDisplayedOrdersPageFilter = 3;
                                          handleCurrentView();
                                          getFilteredOrders(8, 3);
                                        })),
                            ),
                            Opacity(
                              opacity: _presenter.thirdPageIndicatorOpacity,
                              child: Container(
                                height: 1.5,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text:
                                      'جارى التجهيز(${OrdersLocalData.totalReadyOrdersNumber})',
                                  style: TextStyle(
                                      color: _presenter.secondPageTextColor,
                                      fontSize: 16.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => setState(() {
                                          _presenter.inflateRequestTap(1);
                                          OrdersLocalData.ordersList.clear();
                                          OrdersLocalData
                                              .currentDisplayedOrdersPage = 1;
                                          OrdersLocalData
                                              .currentDisplayedOrdersPageFilter = 2;
                                          handleCurrentView();
                                          getFilteredOrders(8, 2);
                                        })),
                            ),
                            Opacity(
                              opacity: _presenter.secondPageIndicatorOpacity,
                              child: Container(
                                height: 1.5,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text:
                                      'جديد(${OrdersLocalData.totalNewOrdersNumber})',
                                  style: TextStyle(
                                      color: _presenter.firstPageTextColor,
                                      fontSize: 16.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => setState(() {
                                          _presenter.inflateRequestTap(0);
                                          OrdersLocalData.ordersList.clear();
                                          OrdersLocalData
                                              .currentDisplayedOrdersPage = 1;
                                          OrdersLocalData
                                              .currentDisplayedOrdersPageFilter = 1;
                                          handleCurrentView();
                                          getFilteredOrders(8, 1);
                                        })),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Opacity(
                              opacity: _presenter.firstPageIndicatorOpacity,
                              child: Container(
                                height: 1.5,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 19.0, right: 19.0),
                              child: Divider(
                                color: Colors.black,
                                height: 1.0,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                currentDisplayedWidget,
              ],
            ),
          ),
        ));
  }

  void showLoading() => setState(() {
        currentDisplayedWidget = Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
          ),
        );
      });

  void showError() => setState(() {
        currentDisplayedWidget = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.0),
            Text(
              'حدث خطأ ما برجاء التأكد من إتصال الإنترنت الخاص بك وإعادة المحاولة',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 25.0,
                  fontFamily: 'ArabicUiDisplay',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 60.0),
            GestureDetector(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 80, maxHeight: 80),
                child: Image.asset('images/retry.png'),
              ),
              onTap: () {
                OrdersLocalData.networkCallPassedChecker = false;
                handleCurrentView();
                getFilteredOrders(
                    6, OrdersLocalData.currentDisplayedOrdersPageFilter);
              },
            )
          ],
        );
      });

  void inflateOrdersList() => setState(() {
        currentDisplayedWidget = Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:
                _presenter.getCurrentItemCount(OrdersLocalData.ordersList, 8),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              OrdersLocalData.networkCallPassedChecker = false;
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: OrdersLocalData.ordersList
                      .map((order) => OrdersCard(
                            requestCustomerName: order.customerName,
                            requestDate: order.createdAt,
                            requestNumber: int.parse(order.number),
                            requestStateColor: _presenter.orderStatusColor(
                                order.status.trim().toLowerCase().toString()),
                            requestState: _presenter.translatedOrderStatus(
                                order.status.trim().toLowerCase().toString()),
                            requestNumberOfProducts: order.numOfProducts,
                            requestProductPrice: order.finalTotal,
                          ))
                      .toList());
            },
          ),
        );
      });

  void getFilteredOrders(int orderLimit, int orderFilter) {
    _getOrders
        .getOrders(
            OrdersLocalData.ordersServiceLink,
            OrdersLocalData.loggedInUserToken,
            OrdersLocalData.loggedInUserAcceptLanguage,
            orderLimit.toString(),
            OrdersLocalData.currentDisplayedOrdersPage.toString(),
            orderFilter.toString())
        .then((ordersResponse) {
      OrdersLocalData.ordersGetResponse = ordersResponse;
      setState(() => _presenter.observeIncomingResponse(
          ordersResponse, onDataAvailable, handleCurrentView));
    });
  }

  void handleCurrentView() {
    _presenter.getCurrentDisplayedView(
        OrdersLocalData.ordersDataReadyChecker,
        inflateOrdersList,
        showLoading,
        showError,
        OrdersLocalData.ordersNetworkCallChecker,
        OrdersLocalData.networkCallPassedChecker);
  }

  void onDataAvailable() {
    OrdersLocalData.ordersList = OrdersLocalData.ordersGetResponse.data;
    OrdersLocalData.totalNewOrdersNumber =
        OrdersLocalData.ordersGetResponse.totalNew;
    OrdersLocalData.totalReadyOrdersNumber =
        OrdersLocalData.ordersGetResponse.totalReady;
    OrdersLocalData.totalShippedOrdersNumber =
        OrdersLocalData.ordersGetResponse.totalShipped;
    handleCurrentView();
  }

  @override
  void dispose() {
    OrdersLocalData.currentDisplayedOrdersPage = 1;
    OrdersLocalData.currentDisplayedOrdersPageFilter = 1;
    OrdersLocalData.ordersDataReadyChecker = false;
    OrdersLocalData.ordersNetworkCallChecker = false;
    super.dispose();
  }
}

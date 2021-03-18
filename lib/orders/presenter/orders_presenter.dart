import 'package:flutter/material.dart';
import 'package:store_go/orders/model/entities/orders_get_response.dart';

class OrdersPresenter {
  var firstPageIndicatorOpacity = 1.0;
  var secondPageIndicatorOpacity = 0.0;
  var thirdPageIndicatorOpacity = 0.0;
  var fourthPageIndicatorOpacity = 0.0;

  var firstPageTextColor = Colors.black;
  var secondPageTextColor = Colors.grey[600];
  var thirdPageTextColor = Colors.grey[600];
  var fourthPageTextColor = Colors.grey[600];

  void inflateRequestTap(int page) {
    switch (page) {
      case 0:
        {
          firstPageIndicatorOpacity = 1.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 0.0;
          fourthPageIndicatorOpacity = 0.0;

          firstPageTextColor = Colors.black;
          secondPageTextColor = Colors.grey[600];
          thirdPageTextColor = Colors.grey[600];
          fourthPageTextColor = Colors.grey[600];
          //return list of new
        }
        break;

      case 1:
        {
          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 1.0;
          thirdPageIndicatorOpacity = 0.0;
          fourthPageIndicatorOpacity = 0.0;

          firstPageTextColor = Colors.grey[600];
          secondPageTextColor = Colors.black;
          thirdPageTextColor = Colors.grey[600];
          fourthPageTextColor = Colors.grey[600];
          //return list of preparing
        }
        break;

      case 2:
        {
          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 1.0;
          fourthPageIndicatorOpacity = 0.0;

          firstPageTextColor = Colors.grey[600];
          secondPageTextColor = Colors.grey[600];
          thirdPageTextColor = Colors.black;
          fourthPageTextColor = Colors.grey[600];
          //return list of shipped
        }
        break;

      case 3:
        {
          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 0.0;
          fourthPageIndicatorOpacity = 1.0;

          firstPageTextColor = Colors.grey[600];
          secondPageTextColor = Colors.grey[600];
          thirdPageTextColor = Colors.grey[600];
          fourthPageTextColor = Colors.black;
          //return List of all
        }
        break;
    }
  }

  Color orderStatusColor(String status) {
    if (status == 'new')
      return Colors.lightBlue;
    else if (status == 'ready' || status == 'accepted')
      return Colors.deepPurpleAccent;
    else if (status == 'shipped')
      return Colors.deepOrangeAccent;
    else
      return Colors.green;
  }

  String translatedOrderStatus(String status) {
    if (status == 'new')
      return 'جديد';
    else if (status == 'ready' || status == 'accepted')
      return 'جارى التجهيز';
    else if (status == 'delivered')
      return 'تم التوصيل';
    else
      return 'تم الشحن';
  }

  void handleScrollDirection(
      ScrollController scrollController, Function bottomHandler) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      bottomHandler();
    }
  }

  void getCurrentDisplayedView(
      bool ordersReadyState,
      Function updateOrdersReadyWidget,
      Function updateWaitingWidget,
      Function updateOrdersGettingFailureWidget,
      bool ordersSuccessCheck,
      bool ordersNetworkFailedCheck) {
    if (ordersReadyState == true &&
        ordersSuccessCheck == true &&
        ordersNetworkFailedCheck == true)
      updateOrdersReadyWidget();
    else if (ordersReadyState == false &&
        ordersSuccessCheck == false &&
        ordersNetworkFailedCheck == false)
      updateOrdersGettingFailureWidget();
    else
      updateWaitingWidget();
  }

  void observeIncomingResponse(OrdersGetResponse incomingResponse,
      Function successAction, Function failureAction) {
    if (incomingResponse == null)
      failureAction();
    else
      successAction();
  }

  int getCurrentItemCount(
      List<SingleOrder> nullableLengthList, int defaultLength) {
    if (nullableLengthList == null)
      return defaultLength;
    else
      return nullableLengthList.length;
  }
}

import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/orders/model/entities/orders_get_response.dart';

class OrdersLocalData {
  static String loggedInUserToken = LoginLocalData.userToken;
  static String loggedInUserAcceptLanguage = LoginLocalData.loginAcceptLanguage;
  static String ordersServiceLink = 'https://dev.storego.io/api/v1/orders';

  static bool ordersDataReadyChecker;
  static bool networkCallPassedChecker;
  static bool ordersNetworkCallChecker;

  static int totalNewOrdersNumber = 0;
  static int totalReadyOrdersNumber = 0;
  static int totalShippedOrdersNumber = 0;
  static int currentDisplayedOrdersPage = 1;
  static int currentDisplayedOrdersPageFilter = 1;

  static OrdersGetResponse ordersGetResponse;
  static List<SingleOrder> ordersList;
}
import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/products/model/entities/product_get_response.dart';
import 'package:store_go/products/model/entities/single_product.dart';

class StoreLocalData {
  String userLoggedInImageLink;
  String productsServiceLink = 'https://dev.storego.io/api/v1/manager-products';
  String userLoggedInToken;
  String userLoggedInName;
  static String currentStateMessage;

  static int optionId;
  static int totalPages;
  static int totalStoreProducts;
  static int totalDisplayedProducts;
  static int totalNotDisplayedProducts;
  static int totalEmptyQuantityProducts;

  static bool validDataState;
  static bool optionClickChecker;
  static bool networkConnectionState;

  static List<SingleProduct> storeProducts;

  static ProductsGetRequestData requestResponse;

  StoreLocalData() {
    userLoggedInImageLink = LoginLocalData.userImageLink;
    userLoggedInToken = LoginLocalData.userToken;
    userLoggedInName = LoginLocalData.userName;
  }
}

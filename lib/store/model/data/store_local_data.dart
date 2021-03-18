import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/products/model/entities/product_get_response.dart';
import 'package:store_go/products/model/entities/single_product.dart';

class StoreLocalData {
  static String userLoggedInImageLink = LoginLocalData.userImageLink;
  static String productsServiceLink = 'https://dev.storego.io/api/v1/manager-products';
  static String userLoggedInToken = LoginLocalData.userToken;
  static String userLoggedInName = LoginLocalData.userName;
  static String currentStateMessage;

  static int totalPages;
  static int totalStoreProducts;
  static int totalDisplayedProducts;
  static int totalNotDisplayedProducts;
  static int totalEmptyQuantityProducts;

  static bool validDataState;
  static bool networkConnectionState;

  static List<SingleProduct> storeProducts;

  static ProductsGetRequestData requestResponse;
}

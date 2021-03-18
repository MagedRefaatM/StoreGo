import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/entities/product_details_get_response.dart';
import 'package:store_go/products/model/entities/single_product.dart';
import 'package:store_go/store/model/data/store_local_data.dart';

class ProductsLocalData {
  static String productsCategoryServiceLink =
      'https://dev.storego.io/api/v1/manager-product-categories';
  static String productDetailsServiceLink =
      'https://dev.storego.io/api/v1/manager-show-product/';
  static String productDeleteServiceLink =
      'https://dev.storego.io/api/v1/delete-product';
  static String productUpdateServiceLink =
      'https://dev.storego.io/api/v1/update-product';
  static String productSaveServiceLink =
      'https://dev.storego.io/api/v1/save-product';
  static String uploadFileServiceLink =
      'https://dev.storego.io/api/v1/upload-file';
  static String deleteFileServiceLink =
      'https://dev.storego.io/api/v1/delete-file';
  static String productsServiceLink =
      'https://dev.storego.io/api/v1/manager-products';

  static String userLoggedInAcceptLanguage = LoginLocalData.loginAcceptLanguage;
  static String deleteResultMessage;
  static String userLoggedInToken = LoginLocalData.userToken;
  static String imageListFileName;
  static String additionMessage;
  static String updateMessage;
  static String imageFileName;

  static int totalEmptyQuantityProducts =
      StoreLocalData.totalEmptyQuantityProducts;
  static int totalNotDisplayedProducts =
      StoreLocalData.totalNotDisplayedProducts;
  static int totalDisplayedProducts = StoreLocalData.totalDisplayedProducts;
  static int currentProductPageFilter = 1;
  static int currentImageListIndex;
  static int currentProductPage = 1;
  static int additionalImageId;
  static int otherImagesIndex;
  static int totalProducts;
  static int categoryId;
  static int productId;

  static bool productUpdated;
  static bool productImageStatus;
  static bool productUpdateState;

  static SingleProduct singleProduct;
  static OtherImage singleOtherImage;
  static Data productDetails;

  static List<SingleProduct> products = StoreLocalData.storeProducts;
  static List<OtherImage> productOtherImagesList;
  static List<SingleCategory> categoriesList;
  static List<StockTransfer> stockTransfer;

  static void updateModel(Data oldModel, Data newModel) {
    oldModel.stockTransfer = newModel.stockTransfer;
    oldModel.quantity = newModel.quantity;
    oldModel.id = newModel.id;
    oldModel.description = newModel.description;
    oldModel.name = newModel.name;
    oldModel.status = newModel.status;
    oldModel.mainImageName = newModel.mainImageName;
    oldModel.image = newModel.image;
    oldModel.price = newModel.price;
    oldModel.categoryId = newModel.categoryId;
    oldModel.createdAt = newModel.createdAt;
    oldModel.slugKey = newModel.slugKey;
    oldModel.imageStatus = newModel.imageStatus;
    oldModel.otherImagesNames.replaceRange(
        0, oldModel.otherImagesNames.length, newModel.otherImagesNames);
    oldModel.otherImages
        .replaceRange(0, oldModel.otherImages.length, newModel.otherImages);
  }
}

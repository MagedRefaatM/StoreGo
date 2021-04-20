import 'package:store_go/settings/model/entities/manager_category_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class ManagerCategoryLocalData {
  static List<Datum> managerCategories;

  static bool networkConnectionState;
  static bool updateOccurred;
  static bool updateState;

  String saveManagerCategoriesLink =
      'https://dev.storego.io/api/v1/save-category';
  String loggedInAcceptLanguage;
  String loggedInUserToken;
  String toastMessage;

  ManagerCategoryLocalData() {
    loggedInAcceptLanguage = LoginLocalData.loginAcceptLanguage;
    loggedInUserToken = LoginLocalData.userToken;
  }
}

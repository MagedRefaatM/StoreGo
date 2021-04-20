import 'package:store_go/settings/model/entities/manager_category_response.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetManagerCategories {
  Future<ManagerProductCategory> getUpdateResponse(
      String managerCategoryLink,
      String token,
      String acceptLanguage,
      String categoriesLimit,
      String pageNumber) async {
    ManagerProductCategory managerCategoryResponse;

    String authorizationToken = 'Bearer $token';

    var productsParameters = {'limit': categoriesLimit, 'page': pageNumber};

    String queryString = Uri(queryParameters: productsParameters).query;
    var requestUrl = managerCategoryLink + '?' + queryString;

    try {
      final response = await get(
        Uri.parse(requestUrl),
        headers: <String, String>{
          'authorization': authorizationToken,
          'accept_language': acceptLanguage
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        SettingsLocalData.networkConnectionState = true;
        managerCategoryResponse = managerProductCategoryFromJson(response.body);
        return managerCategoryResponse;
      } else {
        SettingsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      SettingsLocalData.networkConnectionState = false;
    }
  }
}

import 'package:store_go/store_departments/model/entities/update_store_categories.dart';
import 'package:store_go/settings/model/entities/manager_category_response.dart';
import 'package:store_go/store_departments/model/data/category_local_data.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class UpdateManagerCategory {
  Future<ManagerUpdateResponse> getUpdateResponse(String saveCategoryLink,
      String token, List<Datum> managerCategoriesList) async {
    ManagerUpdateResponse updateStoreResponse;

    String authorizationToken = 'Bearer $token';

    try {
      final response = await post(
        Uri.parse(saveCategoryLink),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': authorizationToken,
        },
        body: jsonEncode(<String, dynamic>{
          'categories': managerCategoriesList,
        }),
      ).timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        ManagerCategoryLocalData.networkConnectionState = true;
        ManagerCategoryLocalData.updateState = true;
        updateStoreResponse = managerUpdateResponseFromJson(response.body);
        return updateStoreResponse;
      } else {
        ManagerCategoryLocalData.networkConnectionState = true;
        ManagerCategoryLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      ManagerCategoryLocalData.networkConnectionState = false;
      ManagerCategoryLocalData.updateState = false;
    }
  }
}

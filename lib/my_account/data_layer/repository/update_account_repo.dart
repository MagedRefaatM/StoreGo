import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';
import 'package:store_go/my_account/data_layer/data_provider/update_account_api.dart';

class UpdateAccountRepository {
  final UpdateAccountApiClient _accountApiClient = UpdateAccountApiClient();

  Future<dynamic> updateAccountInfo(
      String updateAccountLink,
      String applicationId,
      String applicationSecret,
      String type,
      String ibanNumber,
      String beneficiaryName,
      String licenseType,
      String expireDate,
      String englishName,
      String arabicName,
      String address,
      int mobileNumber,
      int bankId,
      List<Document> businessDocuments,
      List<Document> bankDocuments) async {
    final _updateResponse = await _accountApiClient.postUpdateRequest(
        updateAccountLink,
        applicationId,
        applicationSecret,
        type,
        ibanNumber,
        beneficiaryName,
        licenseType,
        expireDate,
        englishName,
        arabicName,
        address,
        mobileNumber,
        bankId,
        businessDocuments,
        bankDocuments);
    if (_updateResponse == null) return null;
    if (_updateResponse == 0) return 0;

    return _updateResponse.data;
  }
}

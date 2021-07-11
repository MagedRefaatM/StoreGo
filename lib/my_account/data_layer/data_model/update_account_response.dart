import 'dart:convert';

UpdateAccountResponse updateAccountResponseFromJson(String str) =>
    UpdateAccountResponse.fromJson(json.decode(str));

String updateAccountResponseToJson(UpdateAccountResponse data) =>
    json.encode(data.toJson());

class UpdateAccountResponse {
  UpdateAccountResponse({
    this.data,
  });

  Data data;

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) =>
      UpdateAccountResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.isCompleteProfile,
    this.balance,
    this.licenseType,
    this.businessNameEn,
    this.businessNameAr,
    this.sector,
    this.website,
    this.description,
    this.businessAddress,
    this.businessMobile,
    this.vatRegistrationNumber,
    this.commercialRegistryExpiryDate,
    this.verified,
    this.bankId,
    this.ibanNumber,
    this.beneficiaryName,
    this.logo,
    this.disableBusinessDocuments,
    this.disableBankDocuments,
    this.businessDocuments,
    this.bankDocuments,
  });

  int id;
  bool isCompleteProfile;
  double balance;
  String licenseType;
  String businessNameEn;
  dynamic businessNameAr;
  String sector;
  dynamic website;
  dynamic description;
  String businessAddress;
  String businessMobile;
  dynamic vatRegistrationNumber;
  dynamic commercialRegistryExpiryDate;
  int verified;
  String bankId;
  String ibanNumber;
  String beneficiaryName;
  String logo;
  int disableBusinessDocuments;
  int disableBankDocuments;
  List<dynamic> businessDocuments;
  List<dynamic> bankDocuments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        isCompleteProfile: json["is_complete_profile"],
        balance: json["balance"].toDouble(),
        licenseType: json["license_type"],
        businessNameEn: json["business_name_en"],
        businessNameAr: json["business_name_ar"],
        sector: json["sector"],
        website: json["website"],
        description: json["description"],
        businessAddress: json["business_address"],
        businessMobile: json["business_mobile"],
        vatRegistrationNumber: json["vat_registration_number"],
        commercialRegistryExpiryDate: json["commercial_registry_expiry_date"],
        verified: json["verified"],
        bankId: json["bank_id"],
        ibanNumber: json["iban_number"],
        beneficiaryName: json["beneficiary_name"],
        logo: json["logo"],
        disableBusinessDocuments: json["disable_business_documents"],
        disableBankDocuments: json["disable_bank_documents"],
        businessDocuments:
            List<dynamic>.from(json["business_documents"].map((x) => x)),
        bankDocuments: List<dynamic>.from(json["bank_documents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_complete_profile": isCompleteProfile,
        "balance": balance,
        "license_type": licenseType,
        "business_name_en": businessNameEn,
        "business_name_ar": businessNameAr,
        "sector": sector,
        "website": website,
        "description": description,
        "business_address": businessAddress,
        "business_mobile": businessMobile,
        "vat_registration_number": vatRegistrationNumber,
        "commercial_registry_expiry_date": commercialRegistryExpiryDate,
        "verified": verified,
        "bank_id": bankId,
        "iban_number": ibanNumber,
        "beneficiary_name": beneficiaryName,
        "logo": logo,
        "disable_business_documents": disableBusinessDocuments,
        "disable_bank_documents": disableBankDocuments,
        "business_documents":
            List<dynamic>.from(businessDocuments.map((x) => x)),
        "bank_documents": List<dynamic>.from(bankDocuments.map((x) => x)),
      };
}

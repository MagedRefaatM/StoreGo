import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class UpdateSelectedBank extends AccountEvent {
  final String currentSelectedBank;
  UpdateSelectedBank(this.currentSelectedBank);

  @override
  List<Object> get props => [];
}

class UpdateSelectedLicense extends AccountEvent {
  final String currentSelectedLicense;
  UpdateSelectedLicense(this.currentSelectedLicense);

  @override
  List<Object> get props => [];
}

class CheckSelectedDocumentType extends AccountEvent {
  final String selectedFileType;
  CheckSelectedDocumentType(this.selectedFileType);

  @override
  List<Object> get props => [this.selectedFileType];
}

class CheckDocumentsLength extends AccountEvent {
  final int documentsListLength;
  CheckDocumentsLength(this.documentsListLength);

  @override
  List<Object> get props => [this.documentsListLength];
}

class UploadBankDocuments extends AccountEvent {
  final File selectedFile;
  final List<Document> workingOnList;
  UploadBankDocuments(this.selectedFile, this.workingOnList);

  @override
  List<Object> get props => [this.selectedFile, this.workingOnList];
}

class UploadCommercialDocument extends AccountEvent {
  final File selectedFile;
  final List<Document> workingOnList;
  UploadCommercialDocument(this.selectedFile, this.workingOnList);

  @override
  List<Object> get props => [this.selectedFile, this.workingOnList];
}

class DeleteDocument extends AccountEvent {
  final Document document;
  DeleteDocument(this.document);

  @override
  List<Object> get props => [this.document];
}
class UpdateAccountInfo extends AccountEvent {
  final String updateAccountLink;
  final String applicationId;
  final String applicationSecret;
  final String type;
  final String ibanNumber;
  final String beneficiaryName;
  final String licenseType;
  final String expireDate;
  final String englishName;
  final String arabicName;
  final String address;
  final int mobileNumber;
  final int bankId;
  final List<Document> businessDocuments;
  final List<Document> bankDocuments;

  UpdateAccountInfo(
      this.updateAccountLink,
      this.applicationId,
      this.applicationSecret,
      this.type,
      this.ibanNumber,
      this.beneficiaryName,
      this.licenseType,
      this.expireDate,
      this.englishName,
      this.arabicName,
      this.address,
      this.mobileNumber,
      this.bankId,
      this.businessDocuments,
      this.bankDocuments);

  @override
  List<Object> get props => [
        this.updateAccountLink,
        this.applicationId,
        this.applicationSecret,
        this.type,
        this.ibanNumber,
        this.beneficiaryName,
        this.licenseType,
        this.expireDate,
        this.englishName,
        this.arabicName,
        this.address,
        this.mobileNumber,
        this.bankId,
        this.businessDocuments,
        this.bankDocuments
      ];
}

import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';
import 'package:store_go/my_account/data_layer/repository/update_account_repo.dart';
import 'package:store_go/my_account/data_layer/repository/upload_file_repo.dart';
import 'package:store_go/my_account/business_logic_layer/account_event.dart';
import 'package:store_go/my_account/business_logic_layer/account_state.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _accountRepository = UpdateAccountRepository();
  final _fileRepository = UploadFileRepository();

  AccountBloc() : super(InitialState());

  @override
  Stream<AccountState> mapEventToState(final AccountEvent event) async* {
    if (event is UpdateSelectedLicense)
      yield SelectedLicenseUpdated(event.currentSelectedLicense);
    else if (event is UpdateSelectedBank)
      yield SelectedBankUpdated(event.currentSelectedBank);
    else if (event is CheckDocumentsLength)
      yield checkDocumentsListLength(event.documentsListLength);
    else if (event is CheckSelectedDocumentType)
      yield checkUploadedFileType(event.selectedFileType);
    else if (event is UploadCommercialDocument) {
      yield Loading();
      yield onUploadDocumentClicked(event.selectedFile, event.workingOnList);
    } else if (event is UploadBankDocuments) {
      yield Loading();
      yield onUploadDocumentClicked(event.selectedFile, event.workingOnList);
    } else if (event is UpdateAccountInfo)
      yield updateAccount(
          event.updateAccountLink,
          event.applicationId,
          event.applicationSecret,
          event.type,
          event.ibanNumber,
          event.beneficiaryName,
          event.licenseType,
          event.expireDate,
          event.englishName,
          event.arabicName,
          event.address,
          event.mobileNumber,
          event.bankId,
          event.businessDocuments,
          event.bankDocuments);
  }

  AccountState checkDocumentsListLength(int currentLength) {
    if (currentLength != 5)
      return Upload();
    else
      return MaximumDocumentsReached('تم الوصول للحد الأقصى للوثائق المطلوبة');
  }

  AccountState onUploadDocumentClicked(
      File selectedFile, List<Document> workingOnList) {
    final _compressedFile = compressFile(selectedFile, selectedFile.path);
    return uploadDocument(_compressedFile as File, workingOnList);
  }

  AccountState checkUploadedFileType(String selectedFileType) {
    if (selectedFileType == 'application')
      return ImageTypedFile();
    else
      return PDFTypedFile();
  }

  Future<File> compressFile(File file, String targetPath) async =>
      await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 88,
        rotate: 180,
      ).then((compressedFile) {
        return compressedFile;
      });

  AccountState uploadDocument(
      File compressedFile, List<Document> workingOnList) {
    final _uploadResponse = _fileRepository.getLoginResponse(compressedFile);

    if (_uploadResponse != null)
      return DocumentLoadedSuccess(_uploadResponse.toString(), workingOnList);
    else if (_uploadResponse == null)
      return DocumentLoadedFailure('حدث خطأ ما، برجاء إعادة المحاولة');
    else
      return ConnectionTimeout('برجاء التحقق من إتصال الإنترنت على هاتفك');
  }

  AccountState updateAccount(
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
      List<Document> bankDocuments) {
    final _updateResponse = _accountRepository.updateAccountInfo(
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

    if (_updateResponse != null)
      return UpdateAccountSuccess('تم الحفظ');
    else if (_updateResponse == null)
      return UpdateAccountFailure('حدث خطأ ما، برجاء إعادة المحاولة');
    else
      return ConnectionTimeout('برجاء التحقق من إتصال الإنترنت على هاتفك');
  }
}

import 'package:equatable/equatable.dart';
import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends AccountState {
  @override
  List<Object> get props => [];
}

class MaximumDocumentsReached extends AccountState {
  final String maxReachedMessage;
  MaximumDocumentsReached(this.maxReachedMessage);

  @override
  List<Object> get props => [this.maxReachedMessage];
}

class Upload extends AccountState {
  @override
  List<Object> get props => [];
}

class Loading extends AccountState {
  @override
  List<Object> get props => [];
}

class DocumentLoadedSuccess extends AccountState {
  final String networkPath;
  final List<Document> workingOnList;
  DocumentLoadedSuccess(this.networkPath, this.workingOnList);

  @override
  List<Object> get props => [this.networkPath, this.workingOnList];
}

class DocumentLoadedFailure extends AccountState {
  final String failureMessage;
  DocumentLoadedFailure(this.failureMessage);

  @override
  List<Object> get props => [this.failureMessage];
}

class DocumentDeleted extends AccountState {
  final Document deletedDocument;
  DocumentDeleted(this.deletedDocument);

  @override
  List<Object> get props => [this.deletedDocument];
}

class ImageTypedFile extends AccountState {
  @override
  List<Object> get props => [];
}

class PDFTypedFile extends AccountState {
  @override
  List<Object> get props => [];
}

class UpdateAccountSuccess extends AccountState {
  final String confirmationMessage;
  UpdateAccountSuccess(this.confirmationMessage);

  @override
  List<Object> get props => [this.confirmationMessage];
}

class UpdateAccountFailure extends AccountState {
  final String updateFailureMessage;
  UpdateAccountFailure(this.updateFailureMessage);

  @override
  List<Object> get props => [this.updateFailureMessage];
}

class ConnectionTimeout extends AccountState {
  final String timeoutMessage;
  ConnectionTimeout(this.timeoutMessage);

  @override
  List<Object> get props => [this.timeoutMessage];
}

class SelectedBankUpdated extends AccountState {
  final String newSelectedBank;
  SelectedBankUpdated(this.newSelectedBank);

  @override
  List<Object> get props => [newSelectedBank];
}

class SelectedLicenseUpdated extends AccountState {
  final String newLicenseType;
  SelectedLicenseUpdated(this.newLicenseType);

  @override
  List<Object> get props => [newLicenseType];
}

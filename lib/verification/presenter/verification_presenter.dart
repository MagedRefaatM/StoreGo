class VerificationPresenter {
  void logoutServiceHandler(bool networkConnectionState,
      Function successFunction, Function failureFunction) {
    if (networkConnectionState == true)
      successFunction();
    else if (networkConnectionState == false) failureFunction();
  }

  void accountInfoResponseHandler(
      bool networkConnectionState,
      bool dataConnectionState,
      Function successConnectionFunction,
      Function failureConnectionFunction,
      Function dataFailureFunction) {
    if (networkConnectionState == true && dataConnectionState == true)
      successConnectionFunction();
    else if (networkConnectionState == true && dataConnectionState == false)
      dataFailureFunction();
    else
      failureConnectionFunction();
  }
}

class VerificationPresenter{

  void logoutServiceHandler(bool networkConnectionState, Function successFunction, Function failureFunction) {
    if(networkConnectionState == true)
      successFunction();
    else if (networkConnectionState == false)
      failureFunction();
  }
}
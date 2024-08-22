class ApiConstants {
  static const String baseUrl =
      'https://xbp.uat.volant-ubicomms.com/api/v1';

  static const String registerAPI = '/remitter/create';
  // static const String registerAPI = '/register';
  static const String loginAPI = '/login';
  static const String loginPINAPI = '/loginPin';
  static const String resetPasswordAPI = '/resetpassword';
  static const String forgotPasswordAPI = '/forgotpassword';
  static const String verifyCodeAPI = '/register/verifycode';
  static const String newPasswordAPI = '/forgotpassword/newpassword';
  static const String forgotVerifyCodeAPI = '/forgotpassword/verifycode';

  static const String beneficiaryCreateAPI = '/benificiary/create';
  static const String beneficiaryDeleteAPI = '/benificiary/delete';
  static const String beneficiaryListAPI = '/benificiary/list';
  static const String getPartnerSourceCountryListAPI = '/getPartnersourcecountrylist';
  static const String getPartnerDestinationListAPI = '/getPartnerdestinationlist';
  static const String getPartnerTransactionSettingsAPI = '/getPartnerTransactionSettings';
  //static const String getPartnerRatesAPI = '/getPartnerRates';
  static const String getPartnerRatesAPI = '/getPartnerCharges';
  static const String getPayoutsBanksAPI = '/payoutsBanks/';
  static const String transactionCreateAPI = '/transaction/create';
  static const String benificiaryUpdateAPI = '/benificiary/update';
  static const String getBenificiaryByIdAPI = '/benificiary/';

  static const String userDetailUpdateAPI = '/remitter/verify';
  static const String sendVerificationEmail = '/remitter/sendVerificationEmail';
  static const String sendEmailToSupport = '/support/sendEmailToSupport';
  static const String listTransactionsAPI = '/ListTransactions';
  static const String listScheduleTransactionsAPI = '/transaction/listScheduleTransactions';
  static const String createScheduleTransactionsAPI = '/transaction/createScheduleTransactions';
  static const String updateScheduleTransactionsAPI = '/transaction/updateScheduleTransactions';
  static const String deleteScheduleTransactionsAPI = '/transaction/deleteScheduleTransactions';
  static const String setRateAlertAPI = '/remitter/setRateAlert';
  static const String updateRateAlertAPI = '/remitter/updateRateAlert';
  static const String deleteRateAlertAPI = '/remitter/deleteRateAlert';
  static const String listRateAlertsAPI = '/remitter/listRateAlert';
  static const String transactionDetails = '/transaction/';
  static const String getSignUpSourceCountryList = '/getSignUpSourceCountryList';
  static const String getProfileDetails = '/GetRemitterList';
  static const String getMobileNetworkOperators = '/transaction/getMobileNetworkOperators';
  static const String getUserWallet = '/remitter/wallet';
  static const String storeCard = '/storeCard';
  static const String getCard = '/getCard';
  static const String getCardAndWallet = '/listCardAndWallet';
  static const String topUpWallet = '/remitter/wallet/load';
  static const String getUITransactionSetting='/UISettings/getTransactionUISettings';
  static const String getDeliveryBanks='/transaction/getDeliveryBanks';
  static const String getDeliveryBranch='/transaction/getDeliveryBranches';
  static const String getSignUpStatus='/getSignupStatus';
  static const String getForgotPasswordStatus='/getForgotPasswordStatus';
  static const String setRemitterPin='/remitter/pin';
  static const String getSortedRecipient='/sortData';
  static const String getCollectionPointStates='/transaction/getCollectionPointStates';
  static const String getCollectionPoints='/transaction/getCollectionPoints';
  static const String getJwtAccountCheck='/tp/jwt-account-check';
  static const String getJwtTokenSale='/tp/jwt-token-sale';
  static const String remitterWalletCreate='/remitter/wallet/create';
  static const String deleteSavedCard='/deleteCard';
  static const String updateUserProfile='/remitter/User/updateProfile';
  static const String getRemitterUISettings='/UISettings/getRemitterUISettings';
  static const String getRemitterProfileImage='/remitter/profileImage';
}

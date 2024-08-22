import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/dashboard/repository/dashboard_repository.dart';
import 'package:nationremit/model/Mobile_operator_model.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/create_schedule_transaction.dart';
import 'package:nationremit/model/create_transaction_model.dart';
import 'package:nationremit/model/get_card_model.dart';
import 'package:nationremit/model/get_collection_point_states.dart';
import 'package:nationremit/model/get_delivery_banks_model.dart';
import 'package:nationremit/model/get_profile_image_model.dart';
import 'package:nationremit/model/get_wallet_model.dart';
import 'package:nationremit/model/partner_rates_model.dart';
import 'package:nationremit/model/partner_source_country_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/profile_details_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/model/store_card_model.dart';
import 'package:nationremit/model/support_email_model.dart';
import 'package:nationremit/model/transaction_details_model.dart';
import 'package:nationremit/model/transaction_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Ui_transaction_setting_model.dart';
import '../model/beneficiary_create_model.dart';
import '../model/get_beneficiary_by_id_model.dart';
import '../model/get_collection_points.dart';
import '../model/get_delivery_bank_branch.dart';
import '../model/is_success_model.dart';
import '../model/jwt_account_check.dart';
import '../model/jwt_token_sale.dart';
import '../model/partner_destination_country_model.dart';
import '../model/set_remitter_pin.dart';
import '../model/wallet_and_card_model.dart';

class DashBoardProvider with ChangeNotifier {
  final _dashboardRepository = DashboardRepository();
  final sendAmountController = TextEditingController();
  final receiveAmountController = TextEditingController();

  var _isLoading = false;
  String _selectCountryCode = 'ARE';
  PartnerCountryModel? _countryModel;
  PartnerDestinationCountryModel? _countryDestinationList;
  PartnerTransactionSettingsModel? _partnerTransactionSettingsModel;
  UiTransactionSettingModel? _uiTransactionSettingModel;
  GetDeliveryBanksModel? _getDeliveryBanksModel;
  GetDeliveryBankBranch? _getDeliveryBankBranch;
  GetCollectionPointStates? _getCollectionPointStates;
  BeneficiaryListModel? _beneficiaryListModel;
  BeneficiaryCreateModel? _beneficiaryCreateModel;
  PartnerRatesModel? _partnerRatesModel;
  PayoutBankModel? _payoutBankModel;
  MobileOperatorModel? _mobileOperatorModel;
  GetWalletModel? _getWalletModel;
  GetCardModel? _getCardModel;
  WalletAndCardModel? _walletAndCardModel;
  String? _sourceCountryName;
  int _serviceLevel = 1;

  TransactionListModel? _transactionList;
  CreateScheduleTransaction? _createScheduleTransaction;
  TransactionDetailsModel? _transactionDetailsModel;

  JwtAccountCheck? _jwtAccountCheck;
  JwtTokenSale? _jwtAccountTokenSale;

  String _sourceCountry = 'GBR';
  String _sourceCurrency = 'GBP';
  String _destinationCountry = 'AUS';
  String _destinationCurrency = 'AUD';

  // String _selectPaymentMode = 'Wallet';
  String _selectPaymentMode = 'Cash Collection';
  int _selectPaymentCode = 1;
  String _selectPaymentType = '';
  String _whichTypeCountryMode = '';
  String _userSelectedPaymentType = '';

  //For Payment Convert
  String? _platformFees = '0.0';
  String? _totalFees = '0.0';
  String? _convertRate = '0.0';
  String? _rate = '0.0';
  String? _sourceAmount = '0.0';
  double? mReceiveAmount = 0.0;
  String? _shouldArrive = '';

  ProfileDetailsModel? _profileDetailsModel;

  ProfileDetailsModel? get profileDetailsModel => _profileDetailsModel;

  int get serviceLevel => _serviceLevel;

  PayoutBankModel? get payoutBankModel => _payoutBankModel;

  MobileOperatorModel? get mobileOperatorModel => _mobileOperatorModel;

  GetWalletModel? get getWalletModel => _getWalletModel;

  GetCardModel? get getCardModel => _getCardModel;
  WalletAndCardModel? get getWalletAndCardModel => _walletAndCardModel;

  int get selectPaymentCode => _selectPaymentCode;

  TransactionDetailsModel? get transactionDetailsModel =>
      _transactionDetailsModel;

  String get sourceCurrency => _sourceCurrency;

  set transactionDetailsModel(TransactionDetailsModel? value) {
    _transactionDetailsModel = value;
  }

  set sourceCurrency(String value) {
    _sourceCurrency = value;
  }

  set selectPaymentCode(int value) {
    _selectPaymentCode = value;
  }

  TransactionListModel? get transactionList => _transactionList;

  CreateScheduleTransaction? get createScheduleTransaction => _createScheduleTransaction;

  JwtAccountCheck? get jwtAccountCheck => _jwtAccountCheck;
  JwtTokenSale? get jwtAccountTokenSale => _jwtAccountTokenSale;

  String? get sourceCountryNameTitle => _sourceCountryName;

  set sourceCountryName(String value) {
    _sourceCountryName = value;
  }

  String? get platformFees => _platformFees;

  PartnerRatesModel? get partnerRatesModel => _partnerRatesModel;

  BeneficiaryListModel? get beneficiaryListModel => _beneficiaryListModel;

  BeneficiaryCreateModel? get beneficiaryCreateModel => _beneficiaryCreateModel;

  String get whichTypeCountryMode => _whichTypeCountryMode;

  set whichTypeCountryMode(String value) {
    _whichTypeCountryMode = value;
    notifyListeners();
  }

  String get sourceCountry => _sourceCountry;

  set sourceCountry(String value) {
    _sourceCountry = value;
    notifyListeners();
  }

  String get destinationCountry => _destinationCountry;

  set destinationCountry(String value) {
    _destinationCountry = value;
    notifyListeners();
  }

  String get selectPaymentMode => _selectPaymentMode;

  set selectPaymentMode(String value) {
    _selectPaymentMode = value;
    // _selectPaymentMode = 'bank-transfer';
    //  print('========== $value');
    notifyListeners();
  }

  String get selectPaymentType => _selectPaymentType;

  set selectPaymentType(String value) {
    _selectPaymentType = value;
    notifyListeners();
  }

  get isLoading => _isLoading;

  String get selectCountryCode => _selectCountryCode;

  PartnerCountryModel? get countryModel => _countryModel;

  PartnerDestinationCountryModel? get countryDestinationList =>
      _countryDestinationList;

  PartnerTransactionSettingsModel? get partnerTransactionSettingsModel =>
      _partnerTransactionSettingsModel;

  /* UiTransactionSettingModel? get uiTransactionSettingModel =>
      _uiTransactionSettingModel;*/

  GetDeliveryBanksModel? get getDeliveryBanksModel => _getDeliveryBanksModel;

  GetDeliveryBankBranch? get getDeliveryBankBranch => _getDeliveryBankBranch;

  GetCollectionPointStates? get getCollectionPointState => _getCollectionPointStates;

  void selectCountryCodeByUser(String countryCode) {
    _selectCountryCode = countryCode;
    notifyListeners();
  }

  void setLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> getCountryList({bool? isComingFromSignUP = false}) async {
    setLoadingStatus(true);
    try {
      _countryModel = await _dashboardRepository.partnerSourceCountryAPI(
          isComingFromSignUP: isComingFromSignUP);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getCountryDestinationList(bool isFromReviewPage) async {
    setLoadingStatus(true);
    try {
      _countryDestinationList =
          await _dashboardRepository.partnerDestinationListAPI();
      if (!isFromReviewPage) {
        _destinationCountry = _countryDestinationList!
            .response!.destinationCurrency![0].countryCode!;
        _selectCountryCode = _countryDestinationList!
            .response!.destinationCurrency![0].countryCode!;
        _destinationCurrency = _countryDestinationList!
            .response!.destinationCurrency![0].currencySupported![0].currency!;
      }
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<PartnerTransactionSettingsModel> getPartnerTransactionSettings({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.partnerTransactionSettingsAPI(data: data);
      _partnerTransactionSettingsModel =res;

      _serviceLevel = _partnerTransactionSettingsModel
              ?.response?.serviceLevelDeliverySpeedCodes![0].code ??
          1;

      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<BeneficiaryCreateModel> beneficiaryCreate(
      {required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      return await _dashboardRepository.beneficiaryCreateAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> beneficiaryDelete({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      await _dashboardRepository.beneficiaryDeleteAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<BeneficiaryCreateModel> beneficiaryUpdate({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
     final res = await _dashboardRepository.beneficiaryUpdateAPI(data: data);
     return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<BeneficiaryCreateModel> beneficiaryMarkFavorite({required Map<String, dynamic> data}) async {
    setLoadingStatus(false);
    try {
     final res = await _dashboardRepository.beneficiaryUpdateAPI(data: data);
     return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<BeneficiaryListModel> getBenificiaryByIdAPI({required String id}) async {
    setLoadingStatus(true);
    try {
     final res = await _dashboardRepository.getBenificiaryByIdAPI(id);
     return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<PartnerRatesModel> getPartnerRates({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.partnerRates(data: data);
      _partnerRatesModel = res;
      if(res.success){
        _totalFees = _partnerRatesModel?.response?.totalFees;
        _convertRate = _partnerRatesModel?.response?.conversionRate;
        _rate = _partnerRatesModel?.response?.amountToConvert;
        _sourceAmount = _partnerRatesModel?.response?.sourceAmount;
        _shouldArrive = _partnerRatesModel?.response?.shouldArrive;
        _platformFees = _partnerRatesModel?.response?.platformFee;
        if (data['action'] != 'source') {
          sendAmountController.text =
              double.parse(_sourceAmount!).toStringAsFixed(2);
          receiveAmountController.text = double.parse(data['amount'].toString()).toStringAsFixed(2);
        } else {
          sendAmountController.text = double.parse(data['amount'].toString()).toStringAsFixed(2);
          mReceiveAmount =
              (double.parse(_sourceAmount!)- double.parse(_totalFees!)) * double.parse(_convertRate!);
          receiveAmountController.text = mReceiveAmount!.toStringAsFixed(2);
        }
      }

      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getBeneficiaryList({required int remitterId}) async {
    setLoadingStatus(true);
    try {
      _beneficiaryListModel =
          await _dashboardRepository.beneficiaryListAPI(remitterId: remitterId);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getPayoutsBanksList({required String countryCode}) async {
    try {
      setLoadingStatus(true);
      _payoutBankModel = await _dashboardRepository.payoutsBanksAPI(
        countryCode: countryCode,
      );
      setLoadingStatus(false);
    } catch (e) {
      _payoutBankModel = null;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<CreateTransactionModel> transactionCreateAPI(
      {required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.transactionCreateAPI(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> transactionListAPI({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      _transactionList =
          await _dashboardRepository.transactionListAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> transactionDetailsAPI({required String transactionId}) async {
    setLoadingStatus(true);
    try {
      _transactionDetailsModel = await _dashboardRepository
          .transactionDetailsAPI(transactionId: transactionId);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<RegisterModel> userDetailUpdateAPI({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.userDetailUpdateAPI(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<RegisterModel> editedProfileUpdate({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.editedProfileUpdate(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getProfileDetails() async {
    setLoadingStatus(true);
    try {
      _profileDetailsModel = await _dashboardRepository.getProfileDetails();
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getMobileNetworkOperatorsAPI({
    required String mDestinationCountry,
  }) async {
    setLoadingStatus(true);
    try {
      _mobileOperatorModel =
          await _dashboardRepository.getMobileNetworkOperatorsAPI(
              destinationCountry: mDestinationCountry);
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getUserWallet() async {
    setLoadingStatus(true);
    try {
      _getWalletModel = await _dashboardRepository.getUserWallet();
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> createRemitterWallet() async {
    setLoadingStatus(true);
    try {
      _getWalletModel = await _dashboardRepository.createRemitterWallet();
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getStoredCards() async {
    setLoadingStatus(true);
    try {
      _getCardModel = await _dashboardRepository.getStoredCards();
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<void> getWalletAndSavedCards() async {
    setLoadingStatus(true);
    try {
      _walletAndCardModel = await _dashboardRepository.getWalletAndSavedCards();
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<StoreCardModel> storeCard({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.storeCard(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<StoreCardModel> loadWallet({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.loadWallet(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getUITransactionSetting({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      _uiTransactionSettingModel =
          await _dashboardRepository.getUITransactionSetting(data: data);
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getDeliveryBanks({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      _getDeliveryBanksModel =
          await _dashboardRepository.getDeliveryBanks(data: data);
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getDeliveryBranch({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      _getDeliveryBankBranch =
          await _dashboardRepository.getDeliveryBranch(data: data);
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<SetRemitterPin> setRemitterPin({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.setRemitterPin(data: data);
      _saveNameIntoLocalPref(res.userDetails?.firstName);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<BeneficiaryListModel> getSortedRecipient({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.getSortedRecipient(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

 Future<GetCollectionPointStates> getCollectionPointStates({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.getCollectionPointStates(data: data);
      _getCollectionPointStates=res;
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

 Future<GetCollectionPoints> getCollectionPoints({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.getCollectionPoints(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<JwtAccountCheck> getJwtAccountCheck({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.getJwtAccountCheck(data: data);
      _jwtAccountCheck=res;
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<JwtTokenSale> getJwtTokenSale({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.getJwtTokenSale(data: data);
      _jwtAccountTokenSale=res;
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<CreateScheduleTransaction> createScheduleTransactionsAPI({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =
      await _dashboardRepository.createScheduleTransactionsAPI(data: data);
      _createScheduleTransaction=res;
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<IsSuccessModel> savedCardDeleteAPI({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.savedCardDeleteAPI(data: data);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<IsSuccessModel> sendVerificationEmail({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.sendVerificationEmail(data: data);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
  Future<SupportEmailModel> sendEmailToSupport({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.sendEmailToSupport(data: data);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<IsSuccessModel> saveProfileImage({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.saveProfileImage(data: data);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<GetProfileImageModel> getProfileImage({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res =await _dashboardRepository.getProfileImage(data: data);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  String getCountryFlag(String countryCode) {
    String imagePath = '';
    if (countryCode == 'GBP') {
      imagePath = AssetsConstant.gbpFlagIcon;
    } else if (countryCode == 'RWF') {
      imagePath = AssetsConstant.rwfFlagIcon;
    } else if (countryCode == 'TZS') {
      imagePath = AssetsConstant.tzsFlagIcon;
    } else if (countryCode == 'UGX') {
      imagePath = AssetsConstant.ugxFlagIcon;
    } else if (countryCode == 'ZMW') {
      imagePath = AssetsConstant.zmwFlagIcon;
    } else if (countryCode == 'ZWL') {
      imagePath = AssetsConstant.zwlFlagIcon;
    } else if (countryCode == 'ZK') {
      imagePath = AssetsConstant.zmwFlagIcon;
    } else if (countryCode == 'RWA') {
      imagePath = AssetsConstant.zmwFlagIcon;
    } else if (countryCode == 'ARE') {
      imagePath = AssetsConstant.ugxFlagIcon;
    } else if (countryCode == 'SOM') {
      imagePath = AssetsConstant.tzsFlagIcon;
    } else if (countryCode == 'UGA') {
      imagePath = AssetsConstant.rwfFlagIcon;
    } else if (countryCode == 'GBR') {
      imagePath = AssetsConstant.gbpFlagIcon;
    //  imagePath = CountryISOMapping().getCountryISOFlag(CountryISOMapping().getCountryISO2(countryCode));
    } else if (countryCode == 'KEN') {
      imagePath = AssetsConstant.zmwFlagIcon;
    }
    return imagePath;
  }

  //For Payment Convert
  String? get totalFees => _totalFees;

  String? get convertRate => _convertRate;

  String? get rate => _rate;

  String? get receiveAmount => _sourceAmount;

  String? get shouldArrive => _shouldArrive;

  String get destinationCurrency => _destinationCurrency;

  set destinationCurrency(String value) {
    _destinationCurrency = value;
  }

  String get userSelectedPaymentType => _userSelectedPaymentType;

  set userSelectedPaymentType(String value) {
    _userSelectedPaymentType = value;
    print('========== $value');
    notifyListeners();
  }

  Future<void> _saveNameIntoLocalPref(String? userPin) async {
    if (userPin == null) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userPin', userPin ?? '');
  }

}

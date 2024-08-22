import 'package:nationremit/model/Mobile_operator_model.dart';
import 'package:nationremit/model/Ui_transaction_setting_model.dart';
import 'package:nationremit/model/is_success_model.dart';
import 'package:nationremit/model/set_remitter_pin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nationremit/model/beneficiary_create_model.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/create_transaction_model.dart';
import 'package:nationremit/model/partner_rates_model.dart';
import 'package:nationremit/model/partner_source_country_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/profile_details_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/model/transaction_details_model.dart';
import 'package:nationremit/model/transaction_list_model.dart';
import 'package:nationremit/network/constants/constants.dart';
import 'package:nationremit/network/rest_client.dart';

import '../../model/create_schedule_transaction.dart';
import '../../model/get_beneficiary_by_id_model.dart';
import '../../model/get_card_model.dart';
import '../../model/get_collection_point_states.dart';
import '../../model/get_collection_points.dart';
import '../../model/get_delivery_bank_branch.dart';
import '../../model/get_delivery_banks_model.dart';
import '../../model/get_profile_image_model.dart';
import '../../model/get_wallet_model.dart';
import '../../model/jwt_account_check.dart';
import '../../model/jwt_token_sale.dart';
import '../../model/partner_destination_country_model.dart';
import '../../model/store_card_model.dart';
import '../../model/support_email_model.dart';
import '../../model/transaction_schedule_list_model.dart';
import '../../model/wallet_and_card_model.dart';

class DashboardRepository {
  final _httpClient = RestClient();

  // instance of class singleton
  static final DashboardRepository _singleton = DashboardRepository._internal();

  DashboardRepository._internal();

  factory DashboardRepository() => _singleton;

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  Future<PartnerCountryModel> partnerSourceCountryAPI(
      {bool? isComingFromSignUP = false}) async {
    String token = await getToken();
    final res = isComingFromSignUP!
        ? await _httpClient.post(
            ApiConstants.baseUrl + ApiConstants.getSignUpSourceCountryList,
          )
        : await _httpClient.post(
            ApiConstants.baseUrl + ApiConstants.getPartnerSourceCountryListAPI,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          );
    return PartnerCountryModel.fromJson(res);
  }

  Future<PartnerDestinationCountryModel> partnerDestinationListAPI() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerDestinationListAPI,
      data: {'src_country': 'GBR'},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerDestinationCountryModel.fromJson(res);
  }

  Future<PartnerTransactionSettingsModel> partnerTransactionSettingsAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerTransactionSettingsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerTransactionSettingsModel.fromJson(res);
  }

  Future<BeneficiaryListModel> beneficiaryListAPI(
      {required int remitterId}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.beneficiaryListAPI,
      data: {
        'remitter_id': remitterId,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryListModel.fromJson(res);
  }

  Future<PartnerRatesModel> partnerRates(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerRatesAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print('=============== res $res');
    return PartnerRatesModel.fromJson(res);
  }

  Future<BeneficiaryCreateModel> beneficiaryCreateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.beneficiaryCreateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryCreateModel.fromJson(res);
  }

  Future<BeneficiaryCreateModel> beneficiaryUpdateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.benificiaryUpdateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryCreateModel.fromJson(res);
  }

  Future<BeneficiaryListModel> getBenificiaryByIdAPI(String id) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getBenificiaryByIdAPI + id,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryListModel.fromJson(res);
  }

  Future<BeneficiaryCreateModel> beneficiaryDeleteAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.beneficiaryDeleteAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryCreateModel.fromJson(res);
  }

  Future<CreateTransactionModel> transactionCreateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.transactionCreateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return CreateTransactionModel.fromJson(res);
  }

  Future<TransactionListModel> transactionListAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.listTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return TransactionListModel.fromJson(res);
  }

  Future<TransactionScheduleListModel> listScheduleTransactionsAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.listScheduleTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return TransactionScheduleListModel.fromJson(res);
  }

  Future<CreateScheduleTransaction> createScheduleTransactionsAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.createScheduleTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return CreateScheduleTransaction.fromJson(res);
  }

  Future<CreateScheduleTransaction> updateScheduleTransactionsAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.updateScheduleTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return CreateScheduleTransaction.fromJson(res);
  }

  Future<TransactionListModel> deleteScheduleTransactionsAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.deleteScheduleTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return TransactionListModel.fromJson(res);
  }

  Map<String, dynamic> addRequireDataForCreating(
      {required Map<String, dynamic> data}) {
    Map<String, dynamic> map = {
      "benificiary_country": 104,
      "payment_type": 4,
      "date_of_birth": "01-01-2001",
      "address": "BHEL",
      "user_id": 1,
      "partner_id": 1,
      "card_number": "",
      "bank_account_number": "",
      "bank_account_type": "",
      "bank_account_name": "",
      "bank": "",
      "back_ifsc_code": "",
      "bank_branch_id": 0,
      "bank_city": "",
      "back_state": "",
      "bank_additional_details": "",
      "collection_point_id": "",
      "collection_point_name": "",
      "collection_point_code": "",
      "collection_point_proc_bank": "",
      "collection_point_address": "",
      "collection_point_city": "",
      "collection_point_state": "",
      "collection_point_tel": 0,
      "mobile_transfer_number": 0,
      "mobile_transfer_network": "",
      "mobile_transfer_network_id": 0,
      "mobile_transfer_network_credit_type_id": 0,
      "mobile_transfer_network_credit_type": "",
    };
    map.addAll(data);
    return map;
  }

  Future<PayoutBankModel> payoutsBanksAPI({required String countryCode}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPayoutsBanksAPI + countryCode,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PayoutBankModel.fromJson(res);
  }

  Future<RegisterModel> userDetailUpdateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.userDetailUpdateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return RegisterModel.fromJson(res);
  }

  Future<RegisterModel> editedProfileUpdate(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.updateUserProfile,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return RegisterModel.fromJson(res);
  }

  Future<TransactionDetailsModel> transactionDetailsAPI(
      {required String transactionId}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.transactionDetails + '$transactionId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return TransactionDetailsModel.fromJson(res);
  }

  Future<ProfileDetailsModel> getProfileDetails() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getProfileDetails,
      data: {"data": "RemitterId"},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return ProfileDetailsModel.fromJson(res);
  }

  Future<MobileOperatorModel> getMobileNetworkOperatorsAPI(
      {required String destinationCountry}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getMobileNetworkOperators,
      data: {
        'destination_country': destinationCountry,
        'source_country': 'GBR',
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return MobileOperatorModel.fromJson(res);
  }

  Future<GetWalletModel> getUserWallet() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getUserWallet,
      data: {"wallet_id": ""},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return GetWalletModel.fromJson(res);
  }

  Future<GetWalletModel> createRemitterWallet() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.remitterWalletCreate,
      data: {"country": "GBR", "currency": "GBP"},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return GetWalletModel.fromJson(res);
  }

  Future<GetCardModel> getStoredCards() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getCard,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return GetCardModel.fromJson(res);
  }

  Future<WalletAndCardModel> getWalletAndSavedCards() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getCardAndWallet,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return WalletAndCardModel.fromJson(res);
  }

  Future<StoreCardModel> storeCard({required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.storeCard,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return StoreCardModel.fromJson(res);
  }

  Future<StoreCardModel> loadWallet(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.topUpWallet,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return StoreCardModel.fromJson(res);
  }

  Future<UiTransactionSettingModel> getUITransactionSetting(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getUITransactionSetting,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return UiTransactionSettingModel.fromJson(res);
  }

  Future<GetDeliveryBanksModel> getDeliveryBanks(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getDeliveryBanks,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return GetDeliveryBanksModel.fromJson(res);
  }

  Future<GetDeliveryBankBranch> getDeliveryBranch(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getDeliveryBranch,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return GetDeliveryBankBranch.fromJson(res);
  }

  Future<SetRemitterPin> setRemitterPin(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.setRemitterPin,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return SetRemitterPin.fromJson(res);
  }

  Future<BeneficiaryListModel> getSortedRecipient(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getSortedRecipient,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return BeneficiaryListModel.fromJson(res);
  }

  Future<GetCollectionPointStates> getCollectionPointStates(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getCollectionPointStates,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return GetCollectionPointStates.fromJson(res);
  }

  Future<GetCollectionPoints> getCollectionPoints(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getCollectionPoints,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return GetCollectionPoints.fromJson(res);
  }

  Future<JwtAccountCheck> getJwtAccountCheck(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getJwtAccountCheck,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return JwtAccountCheck.fromJson(res);
  }

  Future<JwtTokenSale> getJwtTokenSale(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getJwtTokenSale,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return JwtTokenSale.fromJson(res);
  }

  Future<IsSuccessModel> savedCardDeleteAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.deleteSavedCard,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return IsSuccessModel.fromJson(res);
  }

  Future<IsSuccessModel> sendVerificationEmail(
      {required Map<String, dynamic> data}) async {
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.sendVerificationEmail,
      data: data,
    );
    return IsSuccessModel.fromJson(res);
  }

  Future<SupportEmailModel> sendEmailToSupport(
      {required Map<String, dynamic> data}) async {
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.sendEmailToSupport,
      data: data,
    );
    return SupportEmailModel.fromJson(res);
  }

  Future<IsSuccessModel> saveProfileImage(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getRemitterProfileImage,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return IsSuccessModel.fromJson(res);
  }

  Future<GetProfileImageModel> getProfileImage(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getRemitterProfileImage,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return GetProfileImageModel.fromJson(res);
  }

}

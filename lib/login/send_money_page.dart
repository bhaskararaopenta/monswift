import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/common_widget/country_iso.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/countryFlag/country_code.dart';
import 'package:nationremit/model/Mobile_operator_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../common_widget/mobileLengthValidator.dart';
import '../countryFlag/country_code_picker.dart';
import '../constants/common_constants.dart';
import '../model/beneficiary_list_model.dart';
import '../model/get_beneficiary_by_id_model.dart';
import '../model/partner_destination_country_model.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  Timer? _debounce;
  String? userName = '';
  String userSelectedPaymentType = '';
  String mSelectedDeliveryMethod = '';
  final mobileCodeController = TextEditingController();
  final mobileController = TextEditingController();
  int _selectedIndexMobile = -1;
  int _selectedIndexBank = -1;
  int _selectedIndexCollectionState = -1;
  final _formKey = GlobalKey<FormState>();
  final _mobileformKey = GlobalKey<FormState>();

  String mAccountHolderNameController = '';
  String mSwiftNameController = '';
  String mAccountNumberController = '';
  String mAccountTypeController = '';
  String mBankBranchId = '';
  String mBankBranchCode = '';
  int mNetworkID = 0;
  String mNetwork = '';
  int mBankId = 0;
  bool isComingForSetSchedule = false;
  bool isComingFromRecipientPage = false;
  bool isComingFromRecipientDetailsPage = false;
  bool isComingFromPaymentReviewPage = false;
  bool isDeliverySelectionFlowCompleted = false;
  late CountryCodePicker countryPicker;
  CountryCode countryCode =
      CountryCode(name: 'Australia', code: 'AU', dialCode: '+61');
  String mSelectedCurrency = '';
  int collectionPointId = 0;
  String collectionPointName = '';
  String collectionPointCode = '';
  String collectionPointProcBank = '';
  String collectionPointAddress = '';
  String collectionPointCity = '';
  String collectionPointState = '';
  var svgCountryPath = '';
  late List<String> mFilteredCountriesList = List.empty(growable: true);
  Data? recipientUserDetails = null;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      provider.sendAmountController.text = double.parse('100').toStringAsFixed(2);
      provider.receiveAmountController.text = double.parse('0').toStringAsFixed(2);
      await provider.getCountryList();
      await provider.getCountryDestinationList(false);

      final req = {
        "src_country": "GBR",
        "dest_country": provider.selectCountryCode
      };
      await provider.getPartnerTransactionSettings(data: req);
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        isComingForSetSchedule =
            arguments[Constants.isComingForSetSchedule] as bool;
        isComingFromRecipientPage =
            arguments[Constants.isComingFromRecipientPage] as bool;
        isComingFromRecipientDetailsPage =
            arguments[Constants.isComingFromRecipientDetailsPage] as bool;
      isComingFromPaymentReviewPage =
            arguments[Constants.isComingFromPaymentReviewPage] as bool;
        if (isComingFromRecipientPage) {
          print('in == if ' + isComingFromRecipientPage.toString());
          recipientUserDetails = arguments[Constants.recipientUserDetails];
          countryCode = CountryCode(
              name: recipientUserDetails!.benificiaryCountry!,
              code: CountryISOMapping()
                  .getCountryISO2(recipientUserDetails!.benificiaryCountry!),
              dialCode: CountryISOMapping().getCountryISODialCode(
                  CountryISOMapping().getCountryISO2(
                      recipientUserDetails!.benificiaryCountry!)));
          setUpdatedValuesForPartnerRates(countryCode);
          print('in === if ' +
              isComingFromRecipientPage.toString() +
              ' ' +
              countryCode.toString());

          svgCountryPath = CountryISOMapping().getCountryISOFlag(
              CountryISOMapping().getCountryISO2(countryCode.code ?? ''));
        } else if (isComingFromRecipientDetailsPage) {
          print('in == if ' + isComingFromRecipientDetailsPage.toString());
          recipientUserDetails = arguments[Constants.recipientUserDetails];
          var benificiaryCountry = arguments[Constants.beneCountry]??recipientUserDetails!.benificiaryCountry;
          countryCode = CountryCode(
              name: benificiaryCountry,
              code: CountryISOMapping().getCountryISO2(benificiaryCountry),
              dialCode: CountryISOMapping().getCountryISODialCode(
                  CountryISOMapping().getCountryISO2(benificiaryCountry)));
          setUpdatedValuesForPartnerRates(countryCode);
          print('in === if ' +
              isComingFromRecipientDetailsPage.toString() +
              ' ' +
              countryCode.toString());
          svgCountryPath = CountryISOMapping().getCountryISOFlag(
              CountryISOMapping().getCountryISO2(countryCode.code ?? ''));
        } else {
          if (isComingFromPaymentReviewPage) {
            recipientUserDetails = arguments[Constants.recipientUserDetails];
            var benificiaryCountry = arguments[Constants.beneCountry]??recipientUserDetails!.benificiaryCountry;
            countryCode = CountryCode(
                name: benificiaryCountry,
                code: CountryISOMapping().getCountryISO2(benificiaryCountry),
                dialCode: CountryISOMapping().getCountryISODialCode(
                    CountryISOMapping().getCountryISO2(benificiaryCountry)));
            setUpdatedValuesForPartnerRates(countryCode);
            svgCountryPath = CountryISOMapping().getCountryISOFlag(
                CountryISOMapping().getCountryISO2(countryCode.code ?? ''));
          } else {
            print('in == else ' +
                Constants.isComingFromRecipientDetailsPage.toString() +
                ' ' +
                countryCode.toString());
            _callPartnerRates(amount: '100');
            svgCountryPath = CountryISOMapping().getCountryISOFlag(
                CountryISOMapping().getCountryISO2(countryCode.code ?? ''));
          }
        }
      }
      provider.userSelectedPaymentType = '';
    });
    print('in == init');

    super.initState();
  }

  _onSearchChanged({required String query, String? action = 'source'}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query.isEmpty) return;
    _debounce = Timer(const Duration(milliseconds: 500), () {
      query = query.endsWith('.') ? query.replaceAll('.', '') : query;
      _callPartnerRates(amount: query, action: action);
      print('====_callPartnerRates =====called');
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _callPartnerRates({
    required String amount,
    String? action = 'source',
  }) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      Map<String, dynamic> data = {
        'partner_id': loginProvider.userInfo!.response?.userDetails!.partnerId,
        'source_currency': provider.sourceCurrency,
        'destination_currency': provider.destinationCurrency,
        'transfer_type_po': getPaymentType(provider.selectPaymentMode.isEmpty
            ? mSelectedDeliveryMethod
            : provider.selectPaymentMode),
        'amount': double.parse(amount),
        'service_level': provider.serviceLevel,
        'action': action,
        "dest_country": provider.destinationCountry,
        "payment_type": "debit-credit-card",
        "src_country": provider
            .countryDestinationList?.response!.sourceCurrency!.countryCode,
      };

      var mRateRes = await provider.getPartnerRates(data: data);
      if (mounted && !mRateRes.success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(mRateRes.error!.message.toString()),
        ));
      }
      FocusManager.instance.primaryFocus?.unfocus();
      final req = {
        "src_country": "GBR",
        "dest_country": provider.selectCountryCode
      };
      var mResTransaction =
          await provider.getPartnerTransactionSettings(data: req);
      if (mResTransaction.success != null && !mResTransaction.success!) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(mResTransaction.error!.message),
        ));
      }
      // await provider.getUITransactionSetting(data: req);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> getCollectionsStates() async {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      final req = {
        "source_country": "GBR",
        "destination_country": provider.selectCountryCode
      };
      var res = await provider.getCollectionPointStates(data: req);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> getCollections(String selectedDeliveryMethod) async {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      final req = {
        "source_country": "GBR",
        "destination_country": provider.selectCountryCode
      };
      var res = await provider.getCollectionPoints(data: req);

      collectionPointId = res.response![0].id!;
      collectionPointName = res.response![0].name!;
      collectionPointCode = res.response![0].code!;
      collectionPointProcBank = res.response![0].bank!;
      collectionPointAddress = res.response![0].address!;
      collectionPointCity = res.response![0].city!;
      collectionPointState = res.response![0].state!;
      isDeliverySelectionFlowCompleted = true;
      mSelectedDeliveryMethod = selectedDeliveryMethod!;
      if (mounted && !provider.isLoading) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    print('in == build');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            if (provider.countryDestinationList != null) {
              mFilteredCountriesList.clear();
              for (var res in provider
                  .countryDestinationList!.response!.destinationCurrency!) {
                // print('flag======== ${res.countryCode}');
                mFilteredCountriesList
                    .add(CountryISOMapping().getCountryISO2(res.countryCode!));
              }
            }
            countryPicker = CountryCodePicker(
                showDialCode: false,
                showSearchBar: true,
                filteredCountries: mFilteredCountriesList);

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(-1.05, 1.05),
                        child: InkWell(
                          onTap: () {
                           // Navigator.of(context).pop(false);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouterConstants.dashboardRoute,
                                arguments: {Constants.dashboardPageOpen: 0},
                                    (Route<dynamic> route) => false);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset(AssetsConstant.icBack),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Send money',
                    style: AppTextStyles.screenTitle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'You send',
                    style: AppTextStyles.subtitleText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.outlineBtnColor),
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(14)),
                              color: const Color.fromRGBO(246, 247, 249, 1)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                            topStart: Radius.circular(14),
                                            bottomStart: Radius.circular(14)),
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller:
                                              provider.sendAmountController,
                                          onChanged: (q) {
                                            _onSearchChanged(query: q);
                                          },
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                            topEnd: Radius.circular(14),
                                            bottomEnd: Radius.circular(14)),
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1.0)),
                                child: SizedBox(
                                  width: 100,
                                  child: GestureDetector(
                                    onTap: () {
                                      /*provider.whichTypeCountryMode =
                                          Constants.showSourceCountry;
                                      Navigator.pushNamed(
                                        context,
                                        RouterConstants.selectCountryRoute,
                                      ).then((value) {
                                        if (value != null) {
                                          provider.sourceCountry =
                                              value as String;
                                        }
                                        _callPartnerRates(
                                            action: '',
                                            amount: provider
                                                .sendAmountController.text);
                                      });*/
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          provider.getCountryFlag(
                                              provider.sourceCountry),
                                          width: 29,
                                          height: 29,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          provider.sourceCurrency,
                                          style:
                                              AppTextStyles.currencyOnSendMoney,
                                        ) /*,
                                        const Icon(
                                            Icons.keyboard_arrow_down_rounded)*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*   const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            if (provider.convertRate != null)
                              Text(
                                '1 GBP = ' +
                                    provider.convertRate! +
                                    ' ' +
                                    provider.destinationCurrency,
                                style: AppTextStyles.oneGbpText,
                              ),
                          ],
                        ),*/
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AssetsConstant.icCircleMinus),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('${provider.totalFees}' + ' GBP',
                                style: AppTextStyles.sendMoneyInfoLeftText),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Our Fees',
                                      textAlign: TextAlign.end,
                                      style:
                                          AppTextStyles.sendMoneyInfoRightText),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(AssetsConstant.icInformation)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AssetsConstant.icEqual),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                                ((double.parse(provider
                                                .sendAmountController.text
                                                .trim()) -
                                            double.parse(
                                                provider.platformFees!)))
                                        .toStringAsFixed(2)
                                        .toString() +
                                    ' GBP',
                                style: AppTextStyles.sendMoneyInfoLeftText),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Amount to convert',
                                      textAlign: TextAlign.end,
                                      style:
                                          AppTextStyles.sendMoneyInfoRightText),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(AssetsConstant.icInformation)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AssetsConstant.icMultiplication),
                            const SizedBox(
                              width: 12,
                            ),
                            if (provider.convertRate != null)
                              Text(
                                provider.convertRate! +
                                    ' ' +
                                    provider.destinationCurrency,
                                style: AppTextStyles.sendMoneyInfoLeftText,
                              ),
                            /*Text(
                                '${NumberFormat.decimalPattern().format(double.parse(provider.convertRate!))}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),*/
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Rate',
                                      textAlign: TextAlign.end,
                                      style:
                                          AppTextStyles.sendMoneyInfoRightText),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(AssetsConstant.icInformation)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Text('Recipient gets', style: AppTextStyles.subtitleText),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: AppColors.outlineBtnColor),
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(14)),
                        color: const Color.fromRGBO(246, 247, 249, 1)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(14),
                                  bottomStart: Radius.circular(14)),
                              color: const Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller:
                                        provider.receiveAmountController,
                                    onChanged: (q) {
                                      _onSearchChanged(
                                          query: q, action: 'destination');
                                    },
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                // Text(
                                //   ' ${NumberFormat.decimalPattern().format(double.parse(provider.receiveAmount))}',
                                //   style: const TextStyle(
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.w700),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(14),
                                  bottomEnd: Radius.circular(14)),
                              color: const Color.fromRGBO(255, 255, 255, 1.0)),
                          child: SizedBox(
                            width: 120,
                            child: GestureDetector(
                              onTap: () async {
                                final picked = await countryPicker.showPicker(
                                    context: context);
                                // Null check
                                if (picked != null) print(picked);
                                child:
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: Text('',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                );
                                setState(() {
                                  countryCode = picked!;
                                  /* if (provider.countryDestinationList != null) {
                                    for (var res in provider
                                        .countryDestinationList!
                                        .response[0]
                                        .destinationCurrency) {
                                      if (res.countryCode ==
                                          CountryISOMapping().getCountryISO3(
                                              countryCode.code)) {
                                        provider.destinationCurrency =
                                            res.currencySupported[0].currency;
                                        provider.destinationCountry =
                                            res.countryCode;
                                        provider.selectCountryCodeByUser(
                                            res.countryCode);
                                        _callPartnerRates(
                                          amount: provider
                                              .sendAmountController.text,
                                        );
                                        print(
                                            'flag====Currency==== ${res.currencySupported[0].currency}');
                                      }
                                    }
                                  }*/
                                  setUpdatedValuesForPartnerRates(countryCode);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  countryCode.flagImage,
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    provider.destinationCurrency,
                                    style: AppTextStyles.currencyOnSendMoney,
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Delivery method',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (!isDeliverySelectionFlowCompleted)
                    Container(
                      height: 127,
                      child: Consumer<DashBoardProvider>(
                          builder: (_, provider, __) {
                        return ListView.builder(
                          itemCount: provider.partnerTransactionSettingsModel
                                      ?.response!.transferTypes ==
                                  null
                              ? 0
                              : provider.partnerTransactionSettingsModel
                                  ?.response!.transferTypes!.length,
                          itemBuilder: (context, index) {
                            return getWidget(
                                provider,
                                AssetsConstant.rwandaFlagIcon,
                                provider.partnerTransactionSettingsModel!
                                    .response!.transferTypes![index]!,
                                index,
                                false);
                          },
                          scrollDirection: Axis.horizontal,
                        );
                      }),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 56,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(20),
                              bottomStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                              bottomEnd: Radius.circular(20)),
                          color: const Color.fromRGBO(233, 236, 255, 1.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(provider.selectPaymentMode),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mSelectedDeliveryMethod,
                            style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 16,
                                fontFamily: 'Inter-Regular',
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              showBottomSheetDeliveryMethod();
                              setState(() {
                                //isDeliverySelectionFlowCompleted=false;
                              });
                            },
                            child: Text(
                              'Change',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.signUpBtnColor,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ))
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Apply promo code',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /*  Row(
                    children: [
                      Text(
                        'Our fee',
                        style: TextStyle(
                            color: AppColors.feeColorText,
                            fontSize: 16,
                            fontFamily: 'Inter-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                          '' */ /*double.parse(provider.rate).toStringAsFixed(2)*/ /*,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                      if (provider.platformFees != null)
                        Expanded(
                          child: Text(
                            provider.platformFees! + ' GBP',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 16,
                                fontFamily: 'Inter-SemiBold',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Total you pay',
                            style: TextStyle(
                                color: AppColors.feeColorText,
                                fontSize: 16,
                                fontFamily: 'Inter-Regular',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                            double.parse(provider.sendAmountController.text)
                                    .toStringAsFixed(2) +
                                " GBP",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 16,
                                fontFamily: 'Inter-SemiBold',
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.signUpBtnColor,
                            textStyle: TextStyle(
                                fontFamily: 'Inter-Bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.textWhite),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: !isDeliverySelectionFlowCompleted ||
                                  provider.receiveAmountController.text == "0"
                              ? null
                              : () {
                                  if (isComingFromRecipientPage || isComingFromRecipientDetailsPage || isComingFromPaymentReviewPage) {
                                    sendToTransferDetailPageIfRecipientAlreadySelected();
                                  } else {
                                    Navigator.pushNamed(
                                        context,
                                        RouterConstants
                                            .selectRecipientToSendMoneyRoute,
                                        arguments: {
                                          Constants.accountHolderName:
                                              mAccountHolderNameController,
                                          Constants.accountNumber:
                                              mAccountNumberController,
                                          Constants.swiftCode:
                                              mSwiftNameController,
                                          Constants.accountType:
                                              mAccountTypeController,
                                          Constants.beneMobileNumber:
                                              mobileController.text,
                                          Constants.mobileTransferNetworkId:
                                              mNetworkID,
                                          Constants.mobileTransferNetwork:
                                              mNetwork,
                                          Constants.deliveryType:
                                              mSelectedDeliveryMethod,
                                          Constants.bankId: mBankId,
                                          Constants.isComingForSetSchedule:
                                              isComingForSetSchedule,
                                          Constants.collectionPointId:
                                              collectionPointId,
                                          Constants.collectionPointName:
                                              collectionPointName,
                                          Constants.collectionPointCode:
                                              collectionPointCode,
                                          Constants.collectionPointProcBank:
                                              collectionPointProcBank,
                                          Constants.collectionPointAddress:
                                              collectionPointAddress,
                                          Constants.collectionPointCity:
                                              collectionPointCity,
                                          Constants.collectionPointState:
                                              collectionPointState,
                                          Constants.collectionPointTel: "",
                                          Constants.isComingFromRecipientDetailsPage:  isComingFromRecipientDetailsPage,
                                          Constants.isComingFromRecipientPage: isComingFromRecipientPage,
                                        });
                                  }
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              :  Text('Continue',
                          style: AppTextStyles.enableContinueBtnTxt,))),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getWidget(DashBoardProvider provider, String imagePath,
      TransferTypes data, int index, bool isBottomSheetSelected) {
    return GestureDetector(
      onTap: () {
        if (isBottomSheetSelected) {
          Navigator.pop(context);
        }

        switch (data.name) {
          case "Bank Transfer":
            provider.selectPaymentMode = data.name!;
            // mSelectedDeliveryMethod = data.name!;
            showBottomSheetBank(data.name!);
            break;
          case "Mobile Transfer":
            provider.selectPaymentMode = data.name!;
            //  mSelectedDeliveryMethod = data.name!;
            showBottomSheetMobile(data.name!);
            break;
          case "Cash Pickup":
            provider.selectPaymentMode = data.name!;
            // mSelectedDeliveryMethod = data.name!;
            showBottomSheetCashPickUp(data.name!);
            break;
          case "Wallet":
            provider.selectPaymentMode = data.name!;
            mSelectedDeliveryMethod = data.name!;
            _callPartnerRates(
              amount: provider.sendAmountController.text,
            );
            break;
        }
      },
      onTapDown: (_) {
        provider.selectPaymentMode = data.name!;
      },
      onTapCancel: () {
        provider.selectPaymentMode = data.name!;
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 243, 245, 248)),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset(AssetsConstant.navWalletIcon),
            SizedBox(
              height: 8,
            ),
            Text(
              data.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter-SemiBold',
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMobileOperator(DashBoardProvider provider, String imagePath,
      operatorImg, int id, StateSetter setMobileModalState, Mnos mno) {
    bool checked = id == _selectedIndexMobile;
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context, data.value);
        //provider.userSelectedPaymentType = operatorImg;
        userSelectedPaymentType = operatorImg;
        mNetwork = mno.name!;
        mNetworkID = mno.mobileNetworkId!;
        setMobileModalState(() {
          _selectedIndexMobile = id;
        });
        _callPartnerRates(
          amount: provider.sendAmountController.text,
        );
      },
      onTapDown: (_) {
        /* userSelectedPaymentType = operatorImg!;
        setState(() {
          _selectedIndexMobile = id;
          Navigator.pop(context);
        //  showBottomSheetMobile();
        });*/
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: checked
                ? Border.all(
                    width: 1, color: Color.fromARGB(255, 104, 123, 252))
                : Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 255, 255, 255)),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.asset(operatorImg),*/
            Text(operatorImg,
                style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.edittextTitle))
          ],
        ),
      ),
    );
  }

  Widget getBanks(
      DashBoardProvider provider,
      String imagePath,
      operatorImg,
      int id,
      StateSetter setBankModalState,
      int bankId,
      String selectedDeliveryMethod) {
    return GestureDetector(
      onTap: () {
        //     Navigator.pop(context);
        //provider.userSelectedPaymentType = operatorImg;
        try {
          final provider = Provider.of<DashBoardProvider>(
            context,
            listen: false,
          );
          final req = {
            "delivery_bank_id": bankId,
            "delivery_bank": "",
            "delivery_branch_state": "",
            "delivery_bank_city": ""
          };
          provider.getDeliveryBranch(data: req);
          mBankId = bankId;
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }

        userSelectedPaymentType = operatorImg;
        setBankModalState(() {
          _selectedIndexBank = id;
          Navigator.pop(context);
          showBottomSheetBankDetailsFields(selectedDeliveryMethod);
          mBankBranchCode = '';
          mBankBranchId = '';
        });
        /*setState(() {
          _selectedIndexBank = id;
        });*/
      },
      onTapDown: (_) {
        userSelectedPaymentType = operatorImg!;
        setBankModalState(() {
          _selectedIndexBank = id;
          Navigator.pop(context);
          showBottomSheetBankDetailsFields(selectedDeliveryMethod);
        });
      },
      child: Container(
        width: 174.0,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: id == _selectedIndexBank
                ? Border.all(
                    width: 1, color: Color.fromARGB(255, 104, 123, 252))
                : Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 255, 255, 255)),
        padding: const EdgeInsets.all(8),
        child: provider.isLoading
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //   Image.asset(operatorImg),
                  Text(operatorImg,
                      style: TextStyle(
                          fontFamily: 'Inter-Medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.edittextTitle))
                ],
              ),
      ),
    );
  }

  Widget showCollectionsState(DashBoardProvider provider, operatorImg, int id,
      StateSetter setCollectionStateModalState, String selectedDeliveryMethod) {
    return GestureDetector(
      onTap: () {
        try {
          final provider = Provider.of<DashBoardProvider>(
            context,
            listen: false,
          );

          if (!provider.isLoading)
            final response = getCollections(selectedDeliveryMethod);
          _callPartnerRates(
            amount: provider.sendAmountController.text,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }

        userSelectedPaymentType = operatorImg;
        setCollectionStateModalState(() {
          _selectedIndexCollectionState = id;
        });
        /*setState(() {
          _selectedIndexBank = id;
        });*/
      },
      onTapDown: (_) {
        /*userSelectedPaymentType = operatorImg!;
        setCollectionStateModalState(() {
          _selectedIndexCollectionState = id;
        });*/
      },
      child: Container(
        width: 174.0,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: id == _selectedIndexCollectionState
                ? Border.all(
                    width: 1, color: Color.fromARGB(255, 104, 123, 252))
                : Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 255, 255, 255)),
        padding: const EdgeInsets.all(8),
        child: provider.isLoading
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //   Image.asset(operatorImg),
                  Text(operatorImg,
                      style: TextStyle(
                          fontFamily: 'Inter-Medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.edittextTitle))
                ],
              ),
      ),
    );
  }

  void showBottomSheetMobile(String selectedDeliveryMethod) {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final res = provider.getMobileNetworkOperatorsAPI(
          mDestinationCountry: provider.selectCountryCode);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    mobileCodeController.text =countryCode.dialCode;
    userSelectedPaymentType = '';
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setMobileModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 450,
                margin: EdgeInsets.all(15),
                child: SizedBox(
                  child: Form(
                    key: _mobileformKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 10),
                          SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                          SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 56,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                        topStart: Radius.circular(20),
                                        bottomStart: Radius.circular(20),
                                        topEnd: Radius.circular(20),
                                        bottomEnd: Radius.circular(20)),
                                color:
                                    const Color.fromRGBO(233, 236, 255, 1.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(AssetsConstant.icMob),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Mobile Transfer',
                                  style: TextStyle(
                                      color: AppColors.textDark,
                                      fontSize: 16,
                                      fontFamily: 'Inter-Regular',
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 120,
                            child: Consumer<DashBoardProvider>(
                                builder: (_, provider, __) {
                              return provider.mobileOperatorModel?.response
                                          ?.mnos !=
                                      null
                                  ? ListView.builder(
                                      itemCount: provider.mobileOperatorModel
                                          ?.response?.mnos?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return getMobileOperator(
                                            provider,
                                            AssetsConstant.rwandaFlagIcon,
                                            provider.mobileOperatorModel!
                                                .response!.mnos?[index].name,
                                            index,
                                            setMobileModalState,
                                            provider.mobileOperatorModel!
                                                .response!.mnos![index]);
                                      },
                                      scrollDirection: Axis.horizontal,
                                    )
                                  : provider.isLoading
                                      ? Center(
                                          child: SizedBox(
                                            child: CircularProgressIndicator(),
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        )
                                      : const Expanded(
                                          child: Center(
                                            child: Text(
                                                'No mobile operator found...'),
                                          ),
                                        );
                            }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Mobile Number',
                              style: TextStyle(
                                  fontFamily: 'Inter-Medium',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.edittextTitle),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  enabled: false,
                                  controller: mobileCodeController,
                                  decoration: editTextMobileCodeProperty(
                                      hitText: countryCode.dialCode,
                                      svg: svgCountryPath),
                                  style: const TextStyle(fontSize: 16),
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: mobileController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    } else {
                                      /*if (value.length != 11)
                                        return 'Mobile Number must be of 10 digit';*/
                                      if (value.startsWith('0')) {
                                        if (value.length != 10) {
                                          print("if " +
                                              value +
                                              " " +
                                              value.startsWith('0').toString());
                                          return 'Mobile Number must be of 10 digit';
                                        }
                                      } else {
                                        if (value.length != 9) {
                                          print("else " +
                                              value +
                                              " " +
                                              value.startsWith('0').toString());
                                          return 'Mobile Number must be of 9 digit';
                                        }
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: editTextProperty(
                                      hitText: 'Enter Mobile number'),
                                  style: const TextStyle(fontSize: 14),
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    DynamicLengthLimitingTextInputFormatterForCountry(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.signUpBtnColor,
                                      textStyle: TextStyle(
                                          fontFamily: 'Inter-Bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: AppColors.textWhite),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(65)),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_mobileformKey.currentState!
                                          .validate()) {
                                        setState(() {
                                          isDeliverySelectionFlowCompleted =
                                              true;
                                          mSelectedDeliveryMethod =
                                              selectedDeliveryMethod;
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    child:  Text("Continue",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600,
                                        color: AppColors.textWhite))),
                              ),
                            ),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void showBottomSheetDeliveryMethod() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(15),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Delivery Method',
                    style: AppTextStyles.gbpText,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 120,
                  child:
                      Consumer<DashBoardProvider>(builder: (_, provider, __) {
                    return ListView.builder(
                      itemCount: provider.partnerTransactionSettingsModel
                                  ?.response!.transferTypes ==
                              null
                          ? 0
                          : provider.partnerTransactionSettingsModel?.response!
                              .transferTypes!.length,
                      itemBuilder: (context, index) {
                        return getWidget(
                            provider,
                            AssetsConstant.rwandaFlagIcon,
                            provider.partnerTransactionSettingsModel!.response!
                                .transferTypes![index],
                            index,
                            true);
                      },
                      scrollDirection: Axis.horizontal,
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetBank(String selectedDeliveryMethod) {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final req = {
        'destination_country': provider.selectCountryCode,
        'source_country': 'GBR'
      };
      final res = provider.getDeliveryBanks(data: req);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setBankModalState) {
          return Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 56,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20),
                                bottomStart: Radius.circular(20),
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                            color: const Color.fromRGBO(233, 236, 255, 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AssetsConstant.bankIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Bank Transfer',
                              style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      //if (userSelectedPaymentType.isEmpty)
                      Container(
                        height: 280,
                        child: Consumer<DashBoardProvider>(
                            builder: (_, provider, __) {
                          return provider.getDeliveryBanksModel?.response !=
                                  null
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    provider.getDeliveryBanksModel!.response!
                                        .length,
                                    (index) {
                                      return getBanks(
                                          provider,
                                          AssetsConstant.rwandaFlagIcon,
                                          provider.getDeliveryBanksModel!
                                              .response![index].name,
                                          index,
                                          setBankModalState,
                                          provider.getDeliveryBanksModel!
                                              .response![index].bankId!,
                                          selectedDeliveryMethod);
                                    },
                                  ))
                              : provider.isLoading
                                  ? Center(
                                      child: SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    )
                                  : Expanded(
                                      child: Center(
                                        child: Text('No banks found...'),
                                      ),
                                    );
                        }),
                      )
                      /* else
                        showBottomSheetBankDetailsFields(),*/
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetCashPickUp(String selectedDeliveryMethod) {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      getCollectionsStates();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setBankModalState) {
          return Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 56,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20),
                                bottomStart: Radius.circular(20),
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                            color: const Color.fromRGBO(233, 236, 255, 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AssetsConstant.bankIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Cash Pickup',
                              style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 16,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      //    if (userSelectedPaymentType.isEmpty)
                      Container(
                        height: 280,
                        child: Consumer<DashBoardProvider>(
                            builder: (_, provider, __) {
                          return provider.getCollectionPointState?.response !=
                                  null
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    provider.getCollectionPointState!.response!
                                        .length,
                                    (index) {
                                      return showCollectionsState(
                                          provider,
                                          provider.getCollectionPointState!
                                              .response![index],
                                          index,
                                          setBankModalState,
                                          selectedDeliveryMethod);
                                    },
                                  ))
                              : provider.isLoading
                                  ? Center(
                                      child: SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    )
                                  : const Expanded(
                                      child: Center(
                                        child: Text('No States found...'),
                                      ),
                                    );
                        }),
                      )
                      /* else
                        showBottomSheetBankDetailsFields(),*/
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetBankDetailsFields(String selectedDeliveryMethod) {
    final accountHolderNameController = TextEditingController();
    final swiftNameController = TextEditingController();
    final accountNumberController = TextEditingController();
    final accountTypeController = TextEditingController();

    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
                return Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Account holder name',
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.edittextTitle),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: accountHolderNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            decoration: editTextProperty(
                                hitText: 'Enter account holder name'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Swift code',
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.edittextTitle),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: swiftNameController,
                            /*validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter swift code';
                              }
                              return null;
                            },*/
                            decoration:
                                editTextProperty(hitText: 'Enter swift code'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Account Number',
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.edittextTitle),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: accountNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter account number';
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter account number'),
                                style: const TextStyle(fontSize: 14),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Account Type',
                            style: TextStyle(
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.edittextTitle),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: accountTypeController,
                           /* validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter account type';
                              }
                              return null;
                            },*/
                            decoration:
                                editTextProperty(hitText: 'Enter account type'),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                accountHolderNameController.text.isNotEmpty &&
                                    accountNumberController.text.isNotEmpty
                              ? AppColors.signUpBtnColor
                                  : AppColors.outlineBtnColor,
                                textStyle: TextStyle(
                                    fontFamily: 'Inter-Bold',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppColors.textWhite),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(65)),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  mAccountHolderNameController =
                                      accountHolderNameController.text;
                                  mSwiftNameController =
                                      swiftNameController.text;
                                  mAccountNumberController =
                                      accountNumberController.text;
                                  mAccountTypeController =
                                      accountTypeController.text;
                                  isDeliverySelectionFlowCompleted = true;
                                  mSelectedDeliveryMethod =
                                      selectedDeliveryMethod;
                                  _callPartnerRates(
                                    amount: provider.sendAmountController.text,
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  :  Text("Continue",
                                 style: accountHolderNameController.text.isNotEmpty &&
                                      accountNumberController.text.isNotEmpty
                                      ? AppTextStyles.enableContinueBtnTxt
                                      : AppTextStyles.disableContinueBtnTxt)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }

  String getPaymentType(String selectPaymentMode) {
    String type = '';
    switch (selectPaymentMode) {
      case "Account":
        type = "bank-transfer";
        break;
      case 'Bank Transfer':
        type = "bank-transfer";
        break;
      case "Mobile Transfer":
        type = "mobile-transfer";
        break;
      case "Cash Collection":
        type = "cash-pickup";
        break;
      case "Wallet Transfer":
        type = "wallet";
        break;
      case "Cash Pickup":
        type = "cash-pickup";
        break;
    }
    return type;
  }

  void setUpdatedValuesForPartnerRates(CountryCode countryCode) {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    if (provider.countryDestinationList != null) {
      for (var res
          in provider.countryDestinationList!.response!.destinationCurrency!) {
        if (res.countryCode ==
            CountryISOMapping().getCountryISO3(countryCode.code)) {
          provider.destinationCurrency = res.currencySupported![0].currency!;
          provider.destinationCountry = res.countryCode!;
          provider.selectCountryCodeByUser(res.countryCode!);
          _callPartnerRates(
            amount: provider.sendAmountController.text,
          );
          print('flag====Currency==== ${res.currencySupported![0].currency}');
          svgCountryPath = CountryISOMapping().getCountryISOFlag(
              CountryISOMapping().getCountryISO2(countryCode.code ?? ''));
        }
      }
    }
  }

  Future<void> sendToTransferDetailPageIfRecipientAlreadySelected() async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    var req;
    //  try {
    switch (mSelectedDeliveryMethod) {
      case "Account":
        req = {
          //  Constants.beneMobileNumber: mobileNumber,
          Constants.beneId: recipientUserDetails!.beneId,
          Constants.beneCountry: recipientUserDetails!.benificiaryCountry,
          Constants.beneCity: '',
          "bene_bank_details": {
            Constants.accountHolderName: mAccountHolderNameController,
            Constants.accountNumber: mAccountNumberController,
            Constants.swiftCode: mSwiftNameController,
            Constants.accountType: mAccountTypeController,
            "bank": "",
            // "bank_branch_id": bankId,
            "bank_city": "",
            "bank_state": "",
            "bank_additional_details": "",
            //"bank_branch_code":'',
            "bank_branch_id": provider.getDeliveryBankBranch != null
                ? provider.getDeliveryBankBranch?.response![0].id
                : ''
          },
        };
        break;
      case "Bank Transfer":
        req = {
          //  Constants.beneMobileNumber: mobileNumber,
          Constants.beneId: recipientUserDetails!.beneId,
          Constants.beneCountry: recipientUserDetails!.benificiaryCountry,
          Constants.beneCity: '',
          "bene_bank_details": {
            Constants.accountHolderName: mAccountHolderNameController,
            Constants.accountNumber: mAccountNumberController,
            Constants.swiftCode: mSwiftNameController,
            Constants.accountType: mAccountTypeController,
            "bank": "",
            //"bank_branch_id": bankId,
            "bank_city": "",
            "bank_state": "",
            "bank_additional_details": "",
            "bank_branch_id": provider.getDeliveryBankBranch != null
                ? provider.getDeliveryBankBranch?.response![0].id
                : ''
          },
        };
        break;
      case "Mobile Transfer":
        mobileCodeController.text = countryCode.dialCode.toString().trim();
        req = {
          //  Constants.beneMobileNumber: mobileNumber,
          Constants.beneId: recipientUserDetails!.beneId,
          Constants.beneCountry: recipientUserDetails!.benificiaryCountry,
          "mobile_transfer_number":
              mobileCodeController.text.toString().trim() +
                  mobileController.text.toString().trim(),
          "mobile_transfer_network": mNetwork,
          "mobile_transfer_network_id": mNetworkID,
          Constants.beneCity: 'london'
        };
        print("mobile code ---"+mobileCodeController.text.toString());
        break;
      case "Cash Collection":
        req = {
          Constants.beneId: recipientUserDetails!.beneId,
          Constants.collectionPointId: collectionPointId,
          Constants.collectionPointName: collectionPointName,
          Constants.collectionPointCode: collectionPointCode,
          Constants.collectionPointProcBank: collectionPointProcBank,
          Constants.collectionPointAddress: collectionPointAddress,
          Constants.collectionPointCity: collectionPointCity,
          Constants.collectionPointState: collectionPointState,
          Constants.collectionPointTel: "",
          "is_favorite": false
        };
        break;
      case "Wallet Transfer":
        break;
      case "Cash Pickup":
        req = {
          Constants.beneId: recipientUserDetails!.beneId,
          Constants.collectionPointId: collectionPointId,
          Constants.collectionPointName: collectionPointName,
          Constants.collectionPointCode: collectionPointCode,
          Constants.collectionPointProcBank: collectionPointProcBank,
          Constants.collectionPointAddress: collectionPointAddress,
          Constants.collectionPointCity: collectionPointCity,
          Constants.collectionPointState: collectionPointState,
          Constants.collectionPointTel: "",
          "is_favorite": false
        };
        break;
    }

    final res = await provider.beneficiaryUpdate(data: req);
    if (mounted && res.success!) {
      Navigator.pushNamed(context, RouterConstants.transferDetailRoute,
          arguments: {
            Constants.recipientUserDetails: recipientUserDetails,
            Constants.deliveryType: mSelectedDeliveryMethod,
            Constants.isComingForSetSchedule: isComingForSetSchedule,
            Constants.isComingFromRecipientDetailsPage:  isComingFromRecipientDetailsPage,
            Constants.isComingFromRecipientPage: isComingFromRecipientPage,

          });
    } else {
      if (!res.success!) {
        provider.setLoadingStatus(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res.error!.message),
        ));
      }
    }
  }
}

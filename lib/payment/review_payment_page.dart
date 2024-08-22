import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../common_widget/mobileLengthValidator.dart';
import '../constants/common_constants.dart';
import '../countryFlag/country_code.dart';
import '../model/Mobile_operator_model.dart';
import '../model/beneficiary_list_model.dart';
import '../model/partner_transaction_settings_model.dart';

class ReviewPaymentPage extends StatefulWidget {
  const ReviewPaymentPage({super.key});

  @override
  State<ReviewPaymentPage> createState() => _ReviewPaymentPageState();
}

class _ReviewPaymentPageState extends State<ReviewPaymentPage> {
  Timer? _debounce;
  String? userName = '';
  String userSelectedPaymentType = '';
  final mobileCodeController = TextEditingController();
  final mobileController = TextEditingController();
  int _selectedIndex = -1;
  final _formKey = GlobalKey<FormState>();
  int _selectedIndexMobile = -1;

  String mAccountHolderNameController = '';
  String mSwiftNameController = '';
  String mAccountNumberController = '';
  String mAccountTypeController = '';
  String mBankBranchId = '';
  String mBankBranchCode = '';
  int mNetworkID = 0;
  String mNetwork = '';
  int mBankId = 0;

  String mSelectedDeliveryMethod = '';
  String? mDeliveryType = '';
  bool isComingForSetSchedule = false;
  bool isComingFromRecipientDetailsPage=  false;
  bool isComingFromRecipientPage=false;
  String scheduleDate = '';
  String scheduleFrequency = '';
  int collectionPointId = 0;
  String collectionPointName = '';
  String collectionPointCode = '';
  String collectionPointProcBank = '';
  String collectionPointAddress = '';
  String collectionPointCity = '';
  String collectionPointState = '';
  int _selectedIndexCollectionState = -1;
  int _selectedIndexBank = -1;
  final _mobileformKey = GlobalKey<FormState>();
  final _bankFormKey = GlobalKey<FormState>();
  bool isDeliverySelectionFlowCompleted = false;

  // late CountryCodePicker countryPicker;
  Data? data = null;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final loginProvider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      provider.sendAmountController.text = provider.sendAmountController.text;
      await provider.getCountryList();
      await provider.getCountryDestinationList(true);

      //  _callPartnerRates(amount: provider.sendAmountController.text);
      provider.userSelectedPaymentType = '';

      try {
        for (var res in provider.countryDestinationList!.response!.destinationCurrency!) {
          //print('transferType======== ${res.transferType}');
          //  print('selectPaymentMode======== ${provider.selectPaymentMode}');
          if (provider.destinationCountry.toLowerCase() ==
              res.countryName!.toLowerCase()) {
            provider.destinationCurrency =
                res.currencySupported![0].currency!;
          }
          // userList.add(res);
        }
      } catch (e) {}
    });
    super.initState();
  }

  _onSearchChanged({required String query, String? action = 'source'}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query.isEmpty) return;
    _debounce = Timer(const Duration(milliseconds: 500), () {
      query = query.endsWith('.') ? query.replaceAll('.', '') : query;
      _callPartnerRates(amount: query, action: action);
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
        'source_currency': provider.sourceCountry,
        'destination_currency': provider.destinationCountry,
        'transfer_type_po': getPaymentType(mDeliveryType!),
        'amount': double.parse(amount),
        'service_level': provider.serviceLevel,
        'action': action,
        "payment_type": "debit-credit-card",
        "src_country": provider
            .countryDestinationList?.response!.sourceCurrency!.countryName,
      };

      provider.getPartnerRates(data: data);
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
      mDeliveryType = selectedDeliveryMethod;
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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    data = arguments[Constants.recipientUserDetails] as Data;
    String? sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
    String? purposeOf = arguments[Constants.purposeOf] as String;
    mDeliveryType = arguments[Constants.deliveryType] as String?;
    isComingFromRecipientPage =
    arguments[Constants.isComingFromRecipientPage] as bool;
    isComingFromRecipientDetailsPage =
    arguments[Constants.isComingFromRecipientDetailsPage] as bool;
    isComingForSetSchedule =
        arguments[Constants.isComingForSetSchedule] as bool;
    if (isComingForSetSchedule) {
      scheduleDate = arguments[Constants.scheduledDate] as String;
      scheduleFrequency = arguments[Constants.scheduledFrequency] as String;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
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
                          Navigator.of(context).pop(false);
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
                  isComingForSetSchedule ? 'Review schedule' : 'Review details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Delivery method',
                  style: AppTextStyles.fourteenRegular,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AssetsConstant.navWalletIcon,height: 38,width: 50,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      mDeliveryType!,
                      style: AppTextStyles.semiBoldSixteen,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showBottomSheetDeliveryMethod();
                        setState(() {});
                      },
                      child: Text(
                        'Change',
                        textAlign: TextAlign.end,
                        style: AppTextStyles.fourteenMediumBlue,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Recipient', style: AppTextStyles.fourteenRegular),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetsConstant.boyImage,height: 58,width: 58,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data!.beneFirstName ?? '',
                      style: AppTextStyles.semiBoldSixteen,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            RouterConstants.selectRecipientToSendMoneyRoute,
                            arguments: {
                              Constants.accountHolderName:
                                  mAccountHolderNameController,
                              Constants.accountNumber: mAccountNumberController,
                              Constants.swiftCode: mSwiftNameController,
                              Constants.accountType: mAccountTypeController,
                              Constants.beneMobileNumber: mobileController.text,
                              Constants.mobileTransferNetworkId: mNetworkID,
                              Constants.mobileTransferNetwork: mNetwork,
                              Constants.deliveryType: mDeliveryType,
                              Constants.bankId: mBankId,
                              Constants.isComingForSetSchedule:
                                  isComingForSetSchedule,
                              Constants.collectionPointId: collectionPointId,
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
                              Constants.isComingFromPaymentReviewPage: true,
                              Constants.isComingFromRecipientPage: isComingFromRecipientPage,
                              Constants.isComingFromRecipientDetailsPage: isComingFromRecipientDetailsPage,

                            });
                      },
                      child: Text(
                        'Change',
                        textAlign: TextAlign.end,
                        style: AppTextStyles.fourteenMediumBlue,
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                if (isComingForSetSchedule)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule transaction',
                        style: AppTextStyles.twentyRegular,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.setScheduleRoute,
                              arguments: {
                                Constants.isComingForSetSchedule: true,
                                Constants.recipientUserDetails:
                                    arguments[Constants.recipientUserDetails]
                                        as Data,
                                Constants.sourceOfIncome:
                                    arguments[Constants.sourceOfIncome]
                                        as String,
                                Constants.purposeOf:
                                    arguments[Constants.purposeOf] as String,
                                Constants.deliveryType:
                                    arguments[Constants.deliveryType] as String?
                              });
                        },
                        child: Text('Change',
                            textAlign: TextAlign.end,
                            style: AppTextStyles.fourteenMediumBlue),
                      ))
                    ],
                  ),
                if (isComingForSetSchedule)
                  const SizedBox(
                    height: 5,
                  ),
                if (isComingForSetSchedule)
                  Divider(
                    color: Colors.grey,
                  ),
                if (isComingForSetSchedule)
                  const SizedBox(
                    height: 10,
                  ),
                if (isComingForSetSchedule)
                  Row(
                    children: [
                      Text(
                        'Started to',
                        style: AppTextStyles.twentyRegular,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                          '' /*double.parse(provider.rate).toStringAsFixed(2)*/,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                      Expanded(
                        child: Text(
                          scheduleDate,
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
                if (isComingForSetSchedule)
                  const SizedBox(
                    height: 10,
                  ),
                if (isComingForSetSchedule)
                  Row(
                    children: [
                      Text(
                        'Repeated',
                        style: AppTextStyles.twentyRegular,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                          '' /*double.parse(provider.rate).toStringAsFixed(2)*/,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                      Expanded(
                        child: Text(
                          scheduleFrequency,
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
                if (isComingForSetSchedule)
                  const SizedBox(
                    height: 10,
                  ),
                if (isComingForSetSchedule)
                  Divider(
                    color: Colors.grey,
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your transaction',
                      style: AppTextStyles.twentyRegular,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouterConstants.sendMoneyPageRoute,
                            arguments: {
                              Constants.isComingForSetSchedule: false,
                              Constants.isComingFromPaymentReviewPage: true,
                              Constants.isComingFromRecipientPage: isComingFromRecipientPage,
                              Constants.isComingFromRecipientDetailsPage: isComingFromRecipientDetailsPage,
                              Constants.recipientUserDetails:data
                            });
                      },
                      child: Text(
                        'Change',
                        textAlign: TextAlign.end,
                        style: AppTextStyles.fourteenMediumBlue,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'You send',
                      style: AppTextStyles.twentyRegular,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text('' /*double.parse(provider.rate).toStringAsFixed(2)*/,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )),
                    Expanded(
                      child: Text(
                        (double.parse(provider.sendAmountController.text) -
                                    double.parse(provider.platformFees!))
                                .toStringAsFixed(2)
                                .toString() +
                            ' GBP',
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
                    Text(
                      'Our fee',
                      style: AppTextStyles.twentyRegular,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SvgPicture.asset(AssetsConstant.icInformation),
                    const SizedBox(
                      width: 12,
                    ),

                    Text('' /*double.parse(provider.rate).toStringAsFixed(2)*/,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )),
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
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Total you pay',
                          style: AppTextStyles.twentyRegular,
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
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
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
                            onPressed: () async {
                              final reqData = {
                                "amount_type": "SOURCE",
                                "beneficiary_id": data!.beneId,
                                "destination_amount": isComingForSetSchedule ==
                                        true
                                    ? double.tryParse(
                                        provider.receiveAmountController.text)
                                    : provider.receiveAmountController.text,
                                "destination_country": data!.benificiaryCountry,
                                //    provider.selectCountryCode,
                                "destination_currency":
                                    provider.destinationCurrency,
                                "payment_type_pi": 'debit-credit-card',
                                //provider.selectPaymentType,
                                "purpose": purposeOf,
                                "service_level": 1,
                                "source_amount": isComingForSetSchedule == true
                                    ? double.tryParse(
                                        provider.sendAmountController.text)
                                    : provider.sendAmountController.text,
                                "source_country": provider.sourceCountry,
                                "source_currency": provider.sourceCurrency,
                                "source_of_income": sourceOfIncome,
                                "transfer_type_po":
                                    getPaymentType(mDeliveryType!),
                                "channel": 'mobile',
                                "scheduled_date": scheduleDate,
                                "frequency": scheduleFrequency,
                                "rate": double.tryParse(provider.convertRate!),
                                "total_fee":
                                    double.tryParse(provider.totalFees!),
                              };
                              // try {

                              if (isComingForSetSchedule) {
                                final res = await provider
                                    .createScheduleTransactionsAPI(
                                        data: reqData);
                                if (res.success! && mounted) {
                                  Navigator.pushNamed(
                                      context, RouterConstants.addMoneyToWallet,
                                      arguments: {
                                        Constants.isComingFromPaymentReviewPage:
                                            true,
                                        Constants.isComingForSetSchedule: false,
                                      });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res.error!.message),
                                  ));
                                }
                              } else {
                                final res = await provider.transactionCreateAPI(
                                    data: reqData);

                                if (res.success ?? false && mounted) {
                                  Navigator.pushNamed(
                                      context, RouterConstants.addMoneyToWallet,
                                      arguments: {
                                        Constants.isComingFromPaymentReviewPage:
                                            true,
                                        Constants.isComingForSetSchedule: false,
                                        Constants.transSessionId: res.response!.data
                                            ?.transactionData?.transSessionId,
                                        Constants.transactionReference: res.response!
                                            .data
                                            ?.transactionData
                                            ?.agentTransactionReferenceNumber,
                                      });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res.error!.message),
                                  ));
                                }
                              }
                              // }
                              /*catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                ));
                              } finally {
                                provider.setLoadingStatus(false);
                              }*/
                            },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                :  Text('Confirm and pay',
                            style: AppTextStyles.enableContinueBtnTxt))),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        }),
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
        /*userSelectedPaymentType = operatorImg!;
        setBankModalState(() {
          _selectedIndexBank = id;
          Navigator.pop(context);
          showBottomSheetBankDetailsFields(selectedDeliveryMethod);
        });*/
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
                                width: 80,
                                child: TextFormField(
                                  enabled: false,
                                  controller: mobileCodeController,
                                  decoration: editTextMobileCodeProperty(
                                      hitText: data!.beneMobileCode!),
                                  style: const TextStyle(fontSize: 16),
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 10,
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
                                          mDeliveryType =
                                              selectedDeliveryMethod;
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    child: const Text("Continue",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600))),
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
                         /*   validator: (value) {
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
                                backgroundColor: Colors.indigoAccent,
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
                                  mDeliveryType = selectedDeliveryMethod;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }
                              },
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Continue",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Inter-SemiBold',
                                          fontWeight: FontWeight.w600))),
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
}

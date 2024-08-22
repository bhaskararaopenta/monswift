import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:nationremit/style/app_font_styles.dart';
import 'package:provider/provider.dart';

import '../common_widget/country_iso.dart';
import '../constants/constants.dart';
import '../model/beneficiary_list_model.dart';
import '../model/transaction_list_model.dart';
import '../style/app_text_styles.dart';

class WalletPageNav extends StatefulWidget {
  const WalletPageNav({super.key});

  @override
  State<WalletPageNav> createState() => _WalletPageNavState();
}

class _WalletPageNavState extends State<WalletPageNav> {
  Timer? _debounce;
  String? userName = '';
  int _selectedIndex = -1;
  bool isComingForSetSchedule = false;

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
      provider.sendAmountController.text = '100';
      provider.receiveAmountController.text = '0';
      //    await provider.getCountryList();
      //    await provider.getCountryDestinationList();
      //    await provider.getPartnerTransactionSettings();

      // _callPartnerRates(amount: '100');
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  bool getUserStatus() {
    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    /* if (loginProvider.userInfo?.userDetails?.kycStatus.toUpperCase() !=
            'KYC-SENT' &&
        loginProvider.userInfo?.userDetails?.amlStatus.toUpperCase() !=
            'AML-SENT') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Go and Complete their profile.'),
      ));

      return false;
    }*/

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      //  isComingForSetSchedule = arguments[Constants.isComingForSetSchedule] as bool;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            var userList = [];

            if (provider.beneficiaryListModel != null && provider.beneficiaryListModel!.response!=null) {
              for (var res in provider.beneficiaryListModel!.response!.data!) {
                //print('transferType======== ${res.transferType}');
                // print('selectPaymentMode======== ${provider.selectPaymentMode}');
                if (provider.selectPaymentMode.toLowerCase() ==
                    res!.transferTypePo!.toLowerCase()) {
                  userList.add(res);
                }
              }
            }

            userList = userList ?? [];
            return Container(
              color: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Wallet',
                    style: AppTextStyles.screenTitle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 145,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20),
                                  bottomStart: Radius.circular(20)),
                              color: const Color.fromRGBO(233, 236, 255, 1.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'GBP balance',
                                style: AppTextStyles.oneGbpText,
                              ),
                              SizedBox(height: 12),
                              if (provider.getWalletModel?.response != null)
                                Text(
                                  provider.getWalletModel?.response!.balance?.toStringAsFixed(2).toString()??'',
                                  style: AppTextStyles.thirtyTwoMedium,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 145,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                            color: const Color.fromRGBO(233, 236, 255, 1.0)),
                        child: SizedBox(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                provider.getCountryFlag(provider.sourceCountry),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        child: GestureDetector(
                          onTap: () {
                            if (getUserStatus()) {
                              Navigator.pushNamed(
                                  context, RouterConstants.addMoneyToWallet,
                                  arguments: {
                                    Constants.isComingFromPaymentReviewPage:
                                        false,
                                    Constants.isComingForSetSchedule:
                                        isComingForSetSchedule
                                  });
                            }
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(AssetsConstant.addIcon),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Add',
                                style: AppTextStyles.oneGbpText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 80,
                        child: GestureDetector(
                          onTap: () {
                            if (getUserStatus()) {
                              Navigator.pushNamed(
                                  context, RouterConstants.sendMoneyPageRoute,
                                  arguments: {
                                    Constants.isComingForSetSchedule: false,
                                    Constants.isComingFromRecipientPage: false,
                                    Constants.isComingFromRecipientDetailsPage: false,
                                    Constants.isComingFromPaymentReviewPage: false,
                                  });
                            }
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(AssetsConstant.arrowUpWordIcon),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Send',
                                style: AppTextStyles.oneGbpText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 80,
                        child: GestureDetector(
                          onTap: () {
                            if (getUserStatus()) {
                              Navigator.pushNamed(
                                context,
                                RouterConstants.walletMorePageRoute,
                              );
                            }
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(AssetsConstant.threeDotIcon),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'More',
                                style: AppTextStyles.oneGbpText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Transactions',
                              style: AppTextStyles.twentySemiBold,
                            ),
                          ),
                          Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (getUserStatus()) {
                                      Navigator.pushNamed(context,
                                          RouterConstants.transitionRoute);
                                    }
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter-Medium',
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.signUpBtnColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  if (provider.transactionList != null)
                    SizedBox(
                      child:  provider.isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          :SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 3; i++)
                              if (provider.transactionList!.response != null &&
                                  provider.transactionList!.response!.length >
                                      0)
                                if (i <
                                    provider.transactionList!.response!.length)
                                  transactionItem(
                                      provider.transactionList!.response![i])
                            /*...?provider.transactionList?.response?.map((e) {
                            return transactionItem(e);
                          })*/
                            ,
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget transactionItem(TransactionModel model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouterConstants.transactionDetailsRoute,
          arguments: {Constants.transRef: model.transSessionId ?? ''},
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            /* Image.asset(
              AssetsConstant.girlImageIcon,
              height: 50,
            ),*/
            if (model.beneficiaryFirstName != null &&
                model.beneficiaryLastName != null &&
                model.destinationCountry != null)
              Stack(children: [
                CircleAvatar(
                  backgroundColor: AppColors.circleGreyColor,
                  radius: 28.0,
                  child: SizedBox(
                      child: Text(
                    getInitials(
                      '${model.beneficiaryFirstName!.trim().toLowerCase().isNotEmpty ? model.beneficiaryFirstName!.trim().toLowerCase().capitalize() : null}'
                      ' ${model.beneficiaryLastName!.trim().toLowerCase().isNotEmpty ? model.beneficiaryLastName!.trim().toLowerCase().capitalize() : null}',
                    ),
                    style: AppTextStyles.letterTitle,
                  )),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      child: SvgPicture.asset(
                        CountryISOMapping().getCountryISOFlag(
                            CountryISOMapping()
                                .getCountryISO2(model.destinationCountry!)),
                        width: 18,
                      ),
                      padding: EdgeInsets.all(0),
                    ))
              ]),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.beneficiaryFirstName != null &&
                      model.beneficiaryFirstName!.isNotEmpty &&
                      model.beneficiaryLastName != null &&
                      model.beneficiaryLastName!.isNotEmpty)
                    Text(
                      '${model.beneficiaryFirstName!.toLowerCase().capitalize()} ${model?.beneficiaryLastName!.toLowerCase().capitalize()}',
                      style: AppTextStyles.semiBoldSixteen,
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Paid | ${model?.dateOnlyFormat()}',
                    style: AppTextStyles.fourteenMediumGrey,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                model.paymentTypePi!.contains('debit-credit-card') && model.transferTypePo!.contains('wallet')?'+ '
                    ''+'${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}'
                    :'- '''+'${model.sourceAmount ?? 0}  ${model.sourceCurrency ?? ''}',
                style: AppTextStyles.fourteenBold,
              ),
            )),
          ]),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    } catch (e) {}
    ;
    return '';
  }
}

String getInitials(String user_name) {
  try {
    return user_name.isNotEmpty
        ? user_name
            .trim()
            .split(' ')
            .map((l) => l[0])
            .take(2)
            .join()
            .toUpperCase()
        : '';
  } catch (e) {}
  return '';
}

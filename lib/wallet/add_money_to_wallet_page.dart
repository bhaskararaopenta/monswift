import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/login/select_payment_mode_page.dart';
import 'package:nationremit/model/Custom_model_local.dart';
import 'package:nationremit/model/Mobile_operator_model.dart';
import 'package:nationremit/model/get_card_model.dart';
import 'package:nationremit/model/wallet_and_card_model.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../constants/common_constants.dart';
import '../model/partner_transaction_settings_model.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  bool isComingFromPaymentReviewPage = false;
  bool isComingForSetSchedule = false;
  String transSessionId = '';
  String transactionReference = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      provider.getWalletAndSavedCards();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isComingFromPaymentReviewPage =
        arguments[Constants.isComingFromPaymentReviewPage] as bool;
    isComingForSetSchedule =
        arguments[Constants.isComingForSetSchedule] as bool;
    if (isComingFromPaymentReviewPage) {
      transSessionId = arguments[Constants.transSessionId] as String;
      transactionReference =
          arguments[Constants.transactionReference] as String;
      print("transa Id if " + transSessionId);
    }
    print("transa Id " + transSessionId);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    height: 15,
                  ),
                  Text(
                    isComingFromPaymentReviewPage
                        ? 'How would you like to pay?'
                        : 'Add Money',
                    style: AppTextStyles.createPinTitle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (!isComingFromPaymentReviewPage)
                    Container(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black12),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller:
                                                provider.sendAmountController,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
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
                                        /*  provider.whichTypeCountryMode =
                                          Constants.showSourceCountry;
                                      Navigator.pushNamed(
                                        context,
                                        RouterConstants.selectCountryRoute,
                                      ).then((value) {
                                        if (value != null) {
                                          provider.sourceCountry =
                                              value as String;
                                        }
                                      });*/
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            provider.getCountryFlag(
                                                provider.sourceCountry),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            " " + provider.sourceCurrency,
                                            style: AppTextStyles
                                                .currencyOnSendMoney,
                                          ),
                                          /* const Icon(
                                            Icons.keyboard_arrow_down_rounded)*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              if (provider.getWalletAndCardModel != null &&
                                  provider.getWalletAndCardModel!.response!
                                      .wallets!.isNotEmpty)
                                Text(
                                  'Available ' +
                                          provider.getWalletAndCardModel!
                                              .response!.wallets![0].balance
                                              .toString() +
                                          ' GBP' ??
                                      '0 GBP',
                                  style: AppTextStyles.instructions,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Saved Cards',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: AppColors.greyColor),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (/*getUserStatus()*/ true) {
                                      Navigator.pushNamed(context,
                                          RouterConstants.addNewCardsRoute);
                                    }
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.textDark),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // if(provider.getWalletAndCardModel!=null && provider.getCardModel?.response!=null)

                  Container(
                    height: 220,
                    child:
                        Consumer<DashBoardProvider>(builder: (_, provider, __) {
                      return ListView.builder(
                        itemCount: provider.getWalletAndCardModel?.response
                                        ?.cards ==
                                    null &&
                                isComingFromPaymentReviewPage &&
                                provider.getWalletAndCardModel?.response?.wallets !=
                                    null &&
                                provider.getWalletAndCardModel!.response!
                                    .wallets!.isNotEmpty
                            ? 1
                            : provider.getWalletAndCardModel?.response?.cards ==
                                    null
                                ? 0
                                : isComingFromPaymentReviewPage &&
                                        provider.getWalletAndCardModel?.response
                                                ?.wallets !=
                                            null &&
                                        provider.getWalletAndCardModel!
                                            .response!.wallets!.isNotEmpty
                                    ? provider.getWalletAndCardModel!.response!
                                            .cards!.length +
                                        1
                                    : provider.getWalletAndCardModel!.response!
                                        .cards!.length,
                        itemBuilder: (context, index) {
                          if (isComingFromPaymentReviewPage &&
                              provider.getWalletAndCardModel?.response
                                      ?.wallets !=
                                  null &&
                              provider.getWalletAndCardModel!.response!.wallets!
                                  .isNotEmpty &&
                              index == 0) {
                            return getWalletWidget(
                                index,
                                AssetsConstant.girlImageIcon,
                                provider.getWalletAndCardModel?.response
                                    ?.wallets?[index]);
                          } else if (isComingFromPaymentReviewPage) {
                            if (provider.getWalletAndCardModel?.response
                                        ?.wallets !=
                                    null &&
                                provider.getWalletAndCardModel!.response!
                                    .wallets!.isEmpty) {
                              return getWidget(
                                  index,
                                  AssetsConstant.girlImageIcon,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index].maskedCardNumber,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index].tpTransactionReference,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index].remitterName,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index].paymentCard);
                            } else {
                              return getWidget(
                                  index - 1,
                                  AssetsConstant.girlImageIcon,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index - 1].maskedCardNumber,
                                  provider
                                      .getWalletAndCardModel
                                      ?.response
                                      ?.cards?[index - 1]
                                      .tpTransactionReference,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index - 1].remitterName,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index - 1].paymentCard);
                            }
                          } else {
                            return getWidget(
                                index,
                                AssetsConstant.girlImageIcon,
                                provider.getWalletAndCardModel?.response
                                    ?.cards?[index].maskedCardNumber,
                                provider.getWalletAndCardModel?.response
                                    ?.cards?[index].tpTransactionReference,
                                provider.getWalletAndCardModel?.response
                                    ?.cards?[index].remitterName,
                                provider.getWalletAndCardModel?.response
                                    ?.cards?[index].paymentCard);
                          }

                          /*return isComingFromPaymentReviewPage && index == 0
                              ? getWalletWidget(
                                  index,
                                  AssetsConstant.girlImageIcon,
                                  provider.getWalletAndCardModel?.response
                                      ?.wallets?[index])
                              : getWidget(
                                  index-1,
                                  AssetsConstant.girlImageIcon,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index-1].maskedCardNumber,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index-1].tpTransactionReference,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index-1].remitterName,
                                  provider.getWalletAndCardModel?.response
                                      ?.cards?[index-1].paymentCard);*/
                        },
                        scrollDirection: Axis.horizontal,
                      );
                    }),
                  ),
                  /* Flexible(
                          child: Container(
                            height: 220,
                            width: 320,
                            child:
                            Consumer<DashBoardProvider>(builder: (_, provider, __) {
                              return ListView.builder(
                                itemCount: provider.getWalletAndCardModel?.response == null
                                    ? 0
                                    : provider.getWalletAndCardModel?.response?.cards?.length,
                                itemBuilder: (context, index) {
                                  return getWidget(
                                      index,
                                      AssetsConstant.girlImageIcon,
                                      provider.getWalletAndCardModel?.response?.cards?[index]
                                          .maskedCardNumber,
                                      provider
                                          .getWalletAndCardModel?.response?.cards?[index].cardExpiry);
                                },
                                scrollDirection: Axis.horizontal,
                              );
                            }),
                          ),
                        ),*/

                  SizedBox(
                    height: 10,
                  ),
                  /*Text(
                    'Other Methods',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),*/
                  /* SizedBox(
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
                          onPressed: provider.isLoading
                              ? null
                              : () {
                                  */ /*Navigator.pushNamed(
                                    context,
                                    RouterConstants
                                        .selectRecipientToSendMoneyRoute,arguments: {
                                      Constants.isComingForSetSchedule:isComingForSetSchedule
                                  }
                                  );*/ /*
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Continue'))),*/
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

  Widget getWidget(int id, String imagePath, String? maskedCardNumber,
      String? tpTransactionReference, String? cardName, String? cardType) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          if (isComingFromPaymentReviewPage) {
            /* Navigator.pushNamed(
              context,
              RouterConstants.successPage,
            );*/
            print("transa Id on tap " + transSessionId);
            Navigator.pushNamed(context, RouterConstants.savedCardPaymentPage,
                arguments: {
                  Constants.maskedCardNumber: maskedCardNumber,
                  Constants.cardExpiry: "cardExpiry",
                  Constants.isComingFromPaymentReviewPage:
                      isComingFromPaymentReviewPage,
                  Constants.isComingForSetSchedule: isComingForSetSchedule,
                  Constants.transSessionId: transSessionId,
                  Constants.transactionReference: tpTransactionReference,
                  Constants.cardName: cardName,
                  Constants.cardType: cardType,
                });
          } else {
            Navigator.pushNamed(context, RouterConstants.savedCardPaymentPage,
                arguments: {
                  Constants.maskedCardNumber: maskedCardNumber,
                  Constants.cardExpiry: "cardExpiry",
                  Constants.isComingFromPaymentReviewPage:
                      isComingFromPaymentReviewPage,
                  Constants.isComingForSetSchedule: isComingForSetSchedule,
                  Constants.transSessionId: transSessionId,
                  Constants.transactionReference: tpTransactionReference,
                  Constants.cardName: cardName,
                  Constants.cardType: cardType,
                });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCreditCard(
                  color: Color(0xFF6E49B2),
                  cardExpiration: /*cardExpiry*/ '' ?? '',
                  cardHolder: "",
                  cardNumber: maskedCardNumber!),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWalletWidget(int id, String imagePath, Wallets? wallet) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          if (isComingFromPaymentReviewPage) {
            Navigator.pushNamed(
              context,
              RouterConstants.successPage,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildWalletCard(
                  color: Color(0xFF691996),
                  cardExpiration: '',
                  cardHolder: "Nation Remit Wallet",
                  cardNumber: ''),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildWalletCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        height: 200,
        width: 280,
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Color.fromRGBO(109, 62, 250, 1.0),
            Color.fromRGBO(255, 255, 255, 0),
            Color.fromRGBO(218, 58, 243, 1.0),
            Color.fromRGBO(253, 249, 255, 1),
            Color.fromRGBO(193, 182, 238, 1.0),
            Color.fromRGBO(147, 13, 253, 0),
            Color.fromRGBO(255, 255, 255, 0)
          ], radius: 5),
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 5),
            _buildWalletLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildWalletDetailsBlock(
                  label: '',
                  value: cardHolder,
                ),
                _buildWalletDetailsBlock(label: '', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildWalletLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SvgPicture.asset(
          "assets/images/ic_contact_less.svg",
          height: 40,
          width: 18,
        )
      ],
    );
  }

  // Build Column containing the cardholder and expiration information
  Column _buildWalletDetailsBlock(
      {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Card _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        height: 200,
        width: 280,
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Color.fromRGBO(110, 73, 178, 1.0),
            Color.fromRGBO(73, 8, 124, 0.0),
            Color.fromRGBO(73, 8, 124, 0.0),
            Color.fromRGBO(73, 8, 124, 0.0),
            Color.fromRGBO(73, 8, 124, 0.0),
            Color.fromRGBO(147, 13, 253, 0),
            Color.fromRGBO(255, 255, 255, 0)
          ], radius: 5),
        ),
        // padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 5),
            Row(
              children: [
                _buildLogosBlock(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: 'Neue Machina',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: AppColors.textDark,
                  //background color of dropdown button
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildDetailsBlock(
                      label: '', value: cardHolder, svg: AssetsConstant.icVisa),
                  _buildDetailsBlock(label: '', value: cardExpiration, svg: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: SvgPicture.asset(
            "assets/images/ic_contact_less.svg",
            height: 40,
            width: 18,
          ),
        )
      ],
    );
  }

  // Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock(
      {required String label, required String value, required String svg}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        if (svg.isEmpty)
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          )
        else
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
            child: SvgPicture.asset(
              AssetsConstant.icVisa,
              height: 40,
              width: 18,
              alignment: Alignment.centerLeft,
            ),
          ),
      ],
    );
  }
}

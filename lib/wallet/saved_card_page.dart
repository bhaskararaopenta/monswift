import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/login/select_payment_mode_page.dart';
import 'package:nationremit/model/Custom_model_local.dart';
import 'package:nationremit/model/Mobile_operator_model.dart';
import 'package:nationremit/model/get_card_model.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../colors/AppColors.dart';
import '../common_widget/common_property.dart';
import '../constants/common_constants.dart';
import '../model/is_success_model.dart';
import '../model/partner_transaction_settings_model.dart';

class SavedCardPage extends StatefulWidget {
  const SavedCardPage({super.key});

  @override
  State<SavedCardPage> createState() => _SavedCardPageState();
}

class _SavedCardPageState extends State<SavedCardPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      provider.getStoredCards();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          return Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                        child: Align(
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 2, 2, 0),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Saved Cards',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Inter-Bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 80), // Add padding to avoid overlap with the button
                      itemCount: provider.getCardModel?.response?.length ?? 0,
                      itemBuilder: (context, index) {
                        return getWidget(
                          index,
                          AssetsConstant.girlImageIcon,
                          provider.getCardModel?.response![index].maskedCardNumber,
                          provider.getCardModel?.response![index].cardExpiry,
                          provider.getCardModel?.response![index].id,
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ],
              ),
              // Fixed button at the bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.resendBtnColor1,
                        textStyle: TextStyle(
                          fontFamily: 'Inter-Bold',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.textDark,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                        ),
                      ),
                      onPressed: provider.isLoading
                          ? null
                          : () {
                        Navigator.pushNamed(context, RouterConstants.addNewCardsRoute);
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                        '+ Add new card',
                        style: TextStyle(
                          fontFamily: 'Inter-Bold',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getWidget(int id, String imagePath, String? maskedCardNumber,
      String? cardExpiry, int? cardId) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCreditCard(
                color: Color(0xFF6E49B2),
                cardExpiration: cardExpiry ?? '',
                cardHolder: "Nation Remit Wallet",
                cardNumber: maskedCardNumber!,
                cardId: cardId),
          ],
        ),
      ),
    );
  }

  Card _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required int? cardId,
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        width: 310,
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
                Expanded(child: _buildDeleteBlock(cardId)),
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
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
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

  GestureDetector _buildDeleteBlock(int? cardId) {
    return GestureDetector(
      onTap: () {
        showBottomSheetRemoveCard(cardId!);
      },
      child: SvgPicture.asset(
        AssetsConstant.icDeleteWhite,
        height: 40,
        width: 18,
        alignment: Alignment.centerRight,
      ),
    );
  }

  // Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock(
      {required String label, required String value, required String svg}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Text(
            '$label',
            style: TextStyle(
                color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
          ),
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

  void showBottomSheetRemoveCard(int cardId) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(15),
          child: SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                  SizedBox(height: 30),
                  SvgPicture.asset(AssetsConstant.icRemoveRecipient),
                  Text(
                    'Are you sure you want to remove the card?',
                    style: AppTextStyles.semiBoldTitleText,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.cancelBtnColor,
                                        textStyle: TextStyle(
                                            fontFamily: 'Inter-Bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: AppColors.textDark),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(65)),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                            25, 10, 25, 10)),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("No",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textDark))),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textDark,
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
                                    onPressed: () async {
                                      {
                                        final provider =
                                            Provider.of<DashBoardProvider>(
                                          context,
                                          listen: false,
                                        );
                                        final req = {
                                          Constants.Id: cardId,
                                        };
                                        IsSuccessModel res = await provider
                                            .savedCardDeleteAPI(data: req);
                                        if (res.success!) {
                                          Fluttertoast.showToast(
                                              msg: res.message!);
                                          setState(() {
                                            provider.getStoredCards();
                                          });
                                          Navigator.of(context).pop(false);
                                        }
                                      }
                                    },
                                    child: const Text("Yes",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

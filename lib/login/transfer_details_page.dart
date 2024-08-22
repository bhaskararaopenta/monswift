import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';

class TransferDetailsPage extends StatefulWidget {
  const TransferDetailsPage({Key? key}) : super(key: key);

  @override
  State<TransferDetailsPage> createState() => _TransferDetailsPageState();
}

class _TransferDetailsPageState extends State<TransferDetailsPage> {
  // Response? dropdownValue;
  DashBoardProvider? _provider;

  //Code? sourceOfIncome;
  String? purposeCodes;
  int? _value = -1;
  String? mDeliveryType = '';
  bool isComingForSetSchedule = false;
  bool isComingFromRecipientDetailsPage=  false;
  bool isComingFromRecipientPage=false;

  @override
  void initState() {
    _provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data? data;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      data = arguments[Constants.recipientUserDetails] as Data;
      mDeliveryType = arguments[Constants.deliveryType] as String?;
      isComingForSetSchedule =
          arguments[Constants.isComingForSetSchedule] as bool;
      isComingFromRecipientPage =
          arguments[Constants.isComingFromRecipientPage] as bool;
      isComingFromRecipientDetailsPage =
          arguments[Constants.isComingFromRecipientDetailsPage] as bool;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Purpose of sending',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.twentySemiBold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
                  return GridView.count(
                      crossAxisCount: 2,
                      primary: false,
                      padding: const EdgeInsets.all(0),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 2.0,
                      childAspectRatio: 3.5,
                      children: List.generate(
                        provider.partnerTransactionSettingsModel!.response!
                            .remittancePurposeCodes!.length,
                        (index) {
                          return getWidget(
                              provider,
                              provider
                                  .partnerTransactionSettingsModel!
                                  .response!
                                  .remittancePurposeCodes![index]
                                  .description!,
                              index);
                        },
                      ));
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purposeCodes !=null && purposeCodes!.isNotEmpty? AppColors.signUpBtnColor
                          : AppColors.outlineBtnColor,
                          textStyle: TextStyle(
                              fontFamily: 'Inter-Bold',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.textWhite),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(65)),
                          ),
                        ),
                        onPressed: () {
                          if (purposeCodes != null && purposeCodes!.isNotEmpty) {
                            if (isComingForSetSchedule) {
                              Navigator.pushNamed(
                                  context, RouterConstants.setScheduleRoute,
                                  arguments: {
                                    Constants.recipientUserDetails: data,
                                    //Constants.sourceOfIncome: sourceOfIncome?.name,
                                    Constants.sourceOfIncome: 'Salary',
                                    Constants.purposeOf: purposeCodes,
                                    Constants.deliveryType: mDeliveryType,
                                    Constants.isComingForSetSchedule :isComingForSetSchedule
                                    //  Constants.purposeOf: purposeCodes?.name
                                  });
                            } else
                              Navigator.pushNamed(
                                  context, RouterConstants.reviewPaymentRoute,
                                  arguments: {
                                    Constants.recipientUserDetails: data,
                                    //Constants.sourceOfIncome: sourceOfIncome?.name,
                                    Constants.sourceOfIncome: 'Salary',
                                    Constants.purposeOf: purposeCodes,
                                    Constants.deliveryType: mDeliveryType,
                                    Constants.isComingForSetSchedule :isComingForSetSchedule,
                                    Constants.isComingFromRecipientDetailsPage :isComingFromRecipientDetailsPage,
                                    Constants.isComingFromRecipientPage :isComingFromRecipientPage
                                  });
                            print('Constants.deliveryType: mDeliveryType ' +
                                mDeliveryType!);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please select transfer details'),
                            ));
                          }
                        },
                        child: Text("Save & Continue",
                        style: purposeCodes !=null && purposeCodes!.isNotEmpty
                            ? AppTextStyles.enableContinueBtnTxt
                            : AppTextStyles.disableContinueBtnTxt)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWidget(DashBoardProvider provider, String purpose, int index) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: ChoiceChip(
        elevation: _value == index ? 10 : 0,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        backgroundColor: Colors.white,
        shadowColor: AppColors.outlineBtnColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: _value == index
                ? AppColors.signUpBtnColor
                : AppColors.outlineBtnColor,
            width: 1.0,
          ),
        ),
        //CircleAvatar
        selected: _value == index,
        label: Text(
          purpose,
          style: AppTextStyles.choiceChip,
        ),
        //Text
        selectedColor: Colors.white,
        selectedShadowColor: AppColors.signUpBtnColor,
        onSelected: (bool selected) {
          setState(() {
            _value = selected ? index : null;
            purposeCodes =selected? purpose:'';
            print(purpose + '----' + purposeCodes!);
          });
        },
      ),
    );
  }
}

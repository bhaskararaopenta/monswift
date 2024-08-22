import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';
import '../webview/bottomsheet_webview_page.dart';

class WalletMorePage extends StatefulWidget {
  const WalletMorePage({Key? key}) : super(key: key);

  @override
  State<WalletMorePage> createState() => _WalletMorePageState();
}

class _WalletMorePageState extends State<WalletMorePage> {
  final documentType = [
    'Please Select',
    'Passport',
    'Driving License',
    'National identity card(with photo)',
    'UK Residence permit'
  ];

  String docType = 'Please Select';

  SourceCurrency? dropdownValue;
  PayoutBank? _payoutBank;
  int timerCount = 30;
  bool isTimerFinished = false;
  late Function sheetSetState;
  late Timer myTimer;
  final ImagePicker _picker = ImagePicker();

  final docExpiryController = TextEditingController();
  final uploadDocumentController = TextEditingController();

  String? base64string;
  String? fileName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      provider.getProfileDetails();
    //  provider.getPayoutsBanksList(countryCode: provider.destinationCountry);
    });
    super.initState();
  }

  Future<void> uploadImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        fileName = pickedFile.name;
        Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
        base64string =
            base64.encode(imageBytes); //convert bytes to base64 string
        setState(() {
          uploadDocumentController.text = fileName!;
        });
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
                return Form(
                  child: Center(
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
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'More',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Inter-Bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: AppColors.textDark),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20),
                                bottomStart: Radius.circular(20),
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AssetsConstant.icAccount),
                              SizedBox(
                                width: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      'Account Information',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textDark,
                                          fontSize: 18,
                                          fontFamily: 'Inter-Medium',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, RouterConstants.accountInformationPageRoute);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                              AssetsConstant.icArrowForward)),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20),
                                bottomStart: Radius.circular(20),
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AssetsConstant.icTransfer),
                              SizedBox(
                                width: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      'Transfer Schedule',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textDark,
                                          fontSize: 18,
                                          fontFamily: 'Inter-Medium',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RouterConstants.scheduleTransactionRoute);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                          AssetsConstant.icArrowForward)),
                                ),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(20),
                                bottomStart: Radius.circular(20),
                                topEnd: Radius.circular(20),
                                bottomEnd: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AssetsConstant.icHelp_),
                              SizedBox(
                                width: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(
                                      'Help',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textDark,
                                          fontSize: 18,
                                          fontFamily: 'Inter-Medium',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RouterConstants.helpFAQRoute);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                          AssetsConstant.icArrowForward)),
                                ),
                              ))
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}


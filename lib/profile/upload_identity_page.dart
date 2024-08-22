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

class UploadIdentityPage extends StatefulWidget {
  const UploadIdentityPage({Key? key}) : super(key: key);

  @override
  State<UploadIdentityPage> createState() => _UploadIdentityPageState();
}

class _UploadIdentityPageState extends State<UploadIdentityPage> {
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
      provider.getPayoutsBanksList(countryCode: provider.destinationCountry);
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
    var email = '';
    var firstName = '';
    var lastName = '';
    var dob = '';
    var mobileNumber = '';

    var userAddress1 = '';
    var userAddress2 = '';
    var town = '';
    var city = '';
    var postalCode = '';

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (arguments[Constants.isComingFromProfilePage] as bool) {
      final provider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
       email = provider.userInfo!.response!.userDetails!.email!;
       firstName =provider.userInfo!.response!.userDetails!.firstName!;;
       lastName =provider.userInfo!.response!.userDetails!.lastName!;;
       dob ='';
       mobileNumber =provider.userInfo!.response!.userDetails!.mobileNumber!;;
       userAddress1 ='';
       userAddress2 ='';
       town ='';
       city ='';
       postalCode ='';
    } else {
      email = arguments[Constants.email] as String;
      firstName = arguments[Constants.userFirstName] as String;
      lastName = arguments[Constants.userLastName] as String;
      dob = arguments[Constants.userDateOfBirth] as String;
      mobileNumber = arguments[Constants.userMobileNumber] as String;

      userAddress1 = arguments[Constants.userAddress1] as String;
      userAddress2 = arguments[Constants.userAddress2] as String;
      town = arguments[Constants.userTown] as String;
      city = arguments[Constants.userCity] as String;
      postalCode = arguments[Constants.usePostalCode] as String;
    }

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
                                  child:
                                      SvgPicture.asset(AssetsConstant.icBack),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(AssetsConstant.icBarSelected),
                                  SizedBox(width: 5),
                                  Image.asset(AssetsConstant.icBarSelected),
                                  SizedBox(width: 5),
                                  Image.asset(AssetsConstant.icBarSelected),
                                  SizedBox(width: 5),
                                  Image.asset(AssetsConstant.icBarSelected),
                                ],
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
                            'Upload a proof of your identity',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Inter-Bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: AppColors.textDark),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Please submit one of the document below.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Inter-Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.greyColor),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(AssetsConstant.icScanner),
                        const SizedBox(
                          height: 20,
                        ),
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
                              color: const Color.fromARGB(255, 243, 245, 248)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(AssetsConstant.icPassport),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Passport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openCameraForPassport(
                                      email,
                                      firstName,
                                      lastName,
                                      dob,
                                      mobileNumber,
                                      userAddress1,
                                      userAddress2,
                                      town,
                                      city,
                                      postalCode,
                                      "PASSPORT");
                                },
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        AssetsConstant.icArrowForward)),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                              color: const Color.fromARGB(255, 243, 245, 248)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(AssetsConstant.icLicence),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Full driving licence',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openCamera(
                                      email,
                                      firstName,
                                      lastName,
                                      dob,
                                      mobileNumber,
                                      userAddress1,
                                      userAddress2,
                                      town,
                                      city,
                                      postalCode,
                                      "DRIVERS_LICENSE");
                                },
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        AssetsConstant.icArrowForward)),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                              color: const Color.fromARGB(255, 243, 245, 248)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(AssetsConstant.icId),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Identity card',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openCamera(
                                      email,
                                      firstName,
                                      lastName,
                                      dob,
                                      mobileNumber,
                                      userAddress1,
                                      userAddress2,
                                      town,
                                      city,
                                      postalCode,
                                      "ID_CARD");
                                },
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        AssetsConstant.icArrowForward)),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                              color: const Color.fromARGB(255, 243, 245, 248)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(AssetsConstant.icUserAccount),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'UK residence permit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openCamera(
                                      email,
                                      firstName,
                                      lastName,
                                      dob,
                                      mobileNumber,
                                      userAddress1,
                                      userAddress2,
                                      town,
                                      city,
                                      postalCode,
                                      "RESIDENCE_PERMIT");
                                },
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        AssetsConstant.icArrowForward)),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: (){
                            showBottomSheetWhyIsThisNeeded();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Why is this needed?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.signUpBtnColor,
                                  fontSize: 16,
                                  fontFamily: 'Inter-SemiBold',
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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

  void openCamera(
      String email,
      String firstName,
      String lastName,
      String dob,
      String mobileNumber,
      String userAddress1,
      String userAddress2,
      String town,
      String city,
      String postalCode,
      String documentType) {
    Navigator.pushNamed(context, RouterConstants.takePicture, arguments: {
      Constants.email: email,
      Constants.userFirstName: firstName,
      Constants.userLastName: lastName,
      Constants.userDateOfBirth: dob,
      Constants.userMobileNumber: mobileNumber,
      Constants.userAddress1: userAddress1,
      Constants.userAddress2: userAddress2,
      Constants.userTown: town,
      Constants.userCity: city,
      Constants.usePostalCode: postalCode,
      Constants.userDocumentType: documentType
    });
  }

  void openCameraForPassport(
      String email,
      String firstName,
      String lastName,
      String dob,
      String mobileNumber,
      String userAddress1,
      String userAddress2,
      String town,
      String city,
      String postalCode,
      String documentType) {
    Navigator.pushNamed(context, RouterConstants.takePictureScreenForPassport, arguments: {
      Constants.email: email,
      Constants.userFirstName: firstName,
      Constants.userLastName: lastName,
      Constants.userDateOfBirth: dob,
      Constants.userMobileNumber: mobileNumber,
      Constants.userAddress1: userAddress1,
      Constants.userAddress2: userAddress2,
      Constants.userTown: town,
      Constants.userCity: city,
      Constants.usePostalCode: postalCode,
      Constants.userDocumentType: documentType
    });
  }

  void showBottomSheetWhyIsThisNeeded() {
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                  SizedBox(height: 30),
                  Image.asset(AssetsConstant.onBoardPage_first_1st_img),
                  SizedBox(height: 30),
                  Text(
                    'Verify your account',
                    style: AppTextStyles.boldBottomTitleText,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Get verified and enjoy access to all features available on Monoswift.',
                      style: AppTextStyles.fourteenRegularNavDisableColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),

          ),
        );
      },
    );
  }
}

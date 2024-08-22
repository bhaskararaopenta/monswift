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
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../model/partner_source_country_model.dart';
import '../router/router.dart';
import '../style/app_text_styles.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final documentType = [
    'Please Select',
    'Passport',
    'Driving License',
    'National identity card(with photo)',
    'UK Residence permit'
  ];

  String docType = 'Please Select';

  SourceCurrency? dropdownValue;
  int timerCount = 60;
  bool isTimerFinished = false;
  late Function sheetSetState;
  late Timer myTimer;
  final ImagePicker _picker = ImagePicker();

  final docExpiryController = TextEditingController();
  final uploadDocumentController = TextEditingController();

  String? base64string;
  String? fileName;
  bool isLogged = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      provider.getProfileDetails();
      // provider.getPayoutsBanksList(countryCode: provider.destinationCountry);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogged = prefs.getBool('isLoggedIn') ?? false;
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
    /*final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final firstName = arguments[Constants.userFirstName] as String;
    final lastName = arguments[Constants.userLastName] as String;
    final dob = arguments[Constants.userDateOfBirth] as String;
    final mobileNumber = arguments[Constants.userMobileNumber] as String;

    final userAddress1 = arguments[Constants.userAddress1] as String;
    final userAddress2 = arguments[Constants.userAddress2] as String;
    final town = arguments[Constants.userTown] as String;
    final city = arguments[Constants.userCity] as String;
    final postalCode = arguments[Constants.usePostalCode] as String;*/

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Your profile',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Inter-Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                  color: AppColors.textDark),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          buildProfileHeader(provider),
                          const SizedBox(
                            height: 20,
                          ),
                          buildFeatureItem(
                            icon: AssetsConstant.icPersonalDetail,
                            title: 'Personal details',
                            subtitle: 'View and edit personal details',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouterConstants.userProfileDetailsRoute,
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          buildFeatureItem(
                            icon: AssetsConstant.icIdVerification,
                            title: 'ID verification',
                            subtitle: 'Status: Not Verified',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouterConstants.uploadProfileIdentity,
                                arguments: {
                                  Constants.isComingFromProfilePage: true,
                                  Constants.isComingFromLoginPinPage: false,
                                },
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          buildFeatureItem(
                            icon: AssetsConstant.icManageCards,
                            title: 'Manage cards',
                            subtitle: 'Add or remove cards',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouterConstants.savedCardRoute,
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          buildFeatureItem(
                            icon: AssetsConstant.icResetPassword,
                            title: 'Reset Password',
                            subtitle: 'Manage your password',
                            onTap: () {
                              showBottomSheetForgetPassword();
                            },
                          ),
                          SizedBox(height: 8),
                          buildFeatureItem(
                            icon: AssetsConstant.icResetPin,
                            title: 'Reset Pin',
                            subtitle: 'Manage your app PIN',
                            onTap: () {
                              final provider = Provider.of<LoginProvider>(
                                context,
                                listen: false,
                              );
                              Navigator.pushNamed(
                                context,
                                RouterConstants.createPinRoute,
                                arguments: {
                                  Constants.email: provider.userInfo!.response?.userDetails!.email!,
                                  Constants.isComingFromProfilePage: true,
                                  Constants.isComingFromLoginPinPage: false,
                                },
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          buildFeatureItem(
                            icon: AssetsConstant.icCloseAccount,
                            title: 'Close Account',
                            subtitle: 'View and edit personal details',
                            onTap: () {
                              showBottomSheetCloseAccount();
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.textDark,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(65)),
                                ),
                              ),
                              onPressed: () {
                                isLogged
                                    ? Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouterConstants.loginRoute,
                                        (route) => false)
                                    : Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouterConstants.loginRoute,
                                        (route) => false);
                              },
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text("    Log out   ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter-SemiBold',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textWhite))),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
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

  Widget buildAppBar(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop(false);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AssetsConstant.icBack),
          ),
        ),
      ],
    );
  }

  Widget buildProfileHeader(DashBoardProvider provider) {
    return Card(
      elevation: 5,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Image.asset(AssetsConstant.icEditProfile),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.profileDetailsModel != null)
                    Text(
                      '${provider.profileDetailsModel!.response[0].firstName} ${provider.profileDetailsModel!.response[0].lastName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter-SemiBold',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  SizedBox(height: 8),
                  if (provider.profileDetailsModel != null)
                    Container(
                      width: 160,
                      child: Text(
                        provider.profileDetailsModel!.response[0].email,
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 16,
                          fontFamily: 'Inter-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  else
                    CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(20),
            bottomStart: Radius.circular(20),
            topEnd: Radius.circular(20),
            bottomEnd: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 18,
                      fontFamily: 'Inter-SemiBold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14,
                      fontFamily: 'Inter-Regular',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(AssetsConstant.icArrowForward),
                ),
              ),

          ],
        ),
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

  Future<void> showBottomSheetForgetPassword() async {
    final _formKey = GlobalKey<FormState>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');
    final emailController = TextEditingController();

    emailController.text = userEmail ?? '';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            margin: EdgeInsets.all(15),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Reset password",
                                style: TextStyle(
                                    fontSize: 29,
                                    fontFamily: 'Inter-Bold',
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textDark),
                                textAlign: TextAlign.start),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Enter registered email address to your profile. We will send a link to setup your password.",
                                style: AppTextStyles.sixteenRegular,
                                textAlign: TextAlign.start),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Inter-Medium',
                                  color: AppColors.textDark),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 48,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              decoration:
                                  editTextProperty(hitText: 'Enter your email'),
                              style: const TextStyle(fontSize: 14),
                              controller: emailController,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Consumer<LoginProvider>(
                                builder: (_, provider, __) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.signUpBtnColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(65)),
                                    ),
                                  ),
                                  onPressed: provider.isLoading
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            try {
                                              final res = await provider
                                                  .forgotPasswordAPI(
                                                email: emailController.text,
                                              );
                                              if (res.success! && mounted) {
                                                Navigator.of(context).pop();
                                                showBottomSheetEmailSent(
                                                    emailController.text);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      res.error?.message ?? ''),
                                                ));
                                              }
                                            } catch (e) {
                                              provider.setLoadingStatus(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(e.toString()),
                                              ));
                                            }
                                          }
                                        },
                                  child: provider.isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text("Continue",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Inter-SemiBold',
                                              fontWeight: FontWeight.w600)));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetEmailSent(String email) {
    final _formKey = GlobalKey<FormState>();
    countDownTimer();
    myTimer = Timer.periodic(Duration(seconds: 15), (timer) async {
      try {
        final provider = Provider.of<LoginProvider>(
          context,
          listen: false,
        );
        var res = await provider.getForgotPasswordStatus(email: email);
        print("In timer call >>" + timer.tick.toString());
        if (res.success!) {
          myTimer.cancel();
          Navigator.of(context).pop();
          showBottomSheetResetPassword(email);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Still not verified "),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    });
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setEmailState) {
          sheetSetState = setEmailState;
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              margin: EdgeInsets.all(15),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Email sent",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontFamily: 'Inter-Bold',
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textDark),
                                  textAlign: TextAlign.start),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  "To reset your password please follow "
                                          "the instructions on the email we sent to " +
                                      email +
                                      ". The link will expire in 15 mins. "
                                          "Check your spam folder if you cannot find it"
                                          " in your inbox.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter-Regular',
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyColor),
                                  textAlign: TextAlign.start),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Consumer<LoginProvider>(
                                  builder: (_, provider, __) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.signUpBtnColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(65)),
                                      ),
                                    ),
                                    onPressed: provider.isLoading
                                        ? null
                                        : () async {
                                            var result =
                                                await OpenMailApp.openMailApp(
                                              nativePickerTitle:
                                                  'Select email app to open',
                                            );

                                            // If no mail apps found, show error
                                            if (!result.didOpen &&
                                                !result.canOpen) {
                                              showNoMailAppsDialog(context);

                                              // iOS: if multiple mail apps found, show dialog to select.
                                              // There is no native intent/default app system in iOS so
                                              // you have to do it yourself.
                                            } else if (!result.didOpen &&
                                                result.canOpen) {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return MailAppPickerDialog(
                                                    mailApps: result.options,
                                                  );
                                                },
                                              );
                                            }
                                            final provider =
                                                Provider.of<LoginProvider>(
                                              context,
                                              listen: false,
                                            );
                                            try {
                                              final res = await provider
                                                  .getForgotPasswordStatus(
                                                      email: email);

                                              if (mounted && res.success!) {
                                                if (myTimer.isActive) {
                                                  myTimer.cancel();
                                                }
                                                Navigator.of(context).pop();
                                                showBottomSheetResetPassword(
                                                    email);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      res.error?.message ?? ''),
                                                ));
                                              }
                                            } catch (e) {
                                              provider.setLoadingStatus(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(e.toString()),
                                              ));
                                            }
                                          },
                                    child: provider.isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text("Check inbox",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Inter-SemiBold',
                                                fontWeight: FontWeight.w600)));
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text("Time remaining: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Inter-Medium',
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.edittextTitle),
                                      textAlign: TextAlign.start),
                                  Text("00:$timerCount ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Inter-Bold',
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textDark),
                                      textAlign: TextAlign.start),
                                  Text("sec",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter-Regular',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.greyColor),
                                      textAlign: TextAlign.start),
                                  Expanded(
                                    child: InkWell(
                                      onTap: timerCount == 0
                                          ? () async {
                                              final provider =
                                                  Provider.of<LoginProvider>(
                                                context,
                                                listen: false,
                                              );
                                              try {
                                                final res = await provider
                                                    .forgotPasswordAPI(
                                                  email: email,
                                                );
                                                if (res.success!) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content:
                                                        Text(res.message ?? ''),
                                                  ));
                                                  sheetSetState(() {
                                                    timerCount = 60;
                                                    countDownTimer();
                                                  });
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        res.error?.message ??
                                                            ''),
                                                  ));
                                                }
                                              } catch (e) {
                                                provider
                                                    .setLoadingStatus(false);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(e.toString()),
                                                ));
                                                /*showBottomSheetEmailSent(
                                                  emailController.text);*/
                                              }
                                            }
                                          : null,
                                      child: Text("Resend Link",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Inter-Regular',
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: timerCount == 0
                                                  ? AppColors.signUpBtnColor
                                                  : AppColors.resendBtnColor),
                                          textAlign: TextAlign.end),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void showBottomSheetResetPassword(String email) {
    final _formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool _showPassword = false;
    bool _showConfirmPassword = false;

    bool _isMinimumEightCharacters = false;
    bool _isOneUpperCase = false;
    bool _isOneLowerCase = false;
    bool _isOneNumericCase = false;
    bool _showError = false;
    bool _showInstructions = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter stateSetter) {
          newPasswordController.addListener(() {
            stateSetter(() {
              _isMinimumEightCharacters = newPasswordController.text.isEmpty
                  ? false
                  : newPasswordController.text.trim().length > 7;

              _isOneLowerCase = newPasswordController.text.isEmpty
                  ? false
                  : newPasswordController.text.containsLowercase;

              _isOneUpperCase = newPasswordController.text.isEmpty
                  ? false
                  : newPasswordController.text.containsUppercase;

              _isOneNumericCase = newPasswordController.text.isEmpty
                  ? false
                  : newPasswordController.text.trim().containsNumber;

              _showInstructions =
                  newPasswordController.text.isEmpty ? false : true;
            });
          });
          confirmPasswordController.addListener(() {
            stateSetter(() {
              _showError = newPasswordController.text.isEmpty
                  ? false
                  : newPasswordController.text.trim() !=
                      confirmPasswordController.text.trim();
            });
          });

          return Container(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Create new password',
                                    style: AppTextStyles.boldTitleText,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'New Password',
                                    style: AppTextStyles.subTitle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 48,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    controller: newPasswordController,
                                    obscureText: _showPassword,
                                    decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      errorStyle:
                                          TextStyle(height: 0.1, fontSize: 10),
                                      errorMaxLines: 2,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            _showPassword
                                                ? AssetsConstant.icVisibilityOn
                                                : AssetsConstant
                                                    .icVisibilityOff,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      isDense: false,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Confirm password',
                                    style: AppTextStyles.subTitle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 48,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    controller: confirmPasswordController,
                                    obscureText: _showConfirmPassword,
                                    decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      errorStyle:
                                          TextStyle(height: 0.1, fontSize: 10),
                                      errorMaxLines: 2,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _showConfirmPassword =
                                                !_showConfirmPassword;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            _showConfirmPassword
                                                ? AssetsConstant.icVisibilityOn
                                                : AssetsConstant
                                                    .icVisibilityOff,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      isDense: false,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 222, 228),
                                            width: 1.0), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                if (_showError)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          " Password did not match",
                                          style: AppTextStyles
                                              .passwordMismatchError,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (_showInstructions)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Your password must have:',
                                              style: AppTextStyles.gbpText,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            _isMinimumEightCharacters
                                                ? Image.asset(
                                                    AssetsConstant.ic_tick)
                                                : Image.asset(
                                                    AssetsConstant.ic_dot),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Minimum 8 characters',
                                              style: _isMinimumEightCharacters
                                                  ? AppTextStyles.greenText
                                                  : AppTextStyles.instructions,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            _isOneUpperCase
                                                ? Image.asset(
                                                    AssetsConstant.ic_tick)
                                                : Image.asset(
                                                    AssetsConstant.ic_dot),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '1 upper case letter (A-Z)',
                                              style: _isOneUpperCase
                                                  ? AppTextStyles.greenText
                                                  : AppTextStyles.instructions,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            _isOneLowerCase
                                                ? Image.asset(
                                                    AssetsConstant.ic_tick)
                                                : Image.asset(
                                                    AssetsConstant.ic_dot),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '1 lower case letter (a-z)',
                                              style: _isOneLowerCase
                                                  ? AppTextStyles.greenText
                                                  : AppTextStyles.instructions,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            _isOneNumericCase
                                                ? Image.asset(
                                                    AssetsConstant.ic_tick)
                                                : Image.asset(
                                                    AssetsConstant.ic_dot),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '1 numeric character (0-9)',
                                              style: _isOneNumericCase
                                                  ? AppTextStyles.greenText
                                                  : AppTextStyles.instructions,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Consumer<LoginProvider>(
                                      builder: (_, provider, __) {
                                    return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.signUpBtnColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(65)),
                                          ),
                                        ),
                                        onPressed: provider.isLoading
                                            ? null
                                            : () async {
                                                if (!_showError &&
                                                    _isMinimumEightCharacters &&
                                                    _isOneUpperCase &&
                                                    _isOneLowerCase &&
                                                    _isOneNumericCase) {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    try {
                                                      final provider = Provider
                                                          .of<LoginProvider>(
                                                        context,
                                                        listen: false,
                                                      );
                                                      await provider.resetPasswordAPI(
                                                          email: email,
                                                          newPassword:
                                                              newPasswordController
                                                                  .text,
                                                          confirmPassword:
                                                              confirmPasswordController
                                                                  .text);
                                                      if (mounted) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.pushNamed(
                                                          context,
                                                          RouterConstants
                                                              .successPagePassword,
                                                        );
                                                      }
                                                    } catch (e) {
                                                      provider.setLoadingStatus(
                                                          false);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content:
                                                            Text(e.toString()),
                                                      ));
                                                    }
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Password did not match'),
                                                  ));
                                                }
                                              },
                                        /* onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouterConstants.successPagePassword,
                                          );
                                        },*/
                                        child: provider.isLoading
                                            ? const CircularProgressIndicator()
                                            : Text("Reset now",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'Inter-SemiBold',
                                                    fontWeight:
                                                        FontWeight.w600)));
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void showBottomSheetCloseAccount() {
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
                  SizedBox(height: 30),
                  Text(
                    'Please be aware that closing your account will mean that you are no longer able to use our service and prevent you from accessing your previous transfer information.',
                    style: AppTextStyles.closeAccountText,
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
                                      Navigator.pushNamedAndRemoveUntil(context, RouterConstants.loginRoute, (route) => false);
                                    },
                                    child: Text("Yes, Close",
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
                                      final provider =
                                          Provider.of<DashBoardProvider>(
                                        context,
                                        listen: false,
                                      );
                                      final req = {
                                        Constants.beneId: '',
                                      };
                                      await provider.beneficiaryDelete(
                                          data: req);
                                      Navigator.of(context)
                                          .pushNamed(
                                              RouterConstants.contactSupportPageRoute,
                                          arguments: {
                                                Constants.email: provider.profileDetailsModel!.response[0].email,
                                          Constants.isComingFromSignUpPage :true
                                              });
                                    },
                                    child: const Text("Contact us",
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

  countDownTimer() async {
    if (timerCount > 0) {
      for (int x = 60; x > 0; x--) {
        await Future.delayed(Duration(seconds: 1)).then((_) {
          if (timerCount == 1) isTimerFinished = true;
          if (mounted) {
            sheetSetState(() {
              if (timerCount > 0) timerCount -= 1;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    if (myTimer.isActive) {
      myTimer.cancel();
    } else {
      try {
        myTimer.cancel();
      } catch (e) {}
    }
    super.dispose();
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Open Mail App"),
        content: Text("No mail apps installed"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));

  bool get containsLowercase => contains(RegExp(r'[a-z]'));

  bool get containsNumber => contains(RegExp(r'[0-9]'));
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../style/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = true;
  int timerCount = 60;
  bool isTimerFinished = false;
  late Function sheetSetState;
  late Timer myTimer;
  bool isEmailEntered = false;
  bool isPasswordEntered = false;
  var name = '';
  late LoginProvider provider;

  @override
  void initState() {
    provider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );
    provider.getUserName().then((String? getName) {
      if (getName != null)
        setState(() {
          name = getName.toString();
        });
    });
    // usernameController.text = 'thiru.258@gmail.com';
    //usernameController.text = 'aiturkey2011@gmail.com';
    //  usernameController.text = 'thiru@ubicomms.com';
    //   passwordController.text = 'Cust@1234';
    /*usernameController.text = 'refausogaza-3142@yopmail.com';
    passwordController.text = 'Cust@123'; */
   // usernameController.text = 'h.omar50@gmail.com';
   // usernameController.text = 'h.omar50+10@gmail.com';
   // passwordController.text = 'Passw0rd';
    /* usernameController.text = 'jitendra@ubicomms.com';
    passwordController.text = 'Jeet@123#';*/
    // usernameController.text= 'aiturkey2011@gmail.com';
    // passwordController.text ='Admin1234';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    passwordController.addListener(() {
      setState(() {
        if (isPasswordEntered) {
          _formKey.currentState?.validate();
        } else {
          isPasswordEntered = true;
        }
      });
    });
    usernameController.addListener(() {
      setState(() {
        if (isEmailEntered) {
          _formKey.currentState?.validate();
        } else {
          isEmailEntered = true;
        }
      });
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  // These values are based on trial & error method
                  alignment: Alignment(-1.05, 1.05),
                  child: InkWell(
                      onTap: () {
                        //Navigator.canPop(context);
                        SystemNavigator.pop();
                      },
                      child: SvgPicture.asset(AssetsConstant.crossIcon)),
                ),
                const SizedBox(
                  height: 24,
                ),
                if (name != null && name.isNotEmpty)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome back ' + name,
                      style: AppTextStyles.screenTitle,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome back ',
                      style: AppTextStyles.screenTitle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Email',
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
                        return 'Please enter username';
                      }
                      return null;
                    },
                    decoration: editTextProperty(hitText: 'Enter'),
                    style: const TextStyle(fontSize: 14),
                    controller: usernameController,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Password',
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
                    controller: passwordController,
                    obscureText: _showPassword,
                    // decoration: editTextProperty(hitText: 'Password'),
                    decoration: InputDecoration(
                      hintText: "Password",
                      errorStyle: TextStyle(height: 0.1, fontSize: 10),
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
                                : AssetsConstant.icVisibilityOff,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isDense: false,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 219, 222, 228),
                            width: 1.0), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 219, 222, 228),
                            width: 1.0), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 219, 222, 228),
                            width: 1.0), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                        onPressed: () {
                          /*Navigator.pushNamed(
                              context, RouterConstants.forgotPasswordRoute);*/
                          showBottomSheetForgetPassword();
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  color: Color.fromRGBO(45, 61, 100, 1),
                                  offset: Offset(0, -4))
                            ],
                            color: Colors.transparent,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromRGBO(45, 61, 100, 1),
                            decorationThickness: 1,
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:
                          Consumer<LoginProvider>(builder: (_, provider, __) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  passwordController.text.isNotEmpty &&
                                          usernameController.text.isNotEmpty
                                      ? AppColors.signUpBtnColor
                                      : AppColors.outlineBtnColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            onPressed: provider.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        final provider =
                                            Provider.of<LoginProvider>(
                                          context,
                                          listen: false,
                                        );
                                        final res = await provider.loginAPI(
                                          password: passwordController.text
                                              .toString()
                                              .trim(),
                                          email: usernameController.text
                                              .toString()
                                              .trim(),
                                        );

                                        if (mounted && res.success!) {
                                          if (res.response?.userDetails
                                                      ?.kycStatus!
                                                      .toUpperCase() !=
                                                  'KYC-OK' &&
                                              res.response?.userDetails
                                                      ?.amlStatus!
                                                      .toUpperCase() !=
                                                  'AML-OK') {
                                            /* Fluttertoast.showToast(
                                          msg:
                                          'Go and Complete their profile.')*/
                                            ;
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(const SnackBar(
                                            //   content: Text('Go and Complete their profile.'),
                                            // ));
                                          }
                                          if (res.response != null &&
                                              !res.response!.userDetails!
                                                  .isProfileUpdated!) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    RouterConstants
                                                        .createPinRoute,
                                                    (Route<dynamic> route) =>
                                                        false,
                                                    arguments: {
                                                  Constants.email:
                                                      usernameController.text,
                                                  Constants
                                                          .isComingFromProfilePage:
                                                      false,
                                                  Constants
                                                          .isComingFromLoginPinPage:
                                                      false,
                                                });
                                          } else {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    RouterConstants
                                                        .dashboardRoute,
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(res.error!.message!),
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
                                : Text(
                                    "Login",
                                    style: passwordController.text.isNotEmpty &&
                                            usernameController.text.isNotEmpty
                                        ? AppTextStyles.enableContinueBtnTxt
                                        : AppTextStyles.disableContinueBtnTxt,
                                  ));
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: AppTextStyles.subtitleText,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.signupRoute);
                        },
                        child: Text(
                          ' Signup',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Color.fromARGB(255, 3, 15, 41),
                                    offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 3, 15, 41),
                              decorationThickness: 1,
                              fontSize: 16,
                              fontFamily: 'Inter-Regular',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheetForgetPassword() async {
    final _formKey = GlobalKey<FormState>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                                              /*showBottomSheetEmailSent(
                                                  emailController.text);*/
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
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                                    /*  onPressed: () {
                                      Navigator.of(context).pop();
                                      showBottomSheetResetPassword(email);
                                    },*/
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

  countDownTimer() async {
    if (timerCount > 0) {
      for (int x = 60; x > 0; x--) {
        await Future.delayed(Duration(seconds: 1)).then((_) {
          if (timerCount == 1) isTimerFinished = true;
          sheetSetState(() {
            if (timerCount > 0) timerCount -= 1;
          });
        });
      }
    }
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

Future<String> getUserName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('userName');
  return name ?? '';
}

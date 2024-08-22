import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/app_text_styles.dart';

class LoginWithPinPage extends StatefulWidget {
  const LoginWithPinPage({Key? key}) : super(key: key);

  @override
  State<LoginWithPinPage> createState() => _LoginWithPinPageState();
}

class _LoginWithPinPageState extends State<LoginWithPinPage> {
  String enteredPin = '';
  bool isPinVisible = false;
  int timerCount = 60;
  bool isTimerFinished = false;
  late Function sheetSetState;
  late Timer myTimer;
  var name = '';
  late LoginProvider provider;

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();
            }
            if (enteredPin.length == 4) {
              confirmPin();
            }
          });
        },
        child: Text(
          number.toString(),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.textDark,
              fontFamily: 'Inter-Regular'),
        ),
      ),
    );
  }

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

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    try {
      if (myTimer.isActive) {
        myTimer.cancel();
      }
    } catch (e) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
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
                          child: SvgPicture.asset(AssetsConstant.crossIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (name != null && name.isNotEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome back ' + name,
                      style: AppTextStyles.createPinTitle,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome back ',
                      style: AppTextStyles.createPinTitle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                if (!provider.isLoading)
                  const SizedBox(
                    height: 5,
                  ),
                if (provider.isLoading)
                  Center(child: CircularProgressIndicator()),

                /// pin code area
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 50, 24, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.all(12.0),
                          width: isPinVisible ? 50 : 18,
                          height: isPinVisible ? 50 : 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: index < enteredPin.length
                                ? isPinVisible
                                    ? Colors.green
                                    : AppColors.textDark
                                : AppColors.textDark.withOpacity(0.1),
                          ),
                          child: isPinVisible && index < enteredPin.length
                              ? Center(
                                  child: Text(
                                    enteredPin[index],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ),

                /// visiblity toggle button
                /* IconButton(
                  onPressed: () {
                    setState(() {
                      isPinVisible = !isPinVisible;
                    });
                  },
                  icon: Icon(
                    isPinVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),

                SizedBox(height: isPinVisible ? 50.0 : 8.0),*/

                /// digits
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => numButton(1 + 3 * i + index),
                      ).toList(),
                    ),
                  ),

                /// 0 digit with back remove
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              if (enteredPin.isNotEmpty) {
                                enteredPin = enteredPin.substring(
                                    0, enteredPin.length - 1);
                              }
                            },
                          );
                        },
                        child: Image.asset(AssetsConstant.ic_eraser),
                      ),
                      numButton(0),
                      TextButton(
                        onPressed: () async {
                          /*Navigator.pushNamed(
                              context, RouterConstants.loginRoute,
                              arguments: {
                                Constants.userPin: enteredPin,
                              });*/

                          final provider = Provider.of<LoginProvider>(
                            context,
                            listen: false,
                          );
                          setState(() {
                            provider.setLoadingStatus(true);
                          });
                          try {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? userEmail = prefs.getString('userEmail');
                            final res = await provider.userLoginWithPinAPI(
                              pin: enteredPin,
                              email: userEmail!,
                            );

                            if (mounted && res.success!) {
                              if (res.response?.userDetails?.kycStatus!
                                          .toUpperCase() !=
                                      'KYC-OK' &&
                                  res.response?.userDetails?.amlStatus!
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
                              setState(() {
                                provider.setLoadingStatus(false);
                              });
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.dashboardRoute,
                                  (Route<dynamic> route) => false);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(res.error!.message!),
                              ));
                              setState(() {
                                provider.setLoadingStatus(false);
                                enteredPin = '';
                              });
                            }
                          } catch (e) {
                            setState(() {
                              provider.setLoadingStatus(false);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        },
                        child: Image.asset(AssetsConstant.ic_check),
                      ),
                    ],
                  ),
                ),

                /// reset button
                /*TextButton(
                  onPressed: () {
                    setState(() {
                      enteredPin = '';
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                )*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheetCloseAccount();
                        },
                        child: Text(
                          'Forget PIN?',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: AppColors.edittextTitle,
                                    offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.edittextTitle,
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

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
            height: 250,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  SvgPicture.asset(AssetsConstant.ic_bar, height: 5),
                  SizedBox(height: 30),
                  Text(
                    'Reset PIN or login with password',
                    style: AppTextStyles.screenTitle,
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
                                            AppColors.signUpBtnColor,
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
                                      Navigator.pop(context);
                                      showBottomSheetResetPin();
                                    },
                                    child: Text("Reset PIN",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textWhite))),
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
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushNamed(
                                          RouterConstants.loginRoute);
                                    },
                                    child: Text("Login",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Inter-SemiBold',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textWhite))),
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

  Future<void> showBottomSheetResetPin() async {
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
                            child: Text("Reset pin",
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
                                "Enter registered email address to your profile. We will send a link to setup your pin.",
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
      // try {
      final provider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      var res = await provider.getForgotPasswordStatus(email: email);
      print("In timer call >>" + timer.tick.toString());
      if (res.success!) {
        if (myTimer.isActive) {
          myTimer.cancel();
        }
        Navigator.of(context).pop();
        final provider = Provider.of<LoginProvider>(
          context,
          listen: false,
        );
        Navigator.pushNamed(context, RouterConstants.createPinRoute,
            arguments: {
              Constants.email: email,
              Constants.isComingFromProfilePage: false,
              Constants.isComingFromLoginPinPage: true,
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Still not verified "),
        ));
      }
      /* } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }*/
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
                                  "To reset your PIN please follow "
                                          "the instructions on the email we sent to " +
                                      email +
                                      ". The link will expire in 15 min. "
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
                                                //Navigator.of(context).pop();
                                                Navigator.pushNamed(
                                                    context,
                                                    RouterConstants
                                                        .createPinRoute,
                                                    arguments: {
                                                      Constants.email: email,
                                                      Constants
                                                              .isComingFromProfilePage:
                                                          false,
                                                      Constants
                                                              .isComingFromLoginPinPage:
                                                          true,
                                                    });
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
                                      onTap: timerCount==0?() async {
                                        final provider =
                                            Provider.of<LoginProvider>(
                                          context,
                                          listen: false,
                                        );
                                        try {
                                          final res =
                                              await provider.forgotPasswordAPI(
                                            email: email,
                                          );
                                          if (res.success! && mounted) {
                                            sheetSetState(() {
                                              timerCount =60;
                                              countDownTimer();
                                            });
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
                                      }:null,
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



  countDownTimer() async {
    if (timerCount > 0) {
      for (int x = 30; x > 0; x--) {
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

  Future<void> confirmPin() async {
    final provider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );
    setState(() {
      provider.setLoadingStatus(true);
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');
      final res = await provider.userLoginWithPinAPI(
        pin: enteredPin,
        email: userEmail!,
      );

      if (mounted && res.success!) {
        if (res.response?.userDetails?.kycStatus!.toUpperCase() != 'KYC-OK' &&
            res.response?.userDetails?.amlStatus!.toUpperCase() != 'AML-OK') {
          /* Fluttertoast.showToast(
                                            msg:
                                            'Go and Complete their profile.')*/
          ;
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(
          //   content: Text('Go and Complete their profile.'),
          // ));
        }
        setState(() {
          provider.setLoadingStatus(false);
        });
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouterConstants.dashboardRoute, (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res.error!.message!),
        ));
        setState(() {
          provider.setLoadingStatus(false);
          enteredPin = '';
        });
      }
    } catch (e) {
      setState(() {
        provider.setLoadingStatus(false);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}

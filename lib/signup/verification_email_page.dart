import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common_widget/common_property_pin.dart';
import '../common_widget/time_service.dart';
import '../model/is_success_model.dart';
import '../provider/dashboard_provider.dart';
import '../style/app_text_styles.dart';

class VerificationMailPage extends StatefulWidget {
  const VerificationMailPage({Key? key}) : super(key: key);

  @override
  State<VerificationMailPage> createState() => _VerificationMailPageState();
}

class _VerificationMailPageState extends State<VerificationMailPage> {
  int timerCount = 60;
  bool isTimerFinished = false;
  late Timer myTimer;

  @override
  void initState() {
    countDownTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      myTimer = Timer.periodic(Duration(seconds: 15), (timer) async {
        try {
          final provider = Provider.of<LoginProvider>(
            context,
            listen: false,
          );
          var res = await provider.getSignUpStatus(
              email: provider.userInfo!.response!.userDetails!.email!);
          print("In timer call >>" + timer.tick.toString());
          if (res.success!) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                RouterConstants.loginRouteAfterSignUP,
                (Route<dynamic> route) => false);
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
    });

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
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
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AssetsConstant.icBarSelected),
                          SizedBox(width: 5),
                          Image.asset(AssetsConstant.icUnBarSelected),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height:30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(AssetsConstant.icVerifyMail),
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Verify your email",
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
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("Click on the link we sent to",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter-Regular',
                              fontWeight: FontWeight.w400,
                              color: AppColors.edittextTitle),
                          textAlign: TextAlign.center),
                      Text("$email",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter-SemiBold',
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark),
                          textAlign: TextAlign.center),
                      Text(
                          "to confirm your email. The link will\n expire in 15 mins.",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter-Regular',
                              fontWeight: FontWeight.w400,
                              color: AppColors.edittextTitle),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Consumer<LoginProvider>(builder: (_, provider, __) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.signUpBtnColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(65)),
                          ),
                        ),
                        onPressed: () async {
                          var result = await OpenMailApp.openMailApp(
                            nativePickerTitle: 'Select email app to open',
                          );

                          // If no mail apps found, show error
                          if (!result.didOpen && !result.canOpen) {
                            showNoMailAppsDialog(context);

                            // iOS: if multiple mail apps found, show dialog to select.
                            // There is no native intent/default app system in iOS so
                            // you have to do it yourself.
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return MailAppPickerDialog(
                                  mailApps: result.options,
                                );
                              },
                            );
                          }
                         /* try {
                            final provider = Provider.of<LoginProvider>(
                              context,
                              listen: false,
                            );
                            final res =
                                await provider.getSignUpStatus(email: email);

                            if (mounted && res.success!) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.loginRouteAfterSignUP,
                                  (Route<dynamic> route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Still not verified "),
                              ));
                            }
                          } catch (e) {
                            provider.setLoadingStatus(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }*/
                          /*Navigator.pushNamed(
                            context,
                            RouterConstants.loginRouteAfterSignUP,
                          );*/
                        },
                        child: provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Open mail",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.w600)));
                  }),
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text("Time remaining: ",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter-Medium',
                              fontWeight: FontWeight.w400,
                              color: AppColors.edittextTitle),
                          textAlign: TextAlign.start),
                      Text("00:$timerCount ",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter-SemiBold',
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
                            final provider = Provider.of<DashBoardProvider>(
                              context,
                              listen: false,
                            );
                            final req = {
                              Constants.email: email,
                            };
                            IsSuccessModel res = await provider.sendVerificationEmail(data: req);
                            if (res.success!) {
                              Fluttertoast.showToast(
                                  msg:
                                  res.message!);
                              setState(() {
                                timerCount =60;
                                countDownTimer();
                              });
                            }
                          }:null,
                          child: Text("Resend Link",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w400,
                                  decoration:
                                  TextDecoration.underline,
                                  color:timerCount==0?AppColors.signUpBtnColor: AppColors.resendBtnColor),
                              textAlign: TextAlign.end),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Wrong email?",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter-Medium',
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                            textAlign: TextAlign.center),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 10, 10, 0),
                            child: Text(" Change email",
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                          color: AppColors.signUpBtnColor,
                                          offset: Offset(0, -5))
                                    ],
                                    color: Colors.transparent,
                                    decoration:
                                    TextDecoration.underline,
                                    decorationColor: AppColors.signUpBtnColor,
                                    decorationThickness: 1,
                                    fontSize: 16,
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetResetEmail(String email) {
    final _formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
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
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Current Email',
                                style: AppTextStyles.gbpText,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter your email'),
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
                              child: Text(
                                'New Email',
                                style: AppTextStyles.gbpText,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter your email'),
                                style: const TextStyle(fontSize: 14),
                                controller: emailController,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(AssetsConstant.ic_tick),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Minimum 8 characters',
                                        style: AppTextStyles.greenText,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(AssetsConstant.ic_dot),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '1 upper case letter (A-Z)',
                                        style: AppTextStyles.instructions,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(AssetsConstant.ic_dot),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '1 lower case letter (a-z)',
                                        style: AppTextStyles.instructions,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(AssetsConstant.ic_dot),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '1 numeric character (0-9)',
                                        style: AppTextStyles.instructions,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
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
                                      backgroundColor: AppColors.signUpBtnColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(65)),
                                      ),
                                    ),
                                    /* onPressed: provider.isLoading
                                            ? null
                                            : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            try {
                                              final provider =
                                              Provider.of<LoginProvider>(
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
                                                Navigator.of(context).pop();
                                                Navigator.pushNamed(
                                                  context,
                                                  RouterConstants
                                                      .successPagePassword,
                                                );
                                              }
                                            } catch (e) {
                                              provider.setLoadingStatus(false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(e.toString()),
                                              ));
                                            }
                                          }
                                        },*/
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouterConstants.successPagePassword,
                                      );
                                    },
                                    child: provider.isLoading
                                        ? const CircularProgressIndicator()
                                        : Text("Reset now",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Inter-SemiBold',
                                                fontWeight: FontWeight.w600)));
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
        );
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
    if(timerCount>0){
      for (int x = 60; x > 0; x--) {
        await Future.delayed(Duration(seconds: 1)).then((_) {
          if (timerCount == 1) isTimerFinished = true;
          setState(() {
            if(timerCount>0)
            timerCount -= 1;
          });
        });
      }
    }
  }
}

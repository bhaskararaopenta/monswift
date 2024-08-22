import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({Key? key}) : super(key: key);

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  DashBoardProvider? provider;

  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Consumer<LoginProvider>(builder: (_, provider, __) {
              return Column(
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
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                            'Account Information ',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.screenTitle,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                        Column(
                          children: [
                            SizedBox(height: 5),
                            SvgPicture.asset(
                                AssetsConstant.icMail),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Email Address',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                provider.userInfo!.response!.userDetails!.email!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                        Column(
                          children: [
                            SizedBox(height: 5),
                            SvgPicture.asset(
                                AssetsConstant.icPhone),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Mobile Number',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                  provider.userInfo!.response!.userDetails!.mobileNumber!??'',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 16,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
  bool isSwitched = true;
  var textValue = 'ON';
  bool isSwitchedMail = true;
  var textValueMail = 'ON';
  bool isSwitchedPushNotification = true;
  var textValuePushNotification = 'ON';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'OFF';
      });
    }
  }
  void toggleSwitchEmail(bool value) {
    if (isSwitchedMail == false) {
      setState(() {
        isSwitchedMail = true;
        textValueMail = 'ON';
      });
    } else {
      setState(() {
        isSwitchedMail = false;
        textValueMail = 'OFF';
      });
    }
  }
  void toggleSwitchPushNotification(bool value) {
    if (isSwitchedPushNotification == false) {
      setState(() {
        isSwitchedPushNotification = true;
        textValuePushNotification = 'ON';
      });
    } else {
      setState(() {
        isSwitchedPushNotification = false;
        textValuePushNotification = 'OFF';
      });
    }
  }
}

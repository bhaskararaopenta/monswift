import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({Key? key}) : super(key: key);

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
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
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
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
                            'Notifications ',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.screenTitle,
                          ),
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Status',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  textValue,
                                  style: AppTextStyles.sixteenRegularDark,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 60,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch.adaptive(
                                      splashRadius: 50,
                                      onChanged: toggleSwitch,
                                      value: isSwitched,
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.blueAccent,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Allow notifications ',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.twentySemiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                height: 15,
                              ),
                              Text(
                                'Email',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  textValueMail,
                                  style: AppTextStyles.sixteenRegularDark,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 60,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch.adaptive(
                                      splashRadius: 50,
                                      onChanged: toggleSwitchEmail,
                                      value: isSwitchedMail,
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.blueAccent,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                AssetsConstant.icPushNoti),
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
                                height: 15,
                              ),
                              Text(
                                'Push',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 18,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  textValuePushNotification,
                                  style: AppTextStyles.sixteenRegularDark,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 60,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch.adaptive(
                                      splashRadius: 50,
                                      onChanged: toggleSwitchPushNotification,
                                      value: isSwitchedPushNotification,
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.blueAccent,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

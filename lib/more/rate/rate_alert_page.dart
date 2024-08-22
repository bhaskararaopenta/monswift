import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class RateAlertPage extends StatefulWidget {
  const RateAlertPage({Key? key}) : super(key: key);

  @override
  State<RateAlertPage> createState() => _RateAlertPageState();
}

class _RateAlertPageState extends State<RateAlertPage> {
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
                        'Set rate alert ',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.screenTitle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  SizedBox(
                    height: 20,
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
                          'Inform me when the rate is',
                          textAlign: TextAlign.start,
                          style: AppTextStyles.closeAccountText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 120,
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                              bottomEnd: Radius.circular(10),
                            ),
                            color: const Color.fromRGBO(233, 236, 255, 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              style: AppTextStyles.sixteenRegular,
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Image.asset(
                              provider.getCountryFlag(provider.sourceCountry),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'GBP',
                              style: AppTextStyles.sixteenRegular,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 48,
                        width: 200,
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                              bottomEnd: Radius.circular(10),
                            ),
                            border: Border.fromBorderSide(BorderSide(color: AppColors.outlineBtnColor)),
                            color: const Color.fromRGBO(251, 251, 254, 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1.274',
                              style: AppTextStyles.sixteenRegular,
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Image.asset(
                              provider.getCountryFlag(provider.sourceCountry),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'USD',
                              style: AppTextStyles.sixteenRegular,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AssetsConstant.icArrowUp),
                                SizedBox(height: 5,),
                                SvgPicture.asset(AssetsConstant.icArrowDown),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(AssetsConstant.icCircleMinus,width: 29,height: 29,),
                    ],
                  ),
                ],
              );
            }),
          ),

        ),

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50.0,5,5,5),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor:  AppColors.signUpBtnColor,
            onPressed: (){

            },
            label:  Text(' Add New ',style: AppTextStyles.fourteenMediumWhite),
            icon: const Icon(Icons.add, color: Colors.white, size: 25),
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

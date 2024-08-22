import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                    height: 90,
                  ),

                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No notifications found',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.fourteenMediumGrey,
                      ),
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

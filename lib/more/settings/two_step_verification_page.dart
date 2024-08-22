import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class TwoStepVerificationPage extends StatefulWidget {
  const TwoStepVerificationPage({Key? key}) : super(key: key);

  @override
  State<TwoStepVerificationPage> createState() =>
      _TwoStepVerificationPageState();
}

class _TwoStepVerificationPageState extends State<TwoStepVerificationPage> {
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
                        'Two step verification',
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
                    height: 8,
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
}

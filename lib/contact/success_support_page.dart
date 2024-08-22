import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/common_constants.dart';
import '../constants/constants.dart';

class SupportEmailSuccessPage extends StatefulWidget {
  const SupportEmailSuccessPage({Key? key}) : super(key: key);

  @override
  State<SupportEmailSuccessPage> createState() =>
      _SupportEmailSuccessPageState();
}

class _SupportEmailSuccessPageState extends State<SupportEmailSuccessPage> {
  String? userName;
  var isComingFromSignUpPage=false;
  @override
  void initState() {
    getName();
    super.initState();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();

    userName = prefs.getString('userName');
  }

  @override
  Widget build(BuildContext context) {
    //  final arguments =
    //   ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //  Data data = arguments[Constants.recipientUserDetails] as Data;
    //   String? sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
    //   String? purposeOf = arguments[Constants.purposeOf] as String;
    final arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = arguments[Constants.userFirstName] as String;
    isComingFromSignUpPage = arguments[Constants.isComingFromSignUpPage] as bool;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(AssetsConstant.icSpeechBubble),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                      child: SvgPicture.asset(AssetsConstant.icClockGrp,),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.locationPin,
                        // ),

                        Text(
                            "Thank you " +
                                name,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter-Bold',
                                color: AppColors.textDark),
                            textAlign: TextAlign.center),

                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Customer Support will respond shortly to your registered email address.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter-Regular',
                                color: AppColors.feeColorText),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                        Consumer<DashBoardProvider>(builder: (_, provider, __) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cancelBtnColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: () {
                            if(isComingFromSignUpPage){
                              Navigator.popUntil(context, ModalRoute.withName(RouterConstants.takePicture));
                            }
                            else {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouterConstants
                                      .dashboardRoute,
                                      (Route<dynamic> route) =>
                                  false
                              );
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : Text("Close",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter-SemiBold',
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textDark)));
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

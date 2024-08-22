import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ProfileDetailsSuccessPage extends StatefulWidget {
  const ProfileDetailsSuccessPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsSuccessPage> createState() =>
      _ProfileDetailsSuccessPageState();
}

class _ProfileDetailsSuccessPageState extends State<ProfileDetailsSuccessPage> {
  String? userName;

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
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SvgPicture.asset('assets/images/ic_success.svg'),
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
                                name +
                                " for registering with Monoswfit.",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter-Bold',
                                color: AppColors.textDark),
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
                            backgroundColor: AppColors.signUpBtnColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                                RouterConstants
                                    .dashboardRoute,
                                    (Route<dynamic> route) =>
                                false
                            );
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : Text("Explore home",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter-SemiBold',
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textWhite)));
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

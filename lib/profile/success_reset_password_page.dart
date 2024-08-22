import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/colors/AppColors.dart';
import 'package:nationremit/style/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

class ResetPasswordSuccessPage extends StatefulWidget {
  const ResetPasswordSuccessPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordSuccessPage> createState() => _ResetPasswordSuccessPageState();
}

class _ResetPasswordSuccessPageState extends State<ResetPasswordSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final arguments =
    //   ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //  Data data = arguments[Constants.recipientUserDetails] as Data;
    //   String? sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
    //   String? purposeOf = arguments[Constants.purposeOf] as String;

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
                    SvgPicture.asset('assets/images/ic_success_reset_password.svg'),
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

                        Text("You have successfully reset your password",
                            style: TextStyle(
                                fontSize: 36,
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
                            backgroundColor: Color.fromARGB(255, 243, 245, 248),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouterConstants.loginRoute,
                            );
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              :  Text("Close",
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

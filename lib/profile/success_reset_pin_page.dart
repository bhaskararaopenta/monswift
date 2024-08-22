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

class SuccessResetPinPage extends StatefulWidget {
  const SuccessResetPinPage({Key? key}) : super(key: key);

  @override
  State<SuccessResetPinPage> createState() => _SuccessResetPinPageState();
}

class _SuccessResetPinPageState extends State<SuccessResetPinPage> {
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
    final arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isFromProfilePage =
    arguments[Constants.isComingFromProfilePage] as bool;
    final isFromLoginPinPage =
    arguments[Constants.isComingFromLoginPinPage] as bool;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*Row(
                children: [
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(-1.05, 1.05),
                    child: InkWell(
                      onTap: () {
                        if (isFromLoginPinPage)
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouterConstants.loginWithPinRoute,
                                  (route) => false);
                        else
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterConstants.profileRoute, (Route<dynamic> route) => false);
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
              ),*/
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SvgPicture.asset('assets/images/ic_success_reset_password.svg'),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.locationPin,
                        // ),

                        Text(
                          //data.beneCity ?? '',
                          'PIN reset is successfully done',
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter-Bold'),
                          textAlign:TextAlign.center,
                        ),
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
                            if(isFromLoginPinPage) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.loginWithPinRoute, (
                                  Route<dynamic> route) => false);
                            }else{
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterConstants.profileRoute, (Route<dynamic> route) => false);
                            }
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../common_widget/country_iso.dart';
import '../../constants/common_constants.dart';
import '../../router/router.dart';
import '../../style/app_text_styles.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
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
                            'Currency',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.screenTitle,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.radio_button_checked_outlined,
                                  color: AppColors.signUpBtnColor,
                                )),
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
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'GBP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.textDark,
                                        fontSize: 18,
                                        fontFamily: 'Inter-Medium',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'British Pound',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 14,
                                        fontFamily: 'Inter-Regular',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SvgPicture.asset(
                                  CountryISOMapping().getCountryISOFlag('GB'),
                                  width: 24,
                                ),
                              ),
                            ],
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
}

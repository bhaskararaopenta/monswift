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

class SuccessDetailsPage extends StatefulWidget {
  const SuccessDetailsPage({Key? key}) : super(key: key);

  @override
  State<SuccessDetailsPage> createState() => _SuccessDetailsPageState();
}

class _SuccessDetailsPageState extends State<SuccessDetailsPage> {
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
              Row(
                children: [
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(-1.05, 1.05),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouterConstants.dashboardRoute,arguments: {
                          Constants
                              .dashboardPageOpen: 1
                        }, (Route<dynamic> route) => false);
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
                          //data.beneCity ?? '',
                          '     Payment \n   Successful ',
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter-Bold'),
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
                            backgroundColor: Colors.indigoAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(65)),
                            ),
                          ),
                          /* onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        final reqData = {
                                          "amount_type": "SOURCE",
                                          "beneficiary_id": data.beneId,
                                          "compliance_checked": false,
                                          "compliance_needed": false,
                                          "destination_account": "",
                                          "destination_amount":
                                              provider.receiveAmountController.text,
                                          "destination_country":
                                              provider.destinationCurrency,
                                          "destination_currency":
                                              provider.destinationCountry,
                                          "ext_compliance_checked": false,
                                          "ext_compliance_needed": false,
                                          "payer_name ": "",
                                          "payment_token": "",
                                          "payment_type_pi":
                                              provider.selectPaymentType,
                                          "promotion_code": "",
                                          "purpose": purposeOf,
                                          "remitter_wallet_currency": "",
                                          "service_level": 1,
                                          "sms_benef_confirmation": false,
                                          "sms_confirmation": false,
                                          "sms_mobile": "",
                                          "sms_notification": false,
                                          "source_amount":
                                              provider.sendAmountController.text,
                                          "source_country": provider.sourceCurrency,
                                          "source_currency": provider.sourceCountry,
                                          "source_of_income": sourceOfIncome,
                                          "transfer_type_po":
                                              provider.selectPaymentMode,
                                          "channel": 'mobile'
                                        };
                                        try {
                                          final res = await provider
                                              .transactionCreateAPI(data: reqData);
                                          if (res.success && mounted) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Recipient successfully Created!');
                                            Navigator.of(context).pushNamed(
                                                res.data.settlementAccountInfo !=
                                                        null
                                                    ? RouterConstants
                                                        .paymentDetailRoute
                                                    : RouterConstants
                                                        .paymentHTMLRoute,
                                                arguments: {
                                                  Constants.amount: provider
                                                      .sendAmountController.text,
                                                  Constants.currency:
                                                      provider.destinationCountry,
                                                  Constants.transferType:
                                                      provider.selectPaymentType,
                                                  Constants.createTransaction: res,
                                                });
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(e.toString()),
                                          ));
                                        } finally {
                                          provider.setLoadingStatus(false);
                                        }
                                      },*/
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouterConstants.dashboardRoute,arguments: {
                              Constants
                                  .dashboardPageOpen: 2
                            }, (Route<dynamic> route) => false);
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Send",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter-SemiBold',
                                      fontWeight: FontWeight.w600)));
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

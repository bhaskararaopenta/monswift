import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/constants/common_constants.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/router/router.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({Key? key}) : super(key: key);

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage> {

  Widget getWidget(
      DashBoardProvider provider, String imagePath, PaymentMethodCodes data) {
    return GestureDetector(
      onTap: () {
        provider.selectPaymentType = data.imgPath ?? '';
        provider.selectPaymentCode = data.code!;
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: provider.selectPaymentType == data.imgPath
                ? Colors.blueAccent
                : Colors.white),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              imagePath,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.description!,
                    style: TextStyle(
                        color: provider.selectPaymentType == data.imgPath
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    data.description!,
                    style: TextStyle(
                        fontSize: 14,
                        color: provider.selectPaymentType == data.imgPath
                            ? Colors.white54
                            : Colors.black26),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Data? data;
    String? sourceOfIncome;
    String? purposeOf;
    if(ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
      ModalRoute
          .of(context)!
          .settings
          .arguments as Map<String, dynamic>;
      data = arguments[Constants.recipientUserDetails] as Data;
      sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
      purposeOf = arguments[Constants.purposeOf] as String;
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Choose your payment type',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Choose a payment method and \nreview your transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black26),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...provider.partnerTransactionSettingsModel!.response!.paymentMethodCodes!
                      .map((e) {
                    return getWidget(provider, AssetsConstant.bankIcon, e);
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: data == null || provider.selectPaymentType.isEmpty
                            ? null
                            : () {
                                Navigator.pushNamed(
                                    context, RouterConstants.recipientDetailsRoute,
                                    arguments: {
                                      Constants.recipientUserDetails: data,
                                      Constants.sourceOfIncome: sourceOfIncome,
                                      Constants.purposeOf: purposeOf,
                                    });
                              },
                        child: const Text("Next")),
                  ),
                  const SizedBox(
                    height: 25,
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

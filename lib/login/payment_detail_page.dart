import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/beneficiary_list_model.dart';
import 'package:nationremit/model/create_transaction_model.dart';
import 'package:nationremit/model/partner_transaction_settings_model.dart';
import 'package:nationremit/model/payout_bank_model.dart';
import 'package:nationremit/model/register_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/router.dart';

import '../model/partner_source_country_model.dart';

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({Key? key}) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String amount = '0';
    String transferType = '';
    String currency = '';
    CreateTransactionModel? transactionModel;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      amount = arguments[Constants.amount] as String;
      transferType = arguments[Constants.transferType] as String;
      currency = arguments[Constants.currency] as String;
      transactionModel =
          arguments[Constants.createTransaction] as CreateTransactionModel;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouterConstants.dashboardRoute, (Route<dynamic> route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
       /* body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: transactionModel?.data!.settlementAccountInfo != null
                  ? Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Bank details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromRGBO(30, 82, 206, 1)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Account Holder Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '${transactionModel?.data!.settlementAccountInfo?.accountHolderName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black45,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Account Number',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '${transactionModel?.data!.settlementAccountInfo?.accountNumber}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black45,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Bank Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '${transactionModel?.data!.settlementAccountInfo?.bankName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black45,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Bank Branch Code',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '${transactionModel?.data!.settlementAccountInfo?.bankBrachCode}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black45,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Bank Country',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '${transactionModel?.data!.settlementAccountInfo?.bankCountry}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black45,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )
                  : Consumer<DashBoardProvider>(builder: (_, provider, __) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Transfer details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color.fromRGBO(30, 82, 206, 1)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Payment for this transfer has not yet been reveived. Your transfer will not be proceed until it is paid for. Please make payment for the transfer as soon as possible. Go to the bottom of the page to make payment.',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Pay for transfer by card transfer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(30, 82, 206, 1)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Make payment for your transfer using Secure Trading 128-bit encrypted secure checkout. Click the button below to make the payment for your transfer now.',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Transfer type',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            transferType,
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Amount',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$amount $currency',
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Consumer<LoginProvider>(
                                builder: (_, provider, __) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigoAccent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pushNamed(
                                        RouterConstants.paymentHTMLRoute,
                                        arguments: {
                                          Constants.amount: amount,
                                          Constants.currency: currency,
                                          Constants.transferType: transferType,
                                          Constants.createTransaction:
                                              transactionModel,
                                        });
                                    //Navigator.of(context)
                                    //    .pushNamedAndRemoveUntil(RouterConstants.dashboardRoute, (Route<dynamic> route) => false);
                                  },
                                  child: const Text('Pay'));
                            }),
                          ),
                        ],
                      );
                    }),
            ),
          ),
        ),*/
      ),
    );
  }
}

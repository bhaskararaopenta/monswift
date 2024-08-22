import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/common_widget/common_property.dart';
import 'package:nationremit/model/store_card_model.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../colors/AppColors.dart';
import '../constants/common_constants.dart';
import '../constants/constants.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class OpenCardToEnterCVVPage extends StatefulWidget {
  const OpenCardToEnterCVVPage({super.key});

  @override
  State<OpenCardToEnterCVVPage> createState() => _OpenCardToEnterCVVPageState();
}

class _OpenCardToEnterCVVPageState extends State<OpenCardToEnterCVVPage> {
  String dropdownValue = 'One';

  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardSecurityCodeController = TextEditingController();
  bool isComingFromPaymentReviewPage =false;
  @override
  Widget build(BuildContext context) {
    final arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final maskedCardNumber = arguments["maskedCardNumber"] as String?;
    final cardExpiry = arguments["cardExpiry"] as String?;
    isComingFromPaymentReviewPage = arguments[Constants.isComingFromPaymentReviewPage] as bool;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(

          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                  height: 20,
                ),
                getWidget(maskedCardNumber,cardExpiry),

                const SizedBox(
                  height:40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Confirm security code and pay',
                    style: TextStyle(
                        fontFamily: 'Inter-SemiBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.edittextTitle),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'CVV/CSV',
                    style: TextStyle(
                        fontFamily: 'Inter-Medium',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.edittextTitle),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: cardSecurityCodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter security code';
                      }
                      return null;
                    },
                    decoration:
                        editTextProperty(hitText: 'Enter your security code'),
                    style: const TextStyle(fontSize: 14),
                    onChanged: (value) {},
                  ),
                ),

                Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              textStyle: TextStyle(
                                  fontFamily: 'Inter-Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.textWhite),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(65)),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                final provider = Provider.of<DashBoardProvider>(
                                  context,
                                  listen: false,
                                );
                                final req = {
                                  "amount": 100.00,
                                  "currency":"GBP"
                                };
                                StoreCardModel res =
                                    await provider.loadWallet(data: req);
                                if (res.success!) {
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('${res.error?.message}'),
                                  ));
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                // provider.setLoadingStatus(false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                ));
                              }
                            },
                            child: isComingFromPaymentReviewPage ? const Text("Pay"):const Text("Add")),
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),

      ),
    );
  }

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
    }
  }

  Widget getWidget(
       String? maskedCardNumber, String? cardExpiry) {
    return SingleChildScrollView(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCreditCard(
                  color: Color(0xFF090943),
                  cardExpiration: cardExpiry??'',
                  cardHolder: "",
                  cardNumber: maskedCardNumber!),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildCreditCard(
      {required Color color,
        required String cardNumber,
        required String cardHolder,
        required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        width: 310,
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Color.fromRGBO(0, 102, 255, 1),
            Color.fromRGBO(255, 255, 255, 0),
            Color.fromRGBO(14, 77, 197, 1),
            Color.fromRGBO(253, 249, 255, 1),
            Color.fromRGBO(51, 0, 255, 1),
            Color.fromRGBO(147, 13, 253, 0),
            Color.fromRGBO(255, 255, 255, 0)
          ], radius: 5),
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 5),
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SvgPicture.asset(
          "assets/images/ic_contact_less.svg",
          height: 40,
          width: 18,
        )
      ],
    );
  }

  // Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

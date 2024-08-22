import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/common_constants.dart';
import '../router/router.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String dropdownValue = 'One';

  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardSecurityCodeController = TextEditingController();
  late final WebViewController _controller = WebViewController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      callJwt();
      /* provider.getJwtAccountCheck(data: {
        //'remitter_id': loginProvider.userInfo?.userDetails?.remitterId
        "data": "RemitterId"
      });*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          /* child: SingleChildScrollView(
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
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(AssetsConstant.icScan),
                          SizedBox(width: 5)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Add card details',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Inter-Bold',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: AppColors.textDark),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Card Number',
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
                    controller: cardNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                    decoration:
                    editTextProperty(hitText: 'Enter your card number'),
                    style: const TextStyle(fontSize: 14),
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Expire Date',
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
                GestureDetector(
                  onTap: () {
                    openDatePicker(
                        context: context, controller: cardExpiryController);
                  },
                  child: SizedBox(
                    child: TextFormField(
                      enabled: false,
                      controller: cardExpiryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter security code';
                        }
                        return null;
                      },
                      decoration:
                      editTextProperty(hitText: 'Enter your expiry date'),
                      style: const TextStyle(fontSize: 14),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Security Code',
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
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.blueAccent,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'Save card',
                      style: TextStyle(
                          fontFamily: 'Inter-Medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.edittextTitle),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Align(
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
                            borderRadius: BorderRadius.all(Radius.circular(65)),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            final provider = Provider.of<DashBoardProvider>(
                              context,
                              listen: false,
                            );
                             final req1 = {
                              "card_number": cardNumberController.text,
                              "card_expiry": cardExpiryController.text,
                              "card_cvv": cardSecurityCodeController.text,
                            };
                            StoreCardModel res =
                                await provider.storeCard(data: req1);
                            if (res.success!) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('${res.error?.message}'),
                              ));
                            }
                            final req = {
                              "source_amount": "12",
                              "source_currency": "GBR"
                            };

                            final res2 =
                            await provider.getJwtAccountCheck(data: req);
                            if (res.success!) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('${res.error?.message}'),
                              ));
                            }
                          } catch (e) {
                            // provider.setLoadingStatus(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        },
                        child: const Text("Continue")),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),*/
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  // These values are based on trial & error method
                  alignment: Alignment(-1.05, 1.05),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, RouterConstants.dashboardRoute, (route) => false);
                      },
                      child: SvgPicture.asset(AssetsConstant.crossIcon)),
                ),
                const SizedBox(
                  height:10,
                ),
                Expanded(
                    child: provider.isLoading
                        ? Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                              height: 50.0,
                              width: 50.0,
                            ),
                          )
                        : WebViewWidget(
                            controller: _controller,
                          )),
              ],
            ),
          ),
        ));
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

  openDatePicker(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //get today's date
      firstDate: DateTime(1900),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      print(
          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(
          formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        controller.text = formattedDate; //set foratted date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  String getHTML(String actionURL, String jwt) {
    return '<html lang="en">'
        '<head>'
        '<meta charset="UTF-8" />'
        '<meta name="viewport" content="width=device-width, initial-scale=1.0" />'
        '<title>Payment form</title>'
        '<style>'
        'frame {'
        'eight: 70px !important;'
        '}'
        '</style>'
        '</head>'
        '<body>'
        '<div class="container">'
        '<h1>Payment form</h1>'
        '<div id="st-notification-frame"></div>'
        '<form id="st-form" method="POST">'
        '<div id="st-card-number"></div>'
        '<div id="st-expiration-date"></div>'
        '<div id="st-security-code"></div>'
        '<button type="submit">Pay securely</button>'
        '</form>'
        '</div>'
        '<script src="https://cdn.eu.trustpayments.com/js/latest/st.js"></script>'
        '<script>'
        '(function () {'
        'const urlParams = new URLSearchParams(window.location.search);'
        'document.getElementById("st-form").action = urlParams.get("$actionURL");'
        'var st = SecureTrading({'
        'jwt: urlParams.get("$jwt"),'
        'styles: {'
        '"border-size-input": "1px",'
        '"border-color-input": "#DBDEE4",'
        '"border-radius-input": "5px",'
        '"color-label": "#606C87",'
        '"font-size-label": "14px",'
        '"line-height-input": "10px",'
        '},'
        '});'
        't.Components();'
        '})();'
        '</script>'
        '</body>'
        '</html>';
  }

  Future<void> callJwt() async {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      /* final req = {
                              "card_number": cardNumberController.text,
                              "card_expiry": cardExpiryController.text,
                              "card_cvv": cardSecurityCodeController.text,
                            };
                            StoreCardModel res =
                                await provider.storeCard(data: req);
                            if (res.success!) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('${res.error?.message}'),
                              ));
                            }*/
      final req = {"source_amount": "12", "source_currency": "GBP"};

      final res = await provider.getJwtAccountCheck(data: req);
      if (res.success!) {
        if (provider.jwtAccountCheck != null)
          _controller
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(
                'https://xbp.uat.volant-ubicomms.com/monswift/account-check.html?jwt=${provider.jwtAccountCheck!.response!.jwt!}'
                    '&actionURL=${provider.jwtAccountCheck!.response!.actionUrl!}'))
            ..clearLocalStorage()
            ..clearCache();
      } else {
        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res.error?.message}'),
        ));*/
      }
    } catch (e) {
      // provider.setLoadingStatus(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}

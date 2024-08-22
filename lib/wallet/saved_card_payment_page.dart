import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/router/router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/common_constants.dart';
import '../constants/constants.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SavedCardPaymentPage extends StatefulWidget {
  const SavedCardPaymentPage({super.key});

  @override
  State<SavedCardPaymentPage> createState() => _SavedCardPaymentPageState();
}

class _SavedCardPaymentPageState extends State<SavedCardPaymentPage> {
  String dropdownValue = 'One';
  bool isComingFromPaymentReviewPage = false;
  bool isComingForSetSchedule = false;
  String transSessionId = '';
  String transactionReference = '';
  String maskedCardNumber = '';
  String cardHolderName = '';
  String cardType = '';
  String cardExpiry = '';

  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardSecurityCodeController = TextEditingController();
  late final WebViewController _controller = WebViewController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("transa Id if == == " + transSessionId);
      callJwt();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (arguments != null) {
      isComingFromPaymentReviewPage =
          arguments[Constants.isComingFromPaymentReviewPage] as bool;
      isComingForSetSchedule =
          arguments[Constants.isComingForSetSchedule] as bool;
      transSessionId = arguments[Constants.transSessionId] as String;
      transactionReference =
          arguments[Constants.transactionReference] as String;
      maskedCardNumber = arguments[Constants.maskedCardNumber] as String;
      cardHolderName = arguments[Constants.cardName]??'' as String;
      cardType = arguments[Constants.cardType]??'' as String;
      print("transa Id if == " + transSessionId);

    }

    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, RouterConstants.dashboardRoute, (route) => false);
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(8),
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
                      height:15,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.8,
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
          )),
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

  Future<void> callJwt() async {
    try {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final req = {
        "source_amount": "678",
        "source_currency": "GBP",
      //  "trans_session_id": transSessionId,
        "trans_sessionId": transSessionId,
        "transaction_reference": transactionReference
      };

      final res = await provider.getJwtTokenSale(data: req);
      if (res.success!) {
        if (provider.jwtAccountTokenSale != null)
          _controller
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..addJavaScriptChannel('payment',
                onMessageReceived: (JavaScriptMessage message) {
                  print('payment message ' + message.message);
                })
            ..loadRequest(Uri.parse(
                'https://xbp.uat.volant-ubicomms.com/monswift/token-payment.html?jwt=${provider.jwtAccountTokenSale!.response!.jwt!}'
                    '&actionURL=${provider.jwtAccountTokenSale!.response!.actionUrl!}&cardProvider=${cardType}&cardHolder=${cardHolderName}''&cardNumber=${maskedCardNumber}'))
            ..clearLocalStorage()
            ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {
              if (url.startsWith(
                  'https://xbp.uat.volant-ubicomms.com/api/v1/tp/XBPPT2024000/sale-response/')) {}
              print('payment message ' + url);
            }))
            ..clearCache();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res.error?.message}'),
        ));
      }
    } catch (e) {
      // provider.setLoadingStatus(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}

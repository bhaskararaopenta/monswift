
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/create_transaction_model.dart';
import 'package:nationremit/router/router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddCardHTMLPage extends StatefulWidget {
  const AddCardHTMLPage({super.key});

  @override
  State<AddCardHTMLPage> createState() => _AddCardHTMLPageState();
}

class _AddCardHTMLPageState extends State<AddCardHTMLPage> {
  late final WebViewController _controller;
  String hashKey = '';
  String amount = '0';
  String transferType = '';
  String currency = '';
  CreateTransactionModel? transactionModel;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (mounted && ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //  amount = arguments[Constants.amount] as String;
     // transferType = arguments[Constants.transferType] as String;
     // currency = arguments[Constants.currency] as String;
    //  transactionModel =
    //      arguments[Constants.createTransaction] as CreateTransactionModel;

      // String a =
      //     '$currency${amount}${transactionModel?.data.trustPaymentData.siteReference}${transactionModel?.data.trustPaymentData.currentTimeStamp}1tqR@9K4Gt7oQZgE5VkAm74\$bZsgpZS?';
      // var bytes = utf8.encode(a); // data being hashed
      // Digest digest = sha256.convert(bytes);
      // hashKey = digest.toString();
      // print('============== $a');
      // print('============== $bytes');
      // print('============== $hashKey');
    }

    final document = transactionModel == null
        ? parse('<html>  </html>')
        : parse(getHTML(transactionModel!, hashKey));
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadHtmlString(document.outerHtml)
      ..loadRequest(Uri.parse(
        //          '${transactionModel?.data.trustPaymentData?.webviewurl}${transactionModel?.data.transactionData.transSessionId}'))
          'https://xbp.uat.volant-ubicomms.com/vitpay/api/v1/m/transaction-tp/payment-details/${transactionModel?.response!.data!.transactionData!.transSessionId}'))
      ..clearLocalStorage()
      ..clearCache();
    //..runJavaScript('window.addEventListener(\'load\', function () {document.getElementById("redirectionBtn").click();})');

    return WillPopScope(
      onWillPop: () async {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:
                    const Radius.circular(25.0),
                    topRight:
                    const Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height:20,),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 120,
                    ),
                    SizedBox(height:30,),
                    Text('Goto Transaction List Page',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                    SizedBox(height: 45,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                RouterConstants
                                    .dashboardRoute,
                                arguments: {
                                  Constants
                                      .dashboardPageOpen: 1
                                },
                                    (Route<dynamic>
                                route) =>
                                false);
                          },
                          child: Text("OK")),
                    ),
                  ],
                ),
              );
            });
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: _controller == null
                ? const CircularProgressIndicator()
                : WebViewWidget(
                    controller: _controller,
                  ),
          ),
        ),
      ),
    );
  }

  String getHTML(CreateTransactionModel transactionModel, String hashKey) {
    return '<html> <body>'
        '<head>'
        '<style>'
        '.button {'
        'background-color: #4CAF50;'
        'border: none;'
        'color: white;'
        'padding: 15px 32px;'
        'text-align: center;'
        'text-decoration: none;'
        'display: inline-block;'
        'font-size: 30px;'
        'margin: 4px 2px;'
        'cursor: pointer;'
        'border-radius: 4px;'
        'width: 100%;'
        'height:100;'
        '}'
        '.container h1, .container h3 {'
        'font-family: \'Gilroy\';'
        'font-style: normal;'
        'font-weight: 700;'
        'color: #325ED9;'
        '}'
        '.container h1 {'
        'font-size: 60px;'
        'padding-right: 30px;'
        'padding-left: 30px;'
        '}'
        '.container h3 {'
        'font-size: 36;'
        'padding-right: 30px;'
        'padding-left: 30px;'
        '}'
        '.text {'
        'font-family: \'Gilroy\';'
        'font-style: normal;'
        'font-weight: 500;'
        'font-size: 30px;'
        'color: #70737A;'
        'padding-right: 30px;'
        'padding-left: 30px;'
        '}'
        'font-family: \'Gilroy\';'
        'font-style: normal;'
        'font-weight: 800;'
        '}'
        '.secure-trading-logo {'
        'margin: 20px 0 30px;'
        'width: 150px;'
        '}'
        '.form-group{'
        'padding-top: 50px;'
        'padding-right: 30px;'
        'padding-bottom: 50px;'
        'padding-left: 80px;'
        '}'
        'input[type=submit] {'
        'height: 60px;'
        'width: 200px;'
        'background: #325ED9;'
        'border-radius: 12px;'
        'font-family: \'Gilroy\';'
        'font-style: normal;'
        'font-weight: 600;'
        'font-size: 18px;'
        'color: #FFFFFF;'
        'border: 0;'
        'outline: 0;'
        'display: flex;'
        'align-items: center;'
        'justify-content: center;'
        'margin: auto;'
        '}'
        '</style>'
        '<script>'
        'function clickFunction(){'
        'var form = document.getElementById("myform");'
        ' form.submit();'
        '}'
        '</script>'
        '</head>'
        '<div class="container mt-5">'
        '<h1>Transfer details</h1>'
        ' <p class="text">'
        'Payment for this transfer has not yet been reveived. Your transfer will not be proceed until it is paid for.'
        'Please make payment for the transfer as soon as possible. Go to the bottom of the page to make payment.'
        '</p>'
        '<h3>Pay for transfer by card transfer</h3>'
        '<div class="row mb-4">'
        '<div class="col-md-12">'
        '<p class="text">'
        'Make payment for your transfer using Secure Trading 128-bit encrypted secure checkout. Click the button'
        'below to make the payment for your transfer now.'
        '</p>'
        '</div>'
        '<div class="col-md-12">'
        '<div class="form-group">'
        '<img width="200px" class="secure-trading-logo" src="{{imgPath}}/secure_trading.jpg">'
        '</div>'
        '<p/>'
        '<p/>'
        '<div/>'
        '<div class="form-group">'
        '<label>Transfer type</label>'
        '<div class="text">Card</div>'
        '</div>'
        '<p/>'
        '<p/>'
        '<div class="text">'
        '<label>Amount</label>'
        '<div class="text">${transactionModel.response!.data!.transactionData!.sourceAmount} ${transactionModel.response!.data!.transactionData!.sourceCurrency}</div>'
        '</div>'
        '</div>'
        '</div>'
        '<form id="myform" method="POST" action="https://payments.securetrading.net/process/payments/choice">'
        ' <input type="hidden" name="sitereference" value="${transactionModel.response!.data!.trustPaymentData?.siteReference}">'
        '<input type="hidden" name="stprofile" value="default">'
        '<input type="hidden" name="currencyiso3a" value="${transactionModel.response!.data!.transactionData!.sourceCurrency}">'
        '<input type="hidden" name="mainamount" value="${transactionModel.response!.data!.transactionData!.sourceAmount}">'
        //  '<input type="hidden" name="mainamount" value="100">'
        '<input type="hidden" name="version" value="2">'
        '<input type="hidden" name="orderreference" value="${transactionModel.response!.data!.transactionData!.transSessionId}">'
        '<input type="hidden" name="billingfirstname" value="${transactionModel.response!.data!.beneficiaryData!.beneFirstName}">'
        '<input type="hidden" name="billinglastname" value="${transactionModel.response!.data!.beneficiaryData!.beneLastName}">'
        '<input type="hidden" name="billingstreet" value="${transactionModel.response!.data!.beneficiaryData!.beneAddress}">'
        '<input type="hidden" name="billingtown" value="${transactionModel.response!.data!.beneficiaryData!.beneCity}">'
        // '<input type="hidden" name="billingcounty" value="${transactionModel.response!.data.beneficiaryData!.bene}">'
        // '<input type="hidden" name="billingpostcode" value="${transactionModel.response!.data.beneficiaryData!.post}">'
        // '<input type="hidden" name="billingcountyiso2a" value="${transactionModel.response!.data.beneficiaryData!.post}">'
        '<input type="hidden" name="billingemail" value="${transactionModel.response!.data!.beneficiaryData!.beneEmail}">'
        '<input type="hidden" name="billingtelephone" value="${transactionModel.response!.data!.beneficiaryData!.beneMobileNumber}">'
        '<input type="hidden" name="billingtelephonetype" value="M">'
        '<input type="hidden" name="customerfirstname" value="${transactionModel.response!.data!.beneficiaryData!.beneFirstName}">'
        '<input type="hidden" name="customerlastname" value="${transactionModel.response!.data!.beneficiaryData!.beneLastName}">'
        '<input type="hidden" name="customerstreet" value="${transactionModel.response!.data!.beneficiaryData!.beneAddress}">'
        '<input type="hidden" name="customertown" value="${transactionModel.response!.data!.beneficiaryData!.beneCity}">'
        // '<input type="hidden" name="customercounty" value="${transactionModel.response!.data!.beneficiaryData!.bene}">'
        // '<input type="hidden" name="customerpostcode" value="${transactionModel.response!.data!.beneficiaryData!.post}">'
        // '<input type="hidden" name="customercountyiso2a" value="${transactionModel.response!.data!.beneficiaryData!.post}">'
        '<input type="hidden" name="customeremail" value="${transactionModel.response!.data!.beneficiaryData!.beneEmail}">'
        '<input type="hidden" name="customertelephone" value="${transactionModel.response!.data!.beneficiaryData!.beneMobileNumber}">'
        '<input type="hidden" name="customertelephonetype" value="M">'
        '<input type="hidden" name="ruleidentifier" value="STR-6">'
     //   '<input type="hidden" name="successfulurlredirect" value="${transactionModel.response!.data!.trustPaymentData.successfulurlredirect}">'
        '<input type="hidden" name="ruleidentifier" value="STR-7">'
     //   '<input type="hidden" name="declinedurlredirect" value="${transactionModel.response!.data!.trustPaymentData?.declinedurlredirect}">'
        '<input type="hidden" name="ruleidentifier" value="STR-13">'
     //   '<input type="hidden" name="errorurlredirect" value="${transactionModel.response!.data!.trustPaymentData?.errorurlredirect}">'
        '<input type="hidden" name="ruleidentifier" value="STR-8">'
        '<input type="hidden" name="successfulurlnotification" value="${transactionModel.response!.data!.trustPaymentData?.successfulurlnotification}">'
        '<input type="hidden" name="ruleidentifier" value="STR-9">'
        '<input type="hidden" name="declinedurlnotification" value="${transactionModel.response!.data!.trustPaymentData?.declinedurlnotification}">'
        '<input type="hidden" name="ruleidentifier" value="STR-10">'
        '<input type="hidden" name="allurlnotification" value="${transactionModel.response!.data!.trustPaymentData?.allurlnotification}">'
        '<input type="hidden" name="sitesecurity" value="${transactionModel.response!.data!.trustPaymentData?.hash}">'
        '<input type="hidden" name="sitesecuritytimestamp" value="${transactionModel.response!.data!.trustPaymentData?.currentTimeStamp}">'
        '<input  type="submit" id="redirectionBtn" value="Pay" class="button">'
        '</form>'
        ' </body></html>';
  }
}

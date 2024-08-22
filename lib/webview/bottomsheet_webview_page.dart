
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/common_constants.dart';
import '../router/router.dart';

class BottomSheetWebView extends StatefulWidget {

  BottomSheetWebView();


  @override
  _BottomSheetWebViewState createState() => _BottomSheetWebViewState();
}

class _BottomSheetWebViewState extends State<BottomSheetWebView> {
  late final WebViewController _controller = WebViewController();
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = { Factory(() => EagerGestureRecognizer()) };

@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    getSettings();
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 10),
            child: Column(
              children: [
                Align(
                  // These values are based on trial & error method
                  alignment: Alignment(-1.05, 1.05),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(AssetsConstant.crossIcon)),
                ),
                const SizedBox(
                  height:10,
                ),
               SizedBox(
                    height: MediaQuery.of(context).size.height,
                 child: provider.isLoading
                     ? Center(
                   child: SizedBox(
                     child: CircularProgressIndicator(),
                     height: 50.0,
                     width: 50.0,
                   ),
                 )
                     :  WebViewWidget(
                      gestureRecognizers: gestureRecognizers,
                      controller: _controller
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSettings() async {
    try {
      final provider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );


      final res = await provider.getRemitterUISettings();
      if (res.success!) {
        _controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(res.response!.termsAndConditions!))
          ..clearLocalStorage()
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




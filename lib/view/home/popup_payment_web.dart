
// ignore_for_file: deprecated_member_use

import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ExtraDepositPay extends StatefulWidget {
  final String url;

  const ExtraDepositPay({super.key, required this.url});

  @override
  ExtraDepositPayState createState() => ExtraDepositPayState();
}
class ExtraDepositPayState extends State<ExtraDepositPay> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.url);
      print('wwwwww');
    }


    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
            leading: const AppBackBtn(),
            title: textWidget(
                text: 'Pay', fontSize: 25, color: AppColors.whiteColor),
            gradient: AppColors.primaryGradient),
        body: Column(
          children: <Widget>[
            if (_isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white, // Set your desired background color
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Expanded(
              child: WebView(
                backgroundColor: Colors.transparent,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  webViewController.clearCache();
                  final cookieManager = CookieManager();
                  cookieManager.clearCookies();
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('upi://')) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
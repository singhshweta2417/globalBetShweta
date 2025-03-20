import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
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
      print('widget url open');
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: (){
              // Navigator.pushNamed(context, RoutesName.dashboard);
            },
              child: Icon(Icons.arrow_back, size: 15,)),
          title: const TextConst(
            title: "Pay",
            fontSize: 14,
          ),
        ),
        body: Stack(
          children: [
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
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String paymentUrl;

  PaymentScreen(this.paymentUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebView(
        initialUrl: paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          if (url.contains('finish')) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..loadRequest(Uri.parse('https://tractorgyan.com/tractor-industry-news-blogs/896/top-10-central-government-schemes-for-farmers-in-india'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Goverment Schemes'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
/*
class Gov_scheme extends StatefulWidget {
   Gov_scheme({Key? key}) : super(key: key);

  @override
  State<Gov_scheme> createState() => _ClassNotifyState();
}
class _ClassNotifyState extends State<Gov_scheme> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // print the loading progress to the console
          // you can use this value to show a progress bar if you want
          debugPrint("Loading: $progress%");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("https://keralaagriculture.gov.in/en/schemes/"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Goverment schemes',),

        ),
        body:
        WebViewWidget(
          controller: _controller,
        )

    );

  }
}
*/

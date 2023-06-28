import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
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
        title: const Text('Weather Forecasting'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

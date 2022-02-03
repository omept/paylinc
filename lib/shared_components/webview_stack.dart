import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  WebViewStack({Key? key, this.onError, this.initialUrl}) : super(key: key);
  final String? initialUrl;
  final Function()? onError;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  int loadingPercentage = 0;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    // MediaQueryData mediContext = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.initialUrl}',
          style: themeContext.textTheme.subtitle2,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.initialUrl,
              onWebResourceError: (err) {
                widget.onError?.call();
              },
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingPercentage = 100;
                });
              },
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                color: kNotifColor,
              ),
          ],
        ),
      ),
    );
  }
}

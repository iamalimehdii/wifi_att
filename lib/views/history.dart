import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryState();
}

class HistoryState extends State<History> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('http://sp.hamdard.edu.pk/attendances/inquiry/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://sp.hamdard.edu.pk'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ATTENDANCE HISTORY"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  }
                },
                icon: Icon(Icons.arrow_left)),
            IconButton(
                onPressed: () async {
                  if (await controller.canGoForward()) {
                    controller.goForward();
                  }
                },
                icon: Icon(Icons.arrow_right))
          ],
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

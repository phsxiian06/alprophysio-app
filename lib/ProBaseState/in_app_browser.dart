import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:alpro_physio/ProBaseState/pro_base_state.dart';

class PageAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  PageAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return OpenUpwardsPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }
}

class InAppBrowser extends ProState {
  InAppBrowser(this.urlLink);

  final String urlLink;
  WebViewController _controller;
  bool hideLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  JavascriptChannel _onJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Flutter',
        onMessageReceived: (JavascriptMessage message) {
          print('webView.message: ${message.message ?? 'null'}');
          /*if (message.message != null && message.message == 'completePayment') {
            Navigator.of(context).pop('completePayment');
          } else if (message.message != null && message.message == 'cancelPayment') {
            Navigator.of(context).pop('cancelPayment');
          }*/
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: WebView(
              initialUrl: urlLink,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                /*Future.delayed(Duration(milliseconds: 500)).then((_) {
                  _controller?.evaluateJavascript("hideNavBar()");
                });*/
              },
              javascriptChannels: <JavascriptChannel>[
                _onJavascriptChannel(context),
              ].toSet(),
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                _controller?.evaluateJavascript("hideNavBar()");
                _controller
                    ?.evaluateJavascript("\$crisp.push(['do', 'chat:hide']);");
                Future.delayed(Duration(milliseconds: 500)).then((_) {
                  hideLoading = true;
                  showLoading(false);
                });
              },
            ),
          ),
          Positioned.fill(
            child: hideLoading
                ? Center()
                : Container(
                    color: Colors.black38,
                    child: Center(),
                  ),
          )
        ],
      ),
    );
  }
}

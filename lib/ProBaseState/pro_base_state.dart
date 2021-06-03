//
//  ProBaseState.dart
//
//  Created by Dexter on 25/06/2020.
//  Copyright © 2020 ETCTECH. All rights reserved.
//

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'export.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';

typedef GeneralErrorHandle = bool Function(
    BuildContext context, int code, String message);

class ProBaseState {
  //set a default loading widget if needed.
  static Widget loadingWidget;

  //set customise default app bar if needed.
  static AppBar defaultAppBar;

  //set the statusBarText into white, default false(black).
  static bool statusBarTextWhiteColor = false;

  //set the statusBar background color into your desired color.
  static Color statusBarBackgroundColor;

  //if this is true, the gestureDectector will catch the touch and dimiss the keyboard if any is shows.
  //default is true
  static bool hideKeyboardWhenTappedAround = true;

  //a General Error Handle all all pages using this.
  static GeneralErrorHandle onFailed;

  //by default have a function called forceUpdate(), which straight redirect user to the store when needed, but ios and hms required to manually insert the id.
  static String iosAppID;
  static String hmsAppID;

  // override the default error widget by doing so -> ErrorWidget.builder = ProBaseState.customErrorWidget;
  static Widget customErrorWidget(FlutterErrorDetails error) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Icon(Icons.announcement, size: 40, color: Colors.red)),
        Text(
          'An application error has occurred.',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
        ),
        Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Error message:',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline)),
                Text(error.exceptionAsString()),
              ],
            )),
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Stack Trace:',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(error.stack.toString()))),
                ],
              )),
        ),
        Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: InkWell(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text('Send Bug Report',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ))),
              ),
            )),
      ]),
    );
  }

  static MethodChannel _methodChannel =
      MethodChannel('com.etctech.recycle_detector/ml');

  static Future<bool> isHMS() async {
    try {
      bool result = await _methodChannel.invokeMethod('isHmsAvailable');
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> isGMS() async {
    try {
      bool result = await _methodChannel.invokeMethod('isGmsAvailable');
      return result;
    } on PlatformException {
      print('Failed to get _isGmsAvailable.');
      return false;
    }
  }

  static void lockScreenOrientation(DeviceOrientation orientation) {
    SystemChrome.setPreferredOrientations([
      orientation,
    ]);
  }

  static void allowedOrientation(List<DeviceOrientation> orientationList) {
    SystemChrome.setPreferredOrientations(orientationList);
  }
}

// remember to add forceupdate function. prompt when iosAppID not set.

class ProRoute extends StatefulWidget {
  final ProState state;
  final NavState navState; // pass only if custom navigation
  final String title;
  final bool gotAppBar;
  final bool isClosable;
  final bool closePopup;
  final FloatingActionButtonLocation floatingLocation;
  final bool isLoading;
  final bool coverAppBar;
  final String backgroundImage;
  final Color backgroundColor;
  final Key childKey;

  ProRoute(this.state,
      {this.navState,
      this.title,
      this.gotAppBar = true,
      this.isClosable = true,
      this.closePopup = false,
      this.floatingLocation,
      this.isLoading = false,
      this.coverAppBar = false,
      this.backgroundImage,
      this.backgroundColor,
      this.childKey,
      Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return navState == null ? NavState() : navState;
  }
}

class NavState extends State<ProRoute> {
  //
  NavState();

  Future<bool> defaultPop(BuildContext context) async {
    return true;
  }

  Future<bool> blockClose(BuildContext context) async {
    return widget.closePopup ? showBlockClose(context) : false;
  }

  AppBar handleAppBar(String title) {
    return ProBaseState.defaultAppBar != null
        ? ProBaseState.defaultAppBar
        : AppBar(
            centerTitle: true,
            title: title != null ? Text(title) : Center(),
          );
  }

  Widget handleDrawer(BuildContext context) {
    return null;
  }

  Widget handleFloatingBtn(BuildContext context) {
    return null;
  }

  Widget handleBottomNav(BuildContext context) {
    return null;
  }

  Future<bool> popUpBlock() {
    return null;
  }

  Positioned overlayWidget(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double barheight = 0;
    AppBar appBar = handleAppBar(widget.title);
    if (widget.gotAppBar) barheight = appBar.preferredSize.height;
    return WillPopScope(
      onWillPop: () async {
        var isPopHandle = await popUpBlock();
        if (isPopHandle == null) {
          if (widget.closePopup)
            return blockClose(context);
          else
            return widget.isClosable
                ? defaultPop(context)
                : blockClose(context);
        } else {
          return isPopHandle;
        }
      },
      child: ChangeNotifierProvider(
        create: (context) => ProNotifier(widget.isLoading, widget.coverAppBar),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            bool canTap = ProBaseState.hideKeyboardWhenTappedAround;
            if (canTap != null && canTap) {
              FocusScope.of(context).requestFocus(new FocusNode());
            }
          },
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: (widget.backgroundImage != null &&
                        widget.backgroundImage != '')
                    ? (widget.backgroundImage.startsWith('http')
                        ? Image.network(
                            widget.backgroundImage,
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.dstATop,
                            color: Colors.black45,
                          )
                        : Image.asset(
                            widget.backgroundImage,
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.dstATop,
                            color: Colors.black45,
                          ))
                    : Container(
                        color: widget.backgroundColor ?? Colors.white,
                      ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: widget.gotAppBar ? appBar : null,
                drawer: handleDrawer(context),
                floatingActionButton: handleFloatingBtn(context),
                floatingActionButtonLocation: widget.floatingLocation,
                body: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: ProPage(
                            queryData.size.height -
                                queryData.padding.top -
                                queryData.padding.bottom -
                                barheight,
                            queryData.size.width,
                            widget.state,
                            widget.childKey)),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: handleBottomNav(context) == null
                          ? Center()
                          : handleBottomNav(context),
                    ),
                  ],
                ),
              ),
              Consumer<ProNotifier>(
                builder: (context, routeNotifier, _) => widget.gotAppBar
                    ? Positioned(
                        top: routeNotifier.coverAppBar ? 0 : barheight,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: SafeArea(
                            top: true,
                            bottom: false,
                            child: loader(routeNotifier.isLoading)),
                      )
                    : Positioned.fill(
                        child: loader(routeNotifier.isLoading),
                      ),
              ),
              overlayWidget(context) == null
                  ? Center()
                  : overlayWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget loader(bool isLoading) {
    return (isLoading
        ? GestureDetector(
            child: ProBaseState.loadingWidget == null
                ? Container(
                    color: Colors.black12,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                : ProBaseState.loadingWidget,
            onTap: () {},
          )
        : Center());
  }
}

class ProPage extends StatefulWidget {
  final double contentHeight;
  final double contentWidth;
  final ProState state;

  ProPage(this.contentHeight, this.contentWidth, this.state, Key key)
      : super(key: key);

  @override
  ProState createState() {
    return state;
  }
}

// extends for widget with default scaffold
abstract class ProState extends State<ProPage>
    with WidgetsBindingObserver
    implements GeneralCallBack {
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatusBarColor(null);
    if (accessToken != null && accessToken.isNotEmpty) {
      /*subscription = Fcm.eventBus.on<NotificationData>().listen((data) {
        Util.showFlash(context, data.title, data.message);
      });*/
    }
  }

  Future<void> setStatusBarColor(bool isWhite) async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isWhite == null ? ProBaseState.statusBarTextWhiteColor : isWhite);
  }

  // show/hide loading. coverAppBar will be ignore if gotAppbar == false.
  void showLoading(bool value, {bool coverAppBar = false}) {
    final routeNotifier = Provider.of<ProNotifier>(context);
    routeNotifier.showLoading(value, coverAppBar: coverAppBar);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      //
    }
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        ProBaseState.statusBarTextWhiteColor);
    subscription?.cancel();
    super.dispose();
  }

  bool onFailed(int code, String message, dynamic data) {
    if (ProBaseState.onFailed == null) return false;
    return ProBaseState.onFailed(context, code, message);
  }
}

// extends for widget without default scaffold
abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements GeneralCallBack {
  final bool isScaffold;
  final bool isTransparent;
  final bool safeArea;
  final bool isRoot;
  final String title;
  double contentHeight = 0;
  StreamSubscription subscription;
  AppBar appBar;

  BaseState(
      {this.title,
      this.isScaffold = false,
      this.isTransparent = false,
      this.safeArea = false,
      this.isRoot = false});

  @override
  void initState() {
    super.initState();
    if (isRoot && accessToken != null && accessToken.isNotEmpty) {
      /*subscription = Fcm.eventBus.on<NotificationData>().listen((data) {
        Util.showFlash(context, data.title, data.message);
      });*/
    }
    setStatusBarColor(null);
    if (ProBaseState.statusBarBackgroundColor != null) {
      setStatusBarBackground(ProBaseState.statusBarBackgroundColor);
    }
  }

  Future<void> setStatusBarColor(bool isWhite) async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isWhite == null ? ProBaseState.statusBarTextWhiteColor : isWhite);
  }

  Future<void> setStatusBarBackground(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        ProBaseState.statusBarTextWhiteColor);
    FlutterStatusbarcolor.setStatusBarColor(
        ProBaseState.statusBarBackgroundColor);
    subscription?.cancel();
    super.dispose();
  }

  bool onFailed(int code, String message, dynamic data) {
    if (ProBaseState.onFailed == null) return false;
    return ProBaseState.onFailed(context, code, message);
  }

  Widget handleAppBar(String title) {
    return null;
  }

  //call manual before default builder for create default app bar
  void defaultBarBuilder(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double barheight = 0;
    appBar = handleAppBar(title);
    if (appBar != null) barheight = appBar.preferredSize.height;
    contentHeight = queryData.size.height -
        queryData.padding.top -
        queryData.padding.bottom -
        barheight;
  }

  Widget defaultBuilder(BuildContext context, Widget child) {
    return isScaffold
        ? Scaffold(
            backgroundColor: isTransparent ? Colors.transparent : null,
            appBar: appBar,
            body: Builder(builder: (context) {
              return safeArea
                  ? SafeArea(
                      child: child,
                    )
                  : child;
            }),
          )
        : child;
  }
}

abstract class GeneralCallBack {
  bool onFailed(int code, String message, dynamic data);
}

class ProNotifier with ChangeNotifier {
  bool _isLoading = false;
  bool _coverAppBar = false;

  ProNotifier(this._isLoading, this._coverAppBar);

  bool get isLoading => _isLoading;
  bool get coverAppBar => _coverAppBar;

  void showLoading(bool value, {bool coverAppBar = false}) {
    _isLoading = value;
    _coverAppBar = coverAppBar;
    notifyListeners();
  }
}

// 4 Types of PageTransitionsBuilder: OpenUpwards, FadeUpwards, Cupertino, Zoom.

class OpenUpwardsAnimationRoute<T> extends MaterialPageRoute<T> {
  OpenUpwardsAnimationRoute({
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

class FadeUpwardsAnimationRoute<T> extends MaterialPageRoute<T> {
  FadeUpwardsAnimationRoute({
    @required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeUpwardsPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }
}

class CupertinoAnimationRoute<T> extends MaterialPageRoute<T> {
  CupertinoAnimationRoute({
    @required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return CupertinoPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }
}

class ZoomAnimationRoute<T> extends MaterialPageRoute<T> {
  ZoomAnimationRoute({
    @required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ZoomPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideAnimationRoute<T> extends MaterialPageRoute<T> {
  SlideAnimationRoute({
    @required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //return PageTransitionsBuilder()
    //.buildTransitions(this, context, animation, secondaryAnimation, child);
    //return FadeTransition(opacity: animation, child: child);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}

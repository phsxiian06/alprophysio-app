import 'package:alpro_physio/ui/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'language/app_language.dart';
import 'language/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:alpro_physio/controller/size_config.dart';
import 'package:alpro_physio/ProBaseState/export.dart';
void main() {
  runApp(MyApp(AppLanguage()));
}

class MyApp extends StatelessWidget {
  final AppLanguage _appLanguage;

  MyApp(this._appLanguage);

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = ProBaseState.customErrorWidget;
    //FlutterStatusbarcolor.setStatusBarColor(_color_);
    //FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => _appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          title: 'Alpro Physio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: themePurpleSwatch,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          supportedLocales: [
            Locale(AppLanguage.LANG_EN),
            Locale(AppLanguage.LANG_CN),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            // built-in localization of basic text for Material Widgets
            //GlobalMaterialLocalizations.delegate,
            // built-in localization for text-direction LTR/RTL
            //GlobalWidgetsLocalizations.delegate,
            //GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
          locale: model.appLocale,
          builder: (context, child) {
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          home: LoadingPage(),
        );
      }),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // pro base state setup
    ProBaseState.allowedOrientation([DeviceOrientation.portraitUp]);
    ProBaseState.hideKeyboardWhenTappedAround = true;
    ProBaseState.onFailed = ((internalContext, code, msg) {
      if (code == TokenExpired) {
        accessToken = '';
        return true;
      } else if (code == ForceUpdate) {
        openForceUpdateDialog(internalContext);
        return true;
      } else if (code == LabelUpdate) {
        //update your laballing here.
        return true;
      }
      return false;
    });
    // todo - FCM init
    // Fcm.init();
    Future.delayed(Duration(milliseconds: 1200)).then((_) {
      _initPref();
    });
  }

  void _initPref() async {
    await preferenceInit();
    // todo - get endpoint
    // todo - get label
    _checkCredential();
  }

  void _checkCredential() async {
    if (isLogin) {
      ProBaseState.statusBarTextWhiteColor = false;
      onEnterMainPage();
    } else {
      if(firstTime == 1){
        onEnterMainPage();
        /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProRoute(LoginPage(),
          gotAppBar: false, closePopup: true,),), (route) => false);*/
      } else {
        onEnterMainPage();
        /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProRoute(IntroductionPage(),
          gotAppBar: false, closePopup: true,),), (route) => false);*/
      }
    }
  }

  void onEnterMainPage() async {
    var key = GlobalKey<MainNav>();
    var page = GlobalKey<MainPage>();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProRoute(MainPage(key, 0),
      gotAppBar: false, navState: MainNav(page, tabIndex: 0), key: key, childKey: page, closePopup: true,)),(route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    // init the size config
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset('assets/logo.png', width: 100, height: 100,),
            //SizedBox(height: 50,),
            Container(
              width: 30,
              child: Text('Alpro Physio', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
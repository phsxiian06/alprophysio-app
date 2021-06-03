import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:OEGlobal/model/weekday.dart';
import 'package:OEGlobal/ProBaseState/pro_base_state.dart';
import 'package:OEGlobal/ProBaseState/in_app_browser.dart';
import 'package:OEGlobal/ProBaseState/constant.dart' as Constant;


void showFlash(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    flushbarPosition: FlushbarPosition.TOP, //Immutable
    reverseAnimationCurve: Curves.decelerate, //Immutable
    forwardAnimationCurve: Curves.easeOut, //Immutable
    //isDismissible: true,
    margin: EdgeInsets.all(5),
    borderRadius: 8,
    backgroundColor: Colors.white,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 12.0,
        offset: Offset(6.0, 6.0),
      ),
    ],
    duration: Duration(seconds: 14),
    icon: Center(),
    onTap: (_) {
      //
    },
  ).show(context).catchError((error) {});
}

void showToast(BuildContext context, String msg) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      action:
          SnackBarAction(label: "OK", onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

Future<bool> showBlockClose(BuildContext context) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notice'),
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  // Navigator.of(context).pop(true);
                  exitApp();
                },
                child: new Text('Yes'),
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<bool> showAlert(BuildContext context, String title,
    {VoidCallback confirm, actionLabel = 'OK'}) async {
  // flutter defined function
  return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(title),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text(actionLabel),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  if (confirm != null) {
                    confirm();
                  }
                },
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<bool> showConfirmation(
  BuildContext context,
  String message, {
  VoidCallback confirm,
  actionLabel = 'OK',
  bool autoPop = true,
}) async {
  // flutter defined function
  return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text(actionLabel),
                onPressed: () {
                  if (autoPop) {
                    Navigator.of(context).pop(true);
                  }
                  if (confirm != null) {
                    confirm();
                  }
                },
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<bool> showConfirmCancel(
    BuildContext context, String title, String message,
    {VoidCallback confirm,
    String negative = 'Cancel',
    String positive = 'OK'}) async {
  // flutter defined function
  return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text(negative),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: new Text(
                  positive,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  if (confirm != null) {
                    confirm();
                  }
                },
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<int> showCupertinoActionSheet(BuildContext context, List<String> list,
    {String title}) {
  var listWidget = <Widget>[];
  for (var i = 0; i < list.length; i++) {
    listWidget.add(CupertinoActionSheetAction(
      child: Text(list[i]),
      onPressed: () {
        Navigator.of(context).pop(i);
      },
    ));
  }

  CupertinoActionSheet dialog = CupertinoActionSheet(
    title: title != null && title != '' ? Text(title) : null,
    actions: listWidget,
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  return showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          }) ??
      null;
}

Future<List<WeekDay>> showWeekDayPicker(BuildContext context,
    {List<WeekDay> initialWeekDay, String title}) {
  if (initialWeekDay == null) {
    initialWeekDay = WeekDay.getFullWorkDays();
  }

  List<WeekDay> list = WeekDay.getFullWorkDays();
  for (int i = 0; i < initialWeekDay.length; i++) {
    for (int j = 0; j < list.length; j++) {
      if (list[j].weekday == initialWeekDay[i].weekday) {
        list[i].selected = initialWeekDay[j].selected;
        break;
      }
    }
  }

  return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: title != null && title != '' ? Text(title) : null,
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: new Text(
                    'OK',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(list);
                  },
                ),
              ],
              content: StatefulBuilder(builder: (context, setState) {
                return Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        title: Text(list[index].name),
                        value: list[index].selected,
                        onChanged: (value) {
                          setState(() {
                            list[index].selected = value;
                          });
                        },
                      );
                    },
                  ),
                );
              }),
            );
          }) ??
      null;
}

void vibrate() async {
  var canVibrate = await Vibration.hasVibrator();
  if (canVibrate) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Vibration.vibrate(duration: 300);
    } else {
      Vibration.vibrate(duration: 300);
    }
  }
}

Future<void> playSound(String name) async {
  AudioCache cache = new AudioCache();
  await cache.play(name);
}

void openRoute(BuildContext context, double latitude, double longitude) async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    var mapSchema = 'geo:$latitude,$longitude?q=$latitude,$longitude';
    /*if (await canLaunch('google.navigation:'))
        launch('google.navigation:q=$latitude,$longitude');*/
    if (await canLaunch('geo:'))
      launch(mapSchema);
    else
      showConfirmation(
          context, 'Please install waze or google map to start navigator');
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    bool canMap = await canLaunch('waze://');
    if (!canMap) {
      bool canGoogleMap = await canLaunch('comgooglemaps://');
      if (canGoogleMap)
        launch(
            'comgooglemaps://?saddr=&daddr=${latitude},${longitude}&directionsmode=driving');
      else
        showConfirmation(
            context, 'Please install waze or google map to start navigator');
    } else
      launch('waze://?ll=${latitude},${longitude}&navigate=yes&zoom=17');
  }
}

Future<dynamic> showInAppBrowser(BuildContext context, String url) async {
  return await Navigator.of(context).push(PageAnimationMaterialPageRoute(
      builder: (context) => ProRoute(
            InAppBrowser(url),
            gotAppBar: true,
            isLoading: true,
          )));
}

Future launchURL(BuildContext context, String url, {bool pop = true}) async {
  if (url == null || url == '') {
    return;
  } else if (await canLaunch(url)) {
    if (pop) Navigator.of(context).pop();
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

void openForceUpdateDialog(BuildContext context,
    {String title, String message}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if (title == null || title == '') {
        title = 'New Version Available';
      }
      if (message == null || message == '') {
        message =
            'There is a newer version available for download! Please update the app by visiting the ';
        if (Platform.isAndroid) {
          message += 'Play Store';
        } else {
          message += 'App Store';
        }
      }
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: new Text('Update'),
            onPressed: () {
              openAppStore();
            },
          ),
        ],
      );
    },
  );
}

void openAppStore() async {
  String url;
  if (Platform.isAndroid) {
    bool isHMS = await ProBaseState.isHMS();
    if (isHMS &&
        (ProBaseState.hmsAppID != null && ProBaseState.hmsAppID != '')) {
      url =
          'https://appgallery.cloud.huawei.com/marketshare/app/C${ProBaseState.hmsAppID}';
    } else {
      url =
          'https://play.google.com/store/apps/details?id=${Constant.packageName}';
    }
  } else {
    url = 'https://itunes.apple.com/us/app/id${ProBaseState.iosAppID}?mt=8';
  }

  if (await canLaunch(url)) {
    print('opening: $url');
    await launch(url);
  }
}

void makePhoneCall(String phoneNumber) {
  if (phoneNumber != null) {
    phoneNumber = phoneNumber.replaceAll(' ', '');
    if (Platform.isAndroid) {
      launch('tel:$phoneNumber}');
    } else {
      launch('tel://$phoneNumber');
    }
  }
}

void makePhoneCallToCallCenter(BuildContext context, {String number = ''}) {
  if (Platform.isAndroid) {
    launch('tel:${number}');
  } else {
    launch('tel://${number.replaceAll(' ', '') ?? number}');
  }
}

Future<File> downloadFile(String url, String filename) async {
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

void exitApp() async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}


Future<bool> showConfirmationWithoutTitle(BuildContext context, String message, {VoidCallback confirm, actionLabel = 'OK'}) async {
  // flutter defined function
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: new Text(actionLabel),
            onPressed: () {
              Navigator.of(context).pop(true);
              if(confirm != null){
                confirm();
              }
            },
          ),
        ],
      );
    },
  ) ?? false;
}

Future<bool> showConfirmationWithTitle(BuildContext context, String title, String message, {VoidCallback confirm, actionLabel = 'OK',
  bool autoPop = true,}) async {
  // flutter defined function
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: new Text(actionLabel),
            onPressed: () {
              if (autoPop) {
                Navigator.of(context).pop(true);
              }
              if (confirm != null) {
                confirm();
              }
            },
          ),
        ],
      );
    },
  ) ??
      false;
}
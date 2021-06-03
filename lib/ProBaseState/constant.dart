import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:OEGlobal/language/app_language.dart';
import 'package:OEGlobal/language/label_util.dart';

//ThemeColor
const themePurple = Color(0xFF932A91);
const themeDarkPurple = Color(0xFF341234);
const themeGrey = Color(0xFF707070);
const themeWhite = Color(0xFFF7F7F7);
const themeBlack = Color(0xFF000000);
const themeLightGrey = Color(0xFFC7C7C7);
const themeLightPurple = Color(0xFFDEBEDE);
const themeGreen = Color(0xFF00B1A1);
const themePink = Color(0xFFF8B2AA);
const themeRed = Color(0xFFC90000);
const themeBlue = Color(0xFF09C2F3);
const themeLightGreen = Color(0xFF64BC26);
const themeLightBlue = Color(0xFF05C3DD);

Map<int, Color> color = {
  50:  Color.fromRGBO(147, 42, 145, .1),
  100: Color.fromRGBO(147, 42, 145, .2),
  200: Color.fromRGBO(147, 42, 145, .3),
  300: Color.fromRGBO(147, 42, 145, .4),
  400: Color.fromRGBO(147, 42, 145, .5),
  500: Color.fromRGBO(147, 42, 145, .6),
  600: Color.fromRGBO(147, 42, 145, .7),
  700: Color.fromRGBO(147, 42, 145, .8),
  800: Color.fromRGBO(147, 42, 145, .9),
  900: Color.fromRGBO(147, 42, 145, 1),
};
MaterialColor themePurpleSwatch = MaterialColor(0xFF932A91, color);

//API
//const endPoint = 'https://driver-roger.testlab360.com/v1/';
var endPoint = 'https://driver-api.roger.com.my';
const apiVersion = '/v1/';

// to get the endpoint for staging and production environment
const endPointUrl = 'https://endpoint.roger.com.my/endpoints';

const api_version = "1.0.0";
const encrypt_response = "1";
const acceptHeader = "application/json";
const contentHeader = 'application/x-www-form-urlencoded';
const multipartHeader = 'multipart/form-data';
const versionType = 'app';
//General Message
const ConnectErr = 'You may experiencing connection issue';
const Test_Title = 'This is a test Title';
const Test_Message =
    'Lorem test text, this message is a Lorem testing message to test the UI in different length situation.';

//General Error Code
const ForceUpdate = 100020;
const TokenExpired = 401;
const LabelUpdate = 101020;

var packageName = '';
var version = '';
var deviceId = '';
var platform = '';
var locale = 'en';
var localeVersion = '1.0.0';
var labelVersion = '0.0.0';
var languageCode = '';
var audio = 0;
var audioHeight = 85.0;

var googleApiKey = 'AIzaSyArUIWzNvSv-cj2awcUapj7oxef0BzKLF0';

// Social Login
/*final FacebookLogin facebookSignIn = new FacebookLogin();
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);*/

SharedPreferences _prefs;

Future preferenceInit() async {
  _prefs = await SharedPreferences.getInstance();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.androidId;
    platform = 'android';
    //directory = await getExternalStorageDirectory();
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor;
    //ios_version = iosInfo.systemVersion;
    platform = 'ios';
    //directory = await getApplicationDocumentsDirectory();
  }
  LabelUtil labelUtil = LabelUtil.instance;
  labelVersion = await labelUtil.labelVersion;
  print('label version: $labelVersion');
  languageCode = await AppLanguage().fetchLanguageCode();
  print('language code: $languageCode');
}

void clearPref() {
  _prefs.clear();
}

bool isLogin = accessToken != null && accessToken != '';

// set preferences for Access Token
const Pref_Token = 'AccessToken';
const Pref_FirstTime = 'FirstTime';
const Pref_Course = 'Course';
const Pref_Pause = 'Pause';
const Pref_AudioImg = 'AudioImg';
const Pref_AudioName = 'AudioName';
const Pref_AudioAuthor = 'Audio';

String get accessToken {
  return _prefs.getString(Pref_Token);
}

set accessToken(String token) {
  _setAccessToken(token);
}

void _setAccessToken(String token) async {
  await _prefs.setString(Pref_Token, token);
}

int get firstTime{
  return _prefs.getInt(Pref_FirstTime) ?? 0;
}

set firstTime(int firstTime){
  _setFirstTime(firstTime);
}

void _setFirstTime(int firstTime) async {
  await _prefs.setInt(Pref_FirstTime, firstTime);
}

int get course{
  return _prefs.getInt(Pref_Course) ?? 0;
}

set course(int course){
  _setCourse(course);
}

void _setCourse(int course) async {
  await _prefs.setInt(Pref_Course, course);
}

int get pause{
  return _prefs.getInt(Pref_Pause) ?? 0;
}

set pause(int pause){
  _setPause(pause);
}

void _setPause(int pause) async {
  await _prefs.setInt(Pref_Pause, pause);
}

String get audioImage {
  return _prefs.getString(Pref_AudioImg);
}

set audioImage(String img) {
  _setAudioImage(img);
}

void _setAudioImage(String img) async {
  await _prefs.setString(Pref_AudioImg, img);
}

String get audioName {
  return _prefs.getString(Pref_AudioName);
}

set audioName(String name) {
  _setAudioName(name);
}

void _setAudioName(String name) async {
  await _prefs.setString(Pref_AudioName, name);
}

String get audioAuthor {
  return _prefs.getString(Pref_AudioAuthor);
}

set audioAuthor(String author) {
  _setAudioAuthor(author);
}

void _setAudioAuthor(String author) async {
  await _prefs.setString(Pref_AudioAuthor, author);
}

// String getFullAddressFromGeolocatorPlace(Placemark placemark) {
//   String address = '';
//   if (placemark.name == placemark.thoroughfare) {
//     address = '${placemark.name}, '
//         '${placemark.postalCode}, ${placemark.locality}, '
//         '${placemark.administrativeArea}, ${placemark.country}';
//   } else {
//     address = '${placemark.name}, ${placemark.thoroughfare}, '
//         '${placemark.postalCode}, ${placemark.locality}, '
//         '${placemark.administrativeArea}, ${placemark.country}';
//   }
//
//   if (address.startsWith(',')) {
//     address = address.replaceFirst(',', '');
//   }
//   address = address.replaceAll(', ,', ',');
//   address = address.replaceAll(', ,', ',');
//
//   return address ?? '';
// }

// set preferences for DBVersion.
const Pref_DB_Version = "DBversion";

set currentDBVersion(int version) {
  _setDBVersion(version);
}

void _setDBVersion(int version) async {
  await _prefs.setInt(Pref_DB_Version, version);
}

int get currentDBVersion {
  return _prefs.getInt(Pref_DB_Version) ?? 0;
}

// Future<bool> requestLocationService() async {
//   Location location = new Location();
//
//   bool _serviceEnabled = await location.serviceEnabled();
//   // if (!_serviceEnabled) {
//   //   _serviceEnabled = await location.requestService();
//
//   //   return _serviceEnabled;
//   // }
//
//   return _serviceEnabled;
// }

// Future<bool> requestLocationPermission() async {
//   Location location = new Location();
//
//   PermissionStatus _permissionGranted;
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//
//     if (_permissionGranted == PermissionStatus.denied ||
//         _permissionGranted == PermissionStatus.deniedForever) {
//       return false;
//     } else {
//       return true;
//     }
//   } else if (_permissionGranted == PermissionStatus.deniedForever) {
//     return false;
//   } else {
//     return true;
//   }
// }

/*Future<bool> requestLocationService() async {
  Location location = new Location();

  bool _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();

    return _serviceEnabled;
  }

  return _serviceEnabled;
}

Future<bool> requestLocationPermission() async {
  Location location = new Location();

  PermissionStatus _permissionGranted;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();

    if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      return false;
    } else {
      return true;
    }
  } else if (_permissionGranted == PermissionStatus.deniedForever) {
    return false;
  } else {
    return true;
  }
}

Future<bool> requestCameraStoragePermission() async {
  Map<PermissionManager.Permission, PermissionManager.PermissionStatus>
      statuses = await [
    PermissionManager.Permission.camera,
    PermissionManager.Permission.storage,
  ].request();

  bool isAllGranted = true;
  statuses.forEach((key, value) {
    if (!value.isGranted) {
      isAllGranted = false;
    }
  });

  return isAllGranted;
}*/

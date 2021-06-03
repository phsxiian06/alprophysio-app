import 'dart:async';
import 'dart:io';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:alpro_physio/model/response.dart';
import 'package:alpro_physio/ProBaseState/export.dart';

typedef OnSuccess = void Function(String message);
typedef OnFail = bool Function(String code, String message);
typedef OnGenericCallBack = void Function(String message, dynamic result);

enum STATUS { FAILED, SUCCESS }

class SocialData {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  //google or facebook
  final bool isFacebook;
  final bool isApple;

  SocialData(this.id, this.name, this.email, this.imageUrl, this.isFacebook,
      this.isApple);
}

void _generalErrorHandling(int code) {
  if (code == TokenExpired) {
    accessToken = '';
  }
}

enum HttpMethod { get, post, put, patch, delete, multipart }
enum HeaderType { none, standard, authorized }

class RequestTask {
  final String urlPath;
  final Map<String, String> parameter;
  final HeaderType headerType;
  final List<File> files;
  final String fileField;
  final bool forceFileArray;

  const RequestTask({
    this.urlPath,
    this.parameter,
    this.headerType,
    this.files,
    this.fileField,
    this.forceFileArray,
  });

  factory RequestTask.set(
      String path, Map<String, String> body, HeaderType headerType,
      {List<File> files, String fileField, bool forceFileArray = false}) {
    return RequestTask(
      urlPath: path,
      parameter: body,
      headerType: headerType,
      files: files ?? [],
      fileField: fileField,
      forceFileArray: forceFileArray,
    );
  }
}

class RequestException implements Exception {
  final int code;
  final String errorMessage;

  RequestException(this.code, this.errorMessage);
}

Future<Response<T>> requestFilter<T extends Data>(
    RequestTask request, HttpMethod httpMethod,
    {bool requestRaw = false, bool requestEndpointUrl = false}) async {
  var url = requestRaw
      ? request.urlPath
      : requestEndpointUrl
          ? endPointUrl
          : "$endPoint$apiVersion" + request.urlPath;
  var body = request.parameter;
  var header = request.headerType == HeaderType.none
      ? {}
      : request.headerType == HeaderType.authorized
          ? {
              HttpHeaders.authorizationHeader: "Bearer $accessToken",
              HttpHeaders.acceptHeader: acceptHeader,
              HttpHeaders.contentTypeHeader: httpMethod == HttpMethod.multipart
                  ? multipartHeader
                  : contentHeader,
              'App-Version': version,
              'Os-Type': platform,
              "Version-Type": versionType,
              'Label-Version': labelVersion,
            }
          : {
              HttpHeaders.acceptHeader: acceptHeader,
              HttpHeaders.contentTypeHeader: contentHeader,
              'App-Version': version,
              'Os-Type': platform,
              "Version-Type": versionType,
              'Label-Version': labelVersion,
            };

  final timeoutDuration = Duration(seconds: 60);

  http.Response response;
  print('-----\nurl: $url');
  print('header: $header');
  print('parameter: $body');
  print('-----');

  switch (httpMethod) {
    case HttpMethod.post:
      response = await http
          .post(url, body: body, headers: header)
          .timeout(timeoutDuration)
          .catchError((onError) {
        print('onError: $onError');
        //throw RequestException(-1, Constant.ConnectErr);
        throw RequestException(-1, onError.toString());
      });
      break;
    case HttpMethod.get:
      response = await http
          .get(url, headers: header)
          .timeout(timeoutDuration)
          .catchError((onError) {
        //throw RequestException(-1, Constant.ConnectErr);
      });
      break;
    case HttpMethod.delete:
      response = await http
          .delete(url, headers: header)
          .timeout(timeoutDuration)
          .catchError((onError) {
        //throw RequestException(-1, Constant.ConnectErr);
      });
      break;
    case HttpMethod.multipart:
      final multipartRequest = http.MultipartRequest('POST', Uri.parse(url));
      multipartRequest.headers.addAll(header);
      multipartRequest.fields.addAll(body);
      if (request.files.length > 0) {
        if (request.files.length > 1 || request.forceFileArray) {
          for (int i = 0; i < request.files.length; i++) {
            File file = request.files[i];
            int length = await file.length();
            multipartRequest.files.add(http.MultipartFile(
              request.fileField + '[$i]',
              file.openRead(),
              length,
              filename: path.basename(file.path),
            ));
          }
        } else {
          File file = request.files[0];
          int length = await file.length();
          multipartRequest.files.add(http.MultipartFile(
            request.fileField,
            file.openRead(),
            length,
            filename: path.basename(file.path),
          ));
        }
      }
      response = await http.Response.fromStream(await multipartRequest.send())
          .catchError((onError) {
        print('multipart.onError $onError');
        throw RequestException(-1, ConnectErr);
      });
      break;
    default:
      response = null;
      break;
  }

  if (response != null) {
    print('done request with response, statusCode: ${response.statusCode}');
    print('Response<T>: $T');
    if (response.statusCode == 200) {
      String byteData = String.fromCharCodes(response.bodyBytes);
      print('byteData: $byteData');
      var rawData = json.jsonDecode(byteData);
      if (requestRaw) {
        return rawData;
      } else {
        Response<T> res = Response<T>.fromJson(rawData);
        print('res.status: $res');
        if (res.status) {
          return res;
        } else {
          throw RequestException(res.code, res.message);
        }
      }
    } else {
      _generalErrorHandling(response.statusCode);
      throw RequestException(
          response.statusCode, 'Server Error. Please try again later.');
    }
  } else {
    print('done request without response');
    throw RequestException(-1, ConnectErr);
  }
}

bool shouldTriggerOnFailed(int statusCode) {
  /*if (statusCode == Constant.forceUpdateCode) {
    //
    return false;
  } else if (statusCode == Constant.unauthenticated) {
    //
    return false;
  } else {*/
  return true;
  //}
}
/*
// *sample
void sample(String value1, String value2, OnGenericCallBack onGenericCallBack,
    OnFail onFailed) async {
  var urlpath = "register";
  Map<String, String> body = {
    'key1': value1,
    'key2': value2,
  }; //If you don have body, put null for it.
  var request = RequestTask.set(urlpath, body, HeaderType.standard);
  requestFilter<Data>(request, HttpMethod.post).then((res) {
    return onGenericCallBack(res.message, null);
  }, onError: (exception) {
    if (shouldTriggerOnFailed(exception.code)) {
      onFailed(exception.code, exception.errorMessage);
    }
  });
}*/

/* ---------- Implement Your API Below Here ---------- */

// get endpoint
// Future<Endpoints> getEndPoint(OnFail onFail) async {
//   var request = RequestTask.set('', null, HeaderType.standard);
//   try {
//     Response<Endpoints> response = await requestFilter<Endpoints>(
//         request, HttpMethod.post,
//         requestEndpointUrl: true);
//     return response.data;
//   } catch (e) {
//     onFail(e.code.toString(), e.errorMessage);
//     return null;
//   }
// }

// get label
// Future<Response<LabelData>> getLabel(OnFail onFail) async {
//   LabelUtil labelUtil = LabelUtil.instance;
//   String version = await labelUtil.labelVersion;
//   Map<String, String> body = {
//     'version': version,
//   };
//
//   body.forEach((key, value) {
//     print('key: $key, value: $value');
//   });
//
//   var request = RequestTask.set('config/label', body, HeaderType.standard);
//   try {
//     Response<LabelData> response =
//         await requestFilter<LabelData>(request, HttpMethod.post);
//     return response;
//   } catch (e) {
//     onFail(e.code.toString(), e.errorMessage);
//     return null;
//   }
// }

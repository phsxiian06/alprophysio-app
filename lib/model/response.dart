import 'dart:convert' as jsonConvert;

class Response<T extends Data> {
  final bool status;
  final int code;
  final String message;
  final T data;
  final List<T> datas;
  final int total;

  const Response(
      {this.status,
      this.code,
      this.message,
      this.data,
      this.datas,
      this.total});

  factory Response.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    //print('Response.json: $json');
    var jsonData = json['data'];
    T mData;
    List<T> mDatas;
    switch (T) {
      case AccessToken:
        mData = AccessToken.fromJson(jsonData) as T;
        break;
    }
    return Response<T>(
      status: json['status'],
      code: json['code'],
      message: json.containsKey('message') ? json['message'] : '',
      data: mData,
      datas: mDatas,
      total: json['total'] ?? 0,
    );
  }
}

abstract class Data {
  const Data();
}

class AccessToken extends Data {
  final String accessToken;

  const AccessToken({
    this.accessToken,
  }) : super();

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return AccessToken(
      accessToken: json['access_token'],
    );
  }
}

class BoolResponse extends Data {
  final bool isTrue;

  const BoolResponse({
    this.isTrue,
  }) : super();

  factory BoolResponse.fromJson(Map<String, dynamic> json, String key) {
    if (json == null) return null;

    if (json[key] is bool) {
      return BoolResponse(
        isTrue: json[key],
      );
    } else if (json[key] is int) {
      final value = json[key];
      if (value > 0) {
        return BoolResponse(
          isTrue: true,
        );
      } else {
        return BoolResponse(
          isTrue: false,
        );
      }
    } else {
      return BoolResponse(
        isTrue: false,
      );
    }
  }
}

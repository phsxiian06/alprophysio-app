import 'package:OEGlobal/model/response.dart';

class Label extends Data {
  final String key;
  final String value;

  Label({this.key, this.value});

  factory Label.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Label(
      key: json['key'],
      value: json['value'],
    );
  }
}

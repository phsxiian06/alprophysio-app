import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:alpro_physio/model/label.dart';

class LabelUtil {
  static LabelUtil _instance;
  static List<Label> _labels = List();

  LabelUtil._();

  static LabelUtil get instance {
    if (_instance == null) {
      _instance = LabelUtil._();
    }

    return _instance;
  }

  // write the label into file
  Future<File> writeLabel(String data) async {
    final file = await _labelFile;

    // Write the file.
    final completeFile = file.writeAsString(data);

    // update the label
//    _labels = await labels;

    return completeFile;
  }

  // find label value based on key
  String findValue(String key) {
    return _labels.firstWhere((item) => item.key == key).value;
  }

  // get label version
  Future<String> get labelVersion async {
    try {
      final file = await _labelFile;

      // Read the file.
      String contents = await file.readAsString();

      final parsed = jsonDecode(contents);

      return parsed['latest_version'] ?? '1.0.0';
    } catch (e) {
      print(e);
      return '1.0.0';
    }
  }

  Future<List<Label>> getLabels(String languageCode) async {
    try {
      final file = await _labelFile;

      // Read the file.
      String contents = await file.readAsString();

      final parsed = jsonDecode(contents);

      final parsedLabel = parsed['labels'][languageCode];

//      final labelJA = jsonDecode(rawLabel);

      return parsedLabel.map<Label>((json) => Label.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return List();
    }
  }

  // get document path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // get the label file
  static Future<File> get _labelFile async {
    final path = await _localPath;
    return File('$path/label.txt');
  }
}

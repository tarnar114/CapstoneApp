import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:capstone_app/data/Alert.dart';
import 'package:path_provider/path_provider.dart';

class AlertStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/alarms.txt');
  }

  Future<String> readAlerts() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> writeAlert(String timeInput, List<String> AlertDays) async {
    final file = await _localFile;
    Map<String, dynamic> map1 = {"time": timeInput, "AlertDays": AlertDays};
    var alert = AlertClass.fromJson(map1);
    String json = jsonEncode(alert);
    // Write the file
    return file.writeAsStringSync(json + '\n',
        mode: FileMode.append, flush: true);
  }
}

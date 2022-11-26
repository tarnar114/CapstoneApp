import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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

  // Future<File> writeAlert(String time, List<bool> AlertDays) async {
  //   final file = await _localFile;

  //   // Write the file
  //   return file.writeAsString(time + " "+);
  // }
}

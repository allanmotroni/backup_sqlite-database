import 'dart:io';
import 'package:backup_sqlite_database_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileBaseService {
  final String from;
  final String to;

  FileBaseService(this.from, this.to);

  void copy() async {
    final String dbFolder = await getPath();
    File source1 = File('$dbFolder/$databaseName');

    // const String to = '/storage/emulated/0/SqliteBackup';
    const String to = '/storage/emulated/0';

    //debugPrint('### COPY... From: $from To: $to ###');

    final Directory copyTo = Directory(to);

//bool permission = await requestPermissionHelper(Permission.manageExternalStorage);

    if (await copyTo.exists()) {
      var status = await Permission.storage.status;
      if (status.isGranted) {
        await Permission.storage.request();
      }
      // status = await Permission.manageExternalStorage.status;
      // if (status.isGranted) {
      //   await Permission.manageExternalStorage.request();
      // }

      // status = await Permission.accessMediaLocation.status;
      // if (status.isGranted) {
      //   await Permission.accessMediaLocation.request();
      // }
    } else {
      debugPrint('Not exist');
      if (await Permission.storage.request().isGranted &&
          await Permission.manageExternalStorage.request().isGranted &&
          await Permission.accessMediaLocation.request().isGranted) {
        await copyTo.create();
      } else {
        debugPrint('Give permission');
      }
    }

    final String newPath = "${copyTo.path}/$databaseName";
    await source1.copy(newPath);
  }
}

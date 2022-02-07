//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';

class FileBaseService {
  final String from;
  final String to;

  FileBaseService(this.from, this.to);

  void copy() async {
    debugPrint('### COPY... From: $from To: $to ###');

    // final bool dir =
    //     await Directory('/storage/emulated/0/Android/data').exists();

    // const String from =
    //     "/data/user/0/com.example.backup_sqlite_database_app/databases/backup-sqlite-database.db";
    // File file = File(from);

    // String fileNameWithExtension = basename(from);
    // final String to = "/storage/emulated/0/Android/data/$fileNameWithExtension";

    // File newFile = await file.copy(to);
    // debugPrint('New File path -> ${newFile.path}');
  }
}

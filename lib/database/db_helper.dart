import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quiz_app_flutter/const/const.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> copyDB() async {
  var dbPath = await getDatabasesPath();
  var path = join(dbPath, dbName);
  var exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // copy from assets
    ByteData data = await rootBundle.load(join("assets/db", dbName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print('Database already exists');
  }
  return await openDatabase(path, readOnly: true);
}

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Source {
  // private constructor
  Source._();

  final String dbName = "main.db";
  final String tblName = "counter_tbl";

  static Source getInstance() => Source._();

  Database? _db;

  // create database
  Future<Database?> createDb() async {
    int version = 1;

    //   app data path
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, dbName);

    //   database path
    return await openDatabase(
      dbPath,
      onCreate: (dbPath, version) => dbPath.execute(
          "CREATE TABLE $tblName (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, count INTEGER)"),
      version: version,
    );
  }

  // get database
  Future<Database> getDb() async {
    _db ??= await createDb();
    return _db!;
  }

  // reset database
  Future<bool> resetDb() async {
    Database? tempDb = await getDb();
    int rowAffected = await tempDb.delete(tblName);
    return rowAffected > 0 ? true : false;
  }

  // get
  Future<List<Map<String, dynamic>>> getCounters() async {
    Database? tempDb = await getDb();
    List<Map<String, dynamic>> data = await tempDb.query(tblName);
    return data;
  }

  // insert
  Future<bool> insertCounter() async {
    Database? tempDb = await getDb();
    int rowAffected = await tempDb.insert(tblName, {
      'name': 'counter',
      'count': 0,
    });
    log("new counter added");
    return rowAffected > 0 ? true : false;
  }

  // put [update]
  Future<bool> updateCounter(int id, int count) async {
    Database? tempDb = await getDb();
    int rowAffected = await tempDb.update(
      tblName,
      {
        'count': count,
      },
      where: "id = ?",
      whereArgs: [id],
    );
    log("Counter updated : $count");
    return rowAffected == 1 ? true : false;
  }

  // delete
  Future<bool> deleteCounter(int id) async {
    Database? tempDb = await getDb();

    int rowAffected = await tempDb.delete(
      tblName,
      where: "id = ?",
      whereArgs: [id],
    );
    return rowAffected == 1 ? true : false;
  }
}

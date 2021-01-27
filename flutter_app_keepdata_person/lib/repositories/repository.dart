import 'package:flutter/cupertino.dart';
import 'package:flutter_app_keepdata_person/repositories/database-connection.dart';
import 'package:sqflite/sqlite_api.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  inserData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  selectData(table) async {
    var connection = await database;
    return await connection.query(table);
  }
}

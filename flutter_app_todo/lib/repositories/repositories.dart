import 'package:flutter_app_todo/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

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

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  selectData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: "id=?", whereArgs: [data['id']]);
  }

  deleteData(table, itemid) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id=$itemid");
  }
}

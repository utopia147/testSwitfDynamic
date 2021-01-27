import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_user_sqflite');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreatingDatabase,
    );
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    var sql =
        "CREATE TABLE user(citizenid INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT , lastname TEXT ,  nickname TEXT , age INTEGER ,bday TEXT ,email TEXT , tel INTEGER)";
    await database.execute(sql);
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreatingDatabase,
    );
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    var sql =
        "CREATE TABLE todolist(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , detail TEXT ,)";
    await database.execute(sql);
  }
}

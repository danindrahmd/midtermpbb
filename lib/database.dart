import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class DBProvider {
  static late Database _database;

  static Future<void> initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'task_manager_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTask(Task task) async {
    await _database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }
}

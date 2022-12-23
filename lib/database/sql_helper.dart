import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {

  //CREATE A TABLE IN THE DATABASE
  static Future<void> createTables(sql.Database database) async {
    await database.execute(''' CREATE TABLE todosTask (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    desc TEXT,
    createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) ''');
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //ADD
  static Future<int> addTodoTask(String title, String? desc) async {
    final db = await SqlHelper.db();

    final data = {
      'title' : title,
      'desc' : desc,
      'createAt' : DateTime.now().toString()
    };

    final id = await db.insert('todosTask', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //READ getting all the task from the database
  static Future<List<Map<String, dynamic>>> getTodosTask() async {
    final db = await SqlHelper.db();
    return db.query('todosTask', orderBy: 'id');
  }

  //READ get one task from the database
  static Future<List<Map<String, dynamic>>> getTodoTask(int id) async {
    final db = await SqlHelper.db();
    return db.query('todosTask', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  //UPDATE
  static Future<int> editTodoTask(
      int id, String title, String? desc) async {
    final db = await SqlHelper.db();

    final data = {
      'title' : title,
      'desc' : desc,
      'createAt' : DateTime.now().toString()
    };

    final result =
    await db.update('todosTask', data, where: 'id = ?', whereArgs: [id]);
    return result;

  }

  //DELETE
  static Future<void> deleteTodoTask(int id) async {
    final db = await SqlHelper.db();

    try {
      await db.delete('todosTask', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting the task: $err');
    }
  }

}
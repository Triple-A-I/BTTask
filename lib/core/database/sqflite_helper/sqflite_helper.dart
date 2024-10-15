import 'package:sqflite/sqflite.dart';

import '../../../feature/task/data/model/task_model.dart';

class SqfliteHelper {
  late Database db;
  //1. create DB
  //2.create table
  //3.CRUD => create - read - update - delete

  //! initDatabase
  Future<void> intiDB() async {
    //step 1 => Create database
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        //step 2 => create table
        return await db.execute('''
      CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT ,
        title TEXT,
        note TEXT,
        date TEXT,
        startTime TEXT,
        endTime TEXT,
        color INTEGER,
        isCompleted INTEGER )
      ''').then(
          (value) => print('DB created successfully'),
        );
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value);
  }

  //!get
  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //! insert
  Future<int> insertToDB(TaskModel model) async {
    await intiDB();
    return await db.rawInsert('''
      INSERT INTO Tasks( 
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
         VALUES
         ('${model.title}','${model.note}','${model.date}','${model.startTime}',
       '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }

  //! update
  Future<int> updatedDB(int id) async {
    await intiDB();

    return await db.rawUpdate('''
    UPDATE Tasks
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
  }

  //! delete
  Future<int> deleteFromDB(int id) async {
    await intiDB();

    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }

  //! Search tasks
  Future<List<Map<String, dynamic>>> searchTasks(String query) async {
    await intiDB();
    return await db.rawQuery('''
      SELECT * FROM Tasks 
      WHERE title LIKE ? OR note LIKE ?
    ''', ['%$query%', '%$query%']);
  }
}

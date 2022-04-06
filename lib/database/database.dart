import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:copy_phrase/models/phrase.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String tableName = 'phrase_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPhrase = 'phrase';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  // データベースの準備
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todolist_flutter.db';
    final db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  // テーブルを作成する
  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colPhrase TEXT)");
  }

  // 新規タスクを追加する
  Future<int> insertPhrase(Phrase task) async {
    Database? db = await this.db;
    final int result = await db!.insert(tableName, task.phraseMap());
    return result;
  }

  // タスク一覧を取得する
  Future<List<Phrase>> getPhraseList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> taskMapList = await db!.query(tableName);

    final List<Phrase> taskList = [];

    for (var map in taskMapList) {
      taskList.add(Phrase().fromMap(map));
    }

    return taskList;
  }

  // タスクを更新する
  Future<int> updatePhrase(Phrase task) async {
    Database? db = await this.db;
    final int result = await db!.update(tableName, task.phraseMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  // タスクの削除
  Future<int> deletePhrase(int id) async {
    Database? db = await this.db;
    final int result =
        await db!.delete(tableName, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
  
  // タスクの削除
  Future<int> deletePhraseAll() async {
    Database? db = await this.db;
    final int result =
        await db!.delete(tableName);
    return result;
  }
}

import 'dart:async';
import 'dart:io';
import 'package:ikigai/classes/anime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  static final _databaseName = "ikigaiDB.db";
  static final _databaseVersion = 1;

  static final table = 'Anime';
  
  static final columnId = 'malId';
  static final columnTitle = 'title';
  static final columnOption = 'option';
  static final columnUrl = 'url';
  static final columnImageUrl = 'imageUrl';
  static final columnScore = 'score';

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnTitle TEXT,"
        "$columnOption INTEGER,"
        "$columnUrl TEXT,"
        "$columnImageUrl TEXT,"
        "$columnScore FLOAT"
        ")",
      );
    });
  }

  newAnime(Anime newAnime) async {
    final db = await database;
    var res = await db.insert(table, newAnime.toMap());
    return res;
  }

  updateAnime(Anime newAnime) async {
    final db = await database;
    var res = await db.update(table, newAnime.toMap(),
        where: "$columnId = ?", whereArgs: [newAnime.malId]);
    return res;
  }

  getAnime(int malId) async {
    final db = await database;
    var res = await db.query(table, where: "$columnId = ?", whereArgs: [malId]);
    return res.isNotEmpty ? Anime.fromMap(res.first) : null;
  }

  Future<List<Anime>> getAllAnimes() async {
    final db = await database;
    var res = await db.query(table);
    List<Anime> list =
        res.isNotEmpty ? res.map((c) => Anime.fromMap(c)).toList() : [];
    return list;
  }

  deleteAnime(int malId) async {
    final db = await database;
    return db.delete(table, where: "$columnId = ?", whereArgs: [malId]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $table");
  }
}

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

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ikigaiDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Anime ("
        "malId INTEGER PRIMARY KEY,"
        "title TEXT,"
        "option INTEGER,"
        "url TEXT,"
        "imageUrl TEXT,"
        "score FLOAT"
        ")",
      );
    });
  }

  newAnime(Anime newAnime) async {
    final db = await database;
    var res = await db.insert("Anime", newAnime.toMap());
    return res;
  }

  updateAnime(Anime newAnime) async {
    final db = await database;
    var res = await db.update("Anime", newAnime.toMap(),
        where: "malId = ?", whereArgs: [newAnime.malId]);
    return res;
  }

  getAnime(int malId) async {
    final db = await database;
    var res = await db.query("Anime", where: "malId = ?", whereArgs: [malId]);
    return res.isNotEmpty ? Anime.fromMap(res.first) : null;
  }

  Future<List<Anime>> getAllAnimes() async {
    final db = await database;
    var res = await db.query("Anime");
    List<Anime> list =
        res.isNotEmpty ? res.map((c) => Anime.fromMap(c)).toList() : [];
    return list;
  }

  deleteAnime(int malId) async {
    final db = await database;
    return db.delete("Anime", where: "malId = ?", whereArgs: [malId]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Anime");
  }
}

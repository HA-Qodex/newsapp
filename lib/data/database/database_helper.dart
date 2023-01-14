import 'package:newsapp/data/models/news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  final String tableName = 'news_table';
  static const String id = '_id';

  static const String title = 'title';
  static const String description = 'description';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';


  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database?> get database async{
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('qfl.db');
      return _database;
    }
  }

  Future<Database> _initDB(String databaseName) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version)async {
    await db.execute('''
      CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT NOT NULL,
      $description TEXT NOT NULL,
      $urlToImage TEXT NOT NULL,
      $publishedAt TEXT NOT NULL
      )
      '''
    );
  }

  Future<int?> insertData(NewsModel newsModel)async{
    final db = await instance.database;

      final sqlQuery = '''
      INSERT INTO $tableName(
      $title,
      $description,
      $urlToImage,
      $publishedAt
      )
      VALUES(?,?,?,?)''';
      List<dynamic> params = [
        newsModel.title,
        newsModel.description,
        newsModel.urlToImage,
        newsModel.publishedAt.toString()
      ];
      final data = await db!.rawInsert(sqlQuery, params);
      return data;
  }

  Future<List<NewsModel>> fetchData()async{
    final db = await instance.database;

    final sqlQuery = '''SELECT * FROM $tableName''';
    final data = await db!.rawQuery(sqlQuery);
    List<NewsModel> productList = <NewsModel>[];

    for(final node in data){
      final list = NewsModel.fromDB(node);
      productList.add(list);
    }
    return productList;
  }

  Future<int> deleteData(NewsModel newsModel)async{
    final db = await instance.database;
    return await db!.delete(tableName, where: "$title = ?", whereArgs: [newsModel.title]);
  }

  Future<void> deleteTableData()async{
    final db = await instance.database;

    final sqlQuery = '''DELETE FROM $tableName''';
    await db!.rawQuery(sqlQuery);
  }

}
import 'package:newsapp/models/news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String tableName = 'news_table';
  static const String id = 'id';

  static const String title = 'title';
  static const String description = 'description';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';

  DatabaseHelper._init();

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDB('news.db');

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $title TEXT NOT NULL,
    $description TEXT NOT NULL,
    $urlToImage TEXT NOT NULL,
    $publishedAt TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertData(NewsModel newsModel) async {
    final db = await instance.database;
    final insert = await db.insert(tableName, {
      'title': newsModel.title,
      'description': newsModel.description,
      'urlToImage': newsModel.urlToImage,
      'publishedAt': newsModel.publishedAt.toString(),
    });
    return insert;
  }

  Future<List<NewsModel>> fetchNews() async {
    final db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(
      tableName,
      columns: ['*'],
    );
    final newsList = <NewsModel>[];

    for (var element in data) {
      newsList.add(NewsModel(
          title: element['title'],
          description: element['description'],
          urlToImage: element['urlToImage'],
          publishedAt: element['publishedAt']));
    }
    return newsList;
  }
}

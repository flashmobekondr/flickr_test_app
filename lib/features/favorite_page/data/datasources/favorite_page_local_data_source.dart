
import 'package:flickr_test_app/features/search_page/data/model/search_page_post_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
enum PostAction {cache, delete, get}

abstract interface class FavoritePageLocalDataSource {
  Future<List<PostModel>?> deleteAddOrGetLocalPosts ({PostModel? post, required PostAction action});
}

class FavoritePageLocalDataSourceImpl implements FavoritePageLocalDataSource {
  FavoritePageLocalDataSourceImpl();

  final _databaseName = "favorite_database.db";
  final _databaseVersion = 1;
  final _table = 'favorite';


  @override
  Future<List<PostModel>?> deleteAddOrGetLocalPosts({PostModel? post, required PostAction action}) async {
    try {
      switch (action) {
        case PostAction.get :
          final favoritePosts = await _getPost();
          return favoritePosts;
        case PostAction.cache :
          await _insertPost(post!);
          return null;
        case PostAction.delete :
          await _deletePost(post!.id);
          return null;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
            '''CREATE TABLE $_table(
            id TEXT PRIMARY KEY,
            owner TEXT,
            secret TEXT,
            server TEXT,
            farm INTEGER,
            title TEXT,
            ispublic INTEGER,
            isfriend INTEGER,
            isfamily INTEGER,
            )
            '''
        );
      },
      version: _databaseVersion,
    );
  }

  Future<void> _insertPost (PostModel post) async {
    final db = await _getDatabase();

    await db.insert(
      _table,
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> _deletePost(String id) async {
    final db = await _getDatabase();

    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<List<PostModel>> _getPost() async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_table);

    return List.generate(maps.length, (index) {
      return PostModel.fromJson(maps[index]);
    });
  }
}
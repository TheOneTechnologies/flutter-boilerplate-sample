import 'package:flutter_naming_convention/data/local_database/models/news/news.dart';
import 'package:flutter_naming_convention/data/local_database/repository/news_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter_naming_convention/data/local_database/constants/database_constants.dart';

class BaseNewsRepository extends NewsRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store(DataBaseConstants.newsStore);

  @override
  Future<int> insertNews(News news) async {
    return await _store.add(_database, news.toMap()) as int;
  }

  @override
  Future updateNews(News news) async {
    await _store.record(news.id).update(_database, news.toMap());
  }

  @override
  Future deleteNews(int newsId) async {
    await _store.record(newsId).delete(_database);
  }

  @override
  Future<List<News>> getAllNews() async {
    List<RecordSnapshot<dynamic, dynamic>> snapshots =
        await _store.find(_database);
    return snapshots
        .map((snapshot) => News.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}

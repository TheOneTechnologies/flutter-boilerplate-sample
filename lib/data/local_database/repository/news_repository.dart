import 'package:flutter_naming_convention/data/local_database/models/news/news.dart';

abstract class NewsRepository {
  Future<int> insertNews(News news);

  Future updateNews(News news);

  Future deleteNews(int newsId);

  Future<List<News>> getAllNews();
}

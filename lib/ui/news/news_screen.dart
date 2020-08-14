import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/local_database/models/news/news.dart';
import 'package:flutter_naming_convention/data/local_database/repository/news_repository.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:flutter_naming_convention/utils/util.dart';
import 'package:flutter_naming_convention/widgets/custom_toolbar_widget.dart';
import 'package:get_it/get_it.dart';

class NewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsList();
  }
}

class _NewsList extends State<NewsList> {
  NewsRepository _newsRepository = GetIt.I.get();
  List<News> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: myView(),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('addNewsKey'),
        child: Icon(Icons.add, color: AppColors.primaryColor),
        backgroundColor: AppColors.white,
        onPressed: _addNews,
      ),
    );
  }

  Widget myView() {
    return Container(
      decoration: Util.commonBackground(),
      child: Column(
        children: <Widget>[
          CustomToolbar(
            title: AppTranslations.of(context).text(Strings.strNews),
            isDashboardVisible: false,
            isBackVisible: true,
          ),
          newsListView(),
        ],
      ),
    );
  }

  Widget newsListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          News news = _newsList[index];
          return ListTile(
            title: Text(news.name, style: TextStyle(color: Colors.white)),
            subtitle: Text(
                AppTranslations.of(context).text(Strings.strHits) +
                    ' : ${news.hits}',
                style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              key: Key('deleteNewsKey'),
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNews(news),
            ),
            leading: IconButton(
              key: Key('updateNewsKey'),
              color: Colors.white,
              icon: Icon(Icons.thumb_up),
              onPressed: () => _editNews(news),
            ),
          );
        },
      ), // And rest of them in ListView
    );
  }

  void _loadNewsList() async {
    List<News> newsList = await _newsRepository.getAllNews();
    setState(() => _newsList = newsList);
  }

  void _addNews() async {
    List<String> list = ['Google', 'Weather', 'Local']..shuffle();
    String name = 'Title ${list.first} news';
    News newNews = News(name: name, hits: 0);
    await _newsRepository.insertNews(newNews);
    _loadNewsList();
  }

  void _deleteNews(News news) async {
    await _newsRepository.deleteNews(news.id);
    _loadNewsList();
  }

  void _editNews(News news) async {
    News updatedNews = news.copyWith(hits: news.hits + 1);
    await _newsRepository.updateNews(updatedNews);
    _loadNewsList();
  }
}

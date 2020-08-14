import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter_naming_convention/data/local_database/repository/base_news_repository.dart';
import 'package:flutter_naming_convention/data/local_database/repository/news_repository.dart';
import 'package:flutter_naming_convention/data/local_database/constants/database_constants.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
  }

  static _registerRepositories(){
    GetIt.I.registerLazySingleton<NewsRepository>(() => BaseNewsRepository());
    debugPrint('after register repository');
  }

  static Future _initSembast() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    String databasePath = join(appDir.path, DataBaseConstants.dbName);
    Database database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }
}
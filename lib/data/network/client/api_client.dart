import 'package:dio/dio.dart';
import 'package:flutter_naming_convention/data/network/model/album_model/album_list_model.dart';
import 'package:flutter_naming_convention/data/network/model/login_model/login.dart';
import 'package:retrofit/retrofit.dart';

import '../apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Apis.login)
  Future<LoginResponse> login(
    @Body() LoginBody loginBody,
  );

  @GET(Apis.album)
  Future<AlbumListModel> album(@Header('Authorization') String header,
      @Query('pageNumber') int pageNumber, @Query('pageSize') int pageSize);

  @DELETE('${Apis.album}/{id}')
  Future<dynamic> deleteAlbumItem(
      @Header('Authorization') String header, @Path('id') int id);
}

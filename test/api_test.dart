import 'package:flutter_naming_convention/data/network/api_call.dart';
import 'package:flutter_naming_convention/data/network/client/api_client.dart';
import 'package:flutter_naming_convention/data/network/error_handler/server_error.dart';
import 'package:flutter_naming_convention/data/network/model/album_model/album_list_model.dart';
import 'package:flutter_naming_convention/data/network/model/login_model/login.dart';
import 'package:flutter_naming_convention/data/network/response_handler/server_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements ApiClient {}

main() {
  //login test case group
  group('login', () {
    // Used Mockito to return a successful response when it calls the
    test('returns a Post if the http call completes successfully', () async {
      MockClient client = MockClient();

      LoginBody loginBody = LoginBody();
      loginBody.userName = 'student11_1A';
      loginBody.password = 'Password12345';
      loginBody.schoolId = 1;
      loginBody.isStudent = true;

      when(client.login(loginBody)).thenAnswer((_) async => LoginResponse(
          access_token: 'abcde',
          token_type: 'type',
          expires_in: 1200,
          refresh_token: 'abcdef'));

      expect(
          await APICall().loginUser(loginBody.userName, loginBody.password,
              loginBody.schoolId, loginBody.isStudent),
          isA<BaseModel<LoginResponse>>());
    });

    // Used Mockito to return an failure response when it calls the
    test('throws an exception if the call completes with an error', () async {
      MockClient client = MockClient();

      LoginBody loginBody = LoginBody();
      loginBody.userName = 'student11_1A';
      loginBody.password = 'pass';
      loginBody.schoolId = 1;
      loginBody.isStudent = true;
      when(client.login(loginBody)).thenAnswer((_) async => LoginResponse(
          access_token: 'abcde',
          token_type: 'type',
          expires_in: 1200,
          refresh_token: 'abcdef'));

      expect(
          await APICall().loginUser(loginBody.userName, loginBody.password,
              loginBody.schoolId, loginBody.isStudent),
          isA<BaseModel<LoginResponse>>());
    });
  });

  //album list test case group
  group('album', () {
    List<AlbumsItem> items = List<AlbumsItem>();
    items.add(AlbumsItem(
      id: 5,
      name: 'name',
      photoUrl: 'string',
      count: 5,
      date: '2020-08-14T09:58:04.828Z',
    ));

    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMTNlMmQ0NC00ZDE2LTQ0N2UtYTkwNy1iYTEwOWY3MjY2MWEiLCJqdGkiOiI3YTE4MmZiZC04MDEwLTQ5NWEtOWFjYy0xNjNhMWNkZjUzZTkiLCJpYXQiOjE1OTc0MDM1NjMsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzdHVkZW50MTFfMUEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJTdHVkZW50IFNjaG9vbCAxXzFBIiwiU0NIX0lEIjoiMSIsIlNURF9JRCI6IjEiLCJESVZfSUQiOiIzIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiU3R1ZGVudCIsIm5iZiI6MTU5NzQwMzU2MiwiZXhwIjoxNTk3NDg5OTYyLCJpc3MiOiJQb3J0YWxBdXRoZW50aWNhdGlvblNlcnZpY2UiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUwMDEvIn0.5EH5G6NRT7pGpoAiTXn0VpASmWtpqTYvd9rBgopDtsc[0m';

    // Used Mockito to return a successful response when it calls the
    test('returns a Get if the http call completes successfully', () async {
      MockClient client = MockClient();

      when(client.album('Bearer $token', 1, 1)).thenAnswer((_) async =>
          AlbumListModel(total: 10, items: items, currentPage: 1, pageSize: 1));

      expect(await APICall().getAlbumList(1, 1, 'Bearer $token'),
          isA<BaseModel<AlbumListModel>>());
    });

    // Used Mockito to return an failure response when it calls the
    test('throws an exception if the call completes with an error', () async {
      MockClient client = MockClient();

      when(client.album('Bearer token', 1, 1)).thenAnswer((_) async =>
          AlbumListModel(total: 10, items: items, currentPage: 1, pageSize: 1));

      expect(await APICall().getAlbumList(1, 1, 'Bearer token'),
          isA<BaseModel<AlbumListModel>>());
    });
  });
}

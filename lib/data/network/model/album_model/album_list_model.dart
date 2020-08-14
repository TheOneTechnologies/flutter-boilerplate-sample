
import 'package:json_annotation/json_annotation.dart';
part 'album_list_model.g.dart';

@JsonSerializable()
class AlbumBody{
  int pageNumber;
  int pageSize;

  AlbumBody({this.pageNumber, this.pageSize});

  factory AlbumBody.fromJson(Map<String, dynamic> json) => _$AlbumBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumBodyToJson(this);
}

@JsonSerializable()
class AlbumListModel {
  int total;
  List<AlbumsItem> items;
  int currentPage;
  int pageSize;
  String dateis;
  int countdatewise;

  AlbumListModel({this.total, this.items, this.currentPage, this.pageSize});

  factory AlbumListModel.fromJson(Map<String, dynamic> json) => _$AlbumListModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumListModelToJson(this);

}

@JsonSerializable()
class AlbumsItem {
  int id;
  String name;
  String photoUrl;
  int count;
  String date;
  bool isSeleted = false;

  AlbumsItem({this.id, this.name, this.photoUrl, this.count, this.date});

  factory AlbumsItem.fromJson(Map<String, dynamic> json) => _$AlbumsItemFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumsItemToJson(this);

}

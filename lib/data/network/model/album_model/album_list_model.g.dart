// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumBody _$AlbumBodyFromJson(Map<String, dynamic> json) {
  return AlbumBody(
    pageNumber: json['pageNumber'] as int,
    pageSize: json['pageSize'] as int,
  );
}

Map<String, dynamic> _$AlbumBodyToJson(AlbumBody instance) => <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };

AlbumListModel _$AlbumListModelFromJson(Map<String, dynamic> json) {
  return AlbumListModel(
    total: json['total'] as int,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : AlbumsItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['currentPage'] as int,
    pageSize: json['pageSize'] as int,
  )
    ..dateis = json['dateis'] as String
    ..countdatewise = json['countdatewise'] as int;
}

Map<String, dynamic> _$AlbumListModelToJson(AlbumListModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'dateis': instance.dateis,
      'countdatewise': instance.countdatewise,
    };

AlbumsItem _$AlbumsItemFromJson(Map<String, dynamic> json) {
  return AlbumsItem(
    id: json['id'] as int,
    name: json['name'] as String,
    photoUrl: json['photoUrl'] as String,
    count: json['count'] as int,
    date: json['date'] as String,
  )..isSeleted = json['isSeleted'] as bool;
}

Map<String, dynamic> _$AlbumsItemToJson(AlbumsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'count': instance.count,
      'date': instance.date,
      'isSeleted': instance.isSeleted,
    };

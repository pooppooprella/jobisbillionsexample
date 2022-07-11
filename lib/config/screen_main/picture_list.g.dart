// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map<String, dynamic> json) {
  return Picture(
    json['total_count'] as int,
    json['pageable_count'] as int,
    json['is_end'] as bool,
    json['documents'] as String,
  );
}

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'pageable_count': instance.pageable_count,
      'is_end': instance.is_end,
      'documents': instance.documents,
    };

DocumentsList _$DocumentsListFromJson(Map<String, dynamic> json) {
  return DocumentsList(
    documents: (json['documents'] as List<dynamic>?)
        ?.map((e) => Documents.fromJson(e as Map<String, dynamic>))
        .toList(),
    documents_like: (json['documents_like'] as List<dynamic>?)
        ?.map((e) => Documents.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DocumentsListToJson(DocumentsList instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'documents_like': instance.documents_like,
    };

Documents _$DocumentsFromJson(Map<String, dynamic> json) {
  return Documents(
    json['collection'] as String,
    json['thumbnail_url'] as String,
    json['image_url'] as String,
    json['width'] as int,
    json['height'] as int,
    json['display_sitename'] as String,
    json['doc_url'] as String,
    json['datetime'] as String,
    json['flag'] as bool,
  );
}

Map<String, dynamic> _$DocumentsToJson(Documents instance) => <String, dynamic>{
      'collection': instance.collection,
      'thumbnail_url': instance.thumbnail_url,
      'image_url': instance.image_url,
      'width': instance.width,
      'height': instance.height,
      'display_sitename': instance.display_sitename,
      'doc_url': instance.doc_url,
      'datetime': instance.datetime,
      'flag': instance.flag,
    };

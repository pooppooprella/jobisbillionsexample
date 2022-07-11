import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
part 'picture_list.g.dart';

// {
//   "meta": {
//     "total_count": 422583,
//     "pageable_count": 3854,
//     "is_end": false
//   },
//   "documents": [
//     {
//       "collection": "news",
//       "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/36hQpoTrVZp",
//       "image_url": "http://t1.daumcdn.net/news/201706/21/kedtv/20170621155930292vyyx.jpg",
//       "width": 540,
//       "height": 457,
//       "display_sitename": "한국경제TV",
//       "doc_url": "http://v.media.daum.net/v/20170621155930002",
//       "datetime": "2017-06-21T15:59:30.000+09:00"
//     },
//     ...
//   ]
// }

@JsonSerializable()
class Picture {
  //meta
  final int total_count;
  final int pageable_count;
  final bool is_end;
  //documents
  final String documents;

  Picture(this.total_count, this.pageable_count, this.is_end, this.documents);

  Picture.fromJson(Map<String, dynamic> json)
      : total_count = json['total_count'],
        pageable_count = json['pageable_count'],
        is_end = json['is_end'],
        documents = json['documents'];

  Map<String, dynamic> toJson() => {
        'total_count': total_count,
        'pageable_count': pageable_count,
        'is_end': is_end,
        'documents': documents,
      };
}

@JsonSerializable()
class DocumentsList {
  List<Documents>? documents;
  List<Documents>? documents_like;

  DocumentsList({required this.documents, this.documents_like});

  factory DocumentsList.fromJson(Map<String, dynamic> json) =>
      _$DocumentsListFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsListToJson(this);
}

@JsonSerializable()
class Documents {
  //documents
  final String collection;
  final String thumbnail_url;
  final String image_url;
  final int width;
  final int height;
  final String display_sitename;
  final String doc_url;
  final String datetime;
  bool flag;
  Documents(
      this.collection,
      this.thumbnail_url,
      this.image_url,
      this.width,
      this.height,
      this.display_sitename,
      this.doc_url,
      this.datetime,
      this.flag);

  Documents.fromJson(Map<String, dynamic> json)
      : collection = json['collection'],
        thumbnail_url = json['thumbnail_url'],
        image_url = json['image_url'],
        width = json['width'],
        height = json['height'],
        display_sitename = json['display_sitename'],
        doc_url = json['doc_url'],
        datetime = json['datetime'],
        flag = false;

  Map<String, dynamic> toJson() => {
        '\"collection\"': '\"' + collection + '\"',
        '\"thumbnail_url\"': '\"' + thumbnail_url + '\"',
        '\"image_url\"': '\"' + image_url + '\"',
        '\"width\"': width,
        '\"height\"': height,
        '\"display_sitename\"': '\"' + display_sitename + '\"',
        '\"doc_url\"': '\"' + doc_url + '\"',
        '\"datetime\"': '\"' + datetime + '\"',
        '\"flag\"': flag,
      };
}

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jobisbillionsexample/config/screen_main/picture_list.dart';

class ProviderMain extends ChangeNotifier {
// query	String	검색을 원하는 질의어	O
// sort	String	결과 문서 정렬 방식, accuracy(정확도순) 또는 recency(최신순), 기본 값 accuracy	X
// page	Integer	결과 페이지 번호, 1~50 사이의 값, 기본 값 1	X
// size	Integer	한 페이지에 보여질 문서 수, 1~80 사이의 값, 기본 값 80
  List<Documents> _sharedList_document = []; //tab2 즐겨찾기 저장 목록
  List<Documents> get getSharedList_document => _sharedList_document;
  void setSharedList_document(var list) {
    _sharedList_document = list;
    notifyListeners();
  }

  void setSharedList_documentAdd(Documents document) {
    _sharedList_document.add(document);
  }

  void setSharedList_documentRemove(int position) {
    _sharedList_document.removeAt(position);
  }

  DocumentsList? _documentsList;
  DocumentsList? get getDocumentsList => _documentsList;
  void setDocumentList(var list) {
    _documentsList = list;
    notifyListeners();
  }

  void setDocumentListAdd(var list) {
    var addoc = _documentsList!.documents! + list!.documents;
    _documentsList!.documents = addoc;
    notifyListeners();
  }

  void setDocumentListFlag(int position, bool flag) {
    _documentsList!.documents![position].flag = flag;
  }

  void setNotifyView() {
    notifyListeners();
  }
}

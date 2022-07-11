import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobisbillionsexample/base_class.dart';
import 'package:jobisbillionsexample/config/constants.dart';
import 'package:jobisbillionsexample/config/screen_main/picture_detail.dart';
import 'package:jobisbillionsexample/config/screen_main/picture_list.dart';
import 'package:jobisbillionsexample/config/screen_main/provider_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String searchStr = '';
int searchPage = 1;
String searchSize = '20';
ProviderMain providermain = ProviderMain();

class ScreenMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScreenMainState();
  }
}

class ScreenMainState extends State<ScreenMain>
    with BaseClass, TickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences sharedPreferences;
  late List<String> sharedList_str;
  final ScrollController _scrollController = ScrollController();
  // List<Documents> sharedList_document = []; //tab2 즐겨찾기 저장 목록
  // DocumentsList? documentsList;
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    _scrollController.addListener(() {
      scrollListener();
    });
    initSetSharedList();
    super.initState();
  }

  Future<void> initSetSharedList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.containsKey(sharedKey)
        ? sharedPreferences.getStringList(sharedKey)
        : sharedPreferences.setStringList(sharedKey, []);
    debugPrint('${sharedPreferences.getStringList(sharedKey)}');
    sharedList_str = sharedPreferences.getStringList(sharedKey)!;
    debugPrint('dddd initcount ${sharedList_str.length}');

    for (var i = 0; i < sharedList_str.length; i++) {
      providermain.getSharedList_document.add(Documents.fromJson(
          jsonDecode(sharedList_str[i].replaceAll("\&&", "\""))));
    }
    for (var i = 0; i < providermain.getSharedList_document.length; i++) {
      providermain.getSharedList_document[i].flag = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.4, 0.7],
            colors: [
              colors_arr[4],
              colors_arr[0],
            ],
          ),
        ),
        child: Column(
          children: [
            searchBox(size),
            searchTabBtn(size),
            searchTabView(size),
          ],
        ),
      ),
    );
  }

  Expanded searchTabView(Size size) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          providermain.getDocumentsList != null
              ? SizedBox(
                  height: size.height * 0.85,
                  child: getGridView(
                      size, providermain.getDocumentsList!.documents!, false))
              : Container(
                  child: Text('조회된 내역이 없습니다.'),
                ),
          providermain.getSharedList_document != null
              ? SizedBox(
                  height: size.height * 0.85,
                  child: getGridView(
                      size, providermain.getSharedList_document, true))
              : Container(
                  child: Text('조회된 내역이 없습니다.'),
                ),
        ],
      ),
    );
  }

  Container searchTabBtn(Size size) {
    return Container(
      height: size.height * 0.05,
      child: TabBar(
        tabs: [
          Container(
            height: size.height * 0.05,
            alignment: Alignment.center,
            child: Text('tab1'),
          ),
          Container(
            height: size.height * 0.05,
            alignment: Alignment.center,
            child: Text('tab2'),
          ),
        ],
        indicator: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Colors.blueAccent,
              Colors.pinkAccent,
            ],
          ),
        ),
        labelColor: colors_arr[0],
        unselectedLabelColor: colors_arr[2],
        controller: _tabController,
      ),
    );
  }

  scrollListener() async {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      debugPrint('Scroll BOTTOM');
      searchPage = searchPage + 1;
      requestEGet();
    } else if (_scrollController.offset ==
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      debugPrint('Scroll TOP');
    }
  }

  ChangeNotifierProvider getGridView(
      Size size, List<Documents> dlist, bool flag) {
    debugPrint('getgridview call ${flag}');

    flag ? dlist = providermain.getSharedList_document : dlist = dlist;
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return providermain;
      },
      child: GridView.builder(
        controller: _scrollController,
        itemCount: dlist.length, //item 개수
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 1, //수평 Padding
          crossAxisSpacing: 1, //수직 Padding
        ),
        itemBuilder: (BuildContext context, int index) {
          //item 의 반목문 항목 형성
          return Container(
            child: Stack(
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    color: colors_arr[3],
                    child: Image.network(
                      dlist.elementAt(index).thumbnail_url,
                      fit: BoxFit.fitWidth,
                      height: 500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PictureDetail(
                                  doc: dlist.elementAt(index),
                                )));
                  },
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        dlist.elementAt(index).flag
                            ? Icons.star
                            : Icons.star_border,
                        color: dlist.elementAt(index).flag
                            ? colors_arr[0]
                            : colors_arr[3],
                      ),
                      onTap: () {
                        debugPrint('click ');
                        dlist.elementAt(index).flag =
                            !dlist.elementAt(index).flag;
                        _onSaveLikeList(dlist.elementAt(index).flag,
                            dlist.elementAt(index));

                        setState(() {});
                      },
                    ),
                    Text(
                      dlist.elementAt(index).display_sitename,
                      style: TextStyle(color: colors_arr[4]),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //tab2 즐겨찾기 아이템 관리.
  _onSaveLikeList(bool value, Documents docs) async {
    var docstr = docs.toJson().toString().replaceAll("\"", "\&&");

    int removePosition = -1;

    if (sharedList_str == null) {
      List<String> first = [docstr];
      sharedPreferences.setStringList(sharedKey, first);
    } else {
      if (value == true) {
        List<String> second = sharedList_str;
        second.add(docstr);
        sharedPreferences.setStringList(sharedKey, second);
      } else {
        List<String> second = sharedList_str;
        for (var i = 0; i < second.length; i++) {
          second[i].contains(docs.thumbnail_url);
          removePosition = i;
        }

        if (removePosition >= 0) {
          second.removeAt(removePosition);
        }

        sharedPreferences.setStringList(sharedKey, second);
      }
    }
    if (value == true) {
      providermain.setSharedList_documentAdd(
          Documents.fromJson(jsonDecode(docstr.replaceAll("\&&", "\""))));
    } else {
      for (var i = 0; i < providermain.getSharedList_document.length; i++) {
        if (providermain.getSharedList_document[i].thumbnail_url
            .contains(docs.thumbnail_url)) {
          removePosition = i;
        }
      }
      providermain.setSharedList_documentRemove(removePosition);
      debugPrint('aaabbb $removePosition');
    }
    debugPrint(
        'shared add delete after1 count ${providermain.getSharedList_document.length}');
    for (var i = 0; i < providermain.getSharedList_document.length; i++) {
      for (var j = 0;
          j < providermain.getDocumentsList!.documents!.length;
          j++) {
        if (providermain.getSharedList_document[i].thumbnail_url ==
            providermain.getDocumentsList!.documents![j].thumbnail_url) {
          providermain.getDocumentsList!.documents![j].flag = true;
        }
      }
      providermain.getSharedList_document[i].flag = true;
    }

    debugPrint(
        'shared add delete after2 count ${providermain.getSharedList_document.length}');
    providermain.setNotifyView();
    setState(() {});
  }

  @override
  void actionPost(String primitive, response) async {
    debugPrint(response.toString());
    Map<String, dynamic> data = response as Map<String, dynamic>;

    if (searchPage > 1) {
      providermain.setDocumentListAdd(DocumentsList.fromJson(data));
    } else {
      providermain.setDocumentList(DocumentsList.fromJson(data));
    }

    for (var i = 0; i < providermain.getSharedList_document.length; i++) {
      for (var j = 0;
          j < providermain.getDocumentsList!.documents!.length;
          j++) {
        if (providermain.getSharedList_document[i].thumbnail_url ==
            providermain.getDocumentsList!.documents![j].thumbnail_url) {
          providermain.getDocumentsList!.documents![j].flag = true;
        }
      }
      providermain.getSharedList_document[i].flag = true;
    }
    providermain.setNotifyView();
    setState(() {});
  }

  Container searchBox(Size size) {
    // final myController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      width: size.width * 1,
      height: size.height * (1 / 10),
      color: colors_arr[2],
      child: Row(
        children: <Widget>[
          FlutterLogo(),
          new Flexible(
            child: new TextField(
              onChanged: ((value) => searchStr = value),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              searchPage = 1;
              requestEGet();
            },
            child: Icon(Icons.search),
          )
        ],
      ),
    );
  }

  void requestEGet() {
    var params = {
      'query': searchStr,
      'size': searchSize,
      'page': searchPage.toString()
    };
    eGet("imageSearch", params);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

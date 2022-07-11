import 'package:flutter/material.dart';
import 'package:jobisbillionsexample/config/constants.dart';
import 'package:jobisbillionsexample/config/screen_main/picture_list.dart';

class PictureDetail extends StatefulWidget {
  final Documents doc;

  const PictureDetail({Key? key, required this.doc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PictureDetailState();
  }
}

class PictureDetailState extends State<PictureDetail> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.doc.thumbnail_url);
    debugPrint(widget.doc.image_url);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.03),
            width: size.width * 1,
            height: size.height * (1 / 10),
            color: colors_arr[2],
            child: Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(size.width * 0.03),
            width: size.width * 1,
            height: size.height * (9 / 10),
            color: colors_arr[2],
            child: Image.network(
              widget.doc.image_url,
              fit: BoxFit.scaleDown,
              height: 500,
            ),
          ),
        ],
      ),
    );
  }
}

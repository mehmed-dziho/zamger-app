import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamger/models/news_post.dart';
import 'package:zamger/store/news_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamger/utils/colors.dart';

class NewsListItem extends StatefulWidget {
  NewsListItem({this.post, Key key}) : super(key: key);

  final NewsPost post;

  @override
  _NewsListItemState createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  var newsController = Get.find<NewsController>();

  goToLink(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (newsController) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
          tileColor: SECONDARY_BACKGROUND,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            widget.post.title,
            style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
          ),
          subtitle: widget.post.description.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(widget.post.description,
                          style: TextStyle(color: PRIMARY_COLOR))
                    ],
                  ),
                )
              : Container(),
          trailing: InkWell(
            onTap: () => goToLink(widget.post.link),
            child: Icon(Icons.keyboard_arrow_right,
                color: PRIMARY_COLOR, size: 30.0),
          ),
        ),
      ),
    );
  }
}

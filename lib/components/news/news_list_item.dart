import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamger/models/news_post.dart';
import 'package:zamger/store/news_controller.dart';
import 'package:zamger/utils/utils.dart';

class NewsListItem extends StatefulWidget {
  NewsListItem({this.post, Key key}) : super(key: key);

  final NewsPost post;

  @override
  _NewsListItemState createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  var newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (newsController) => Container(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(toUtf8(widget.post.title)),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(toUtf8(widget.post.description))),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: null,
                  child: Text('Link'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

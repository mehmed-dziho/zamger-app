import 'package:flutter/material.dart';
import 'package:zamger/components/news/news_list_item.dart';
import 'package:zamger/models/news_post.dart';

class NewsList extends StatelessWidget {
  NewsList({this.newsPosts, Key key}) : super(key: key);

  final List<NewsPost> newsPosts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: newsPosts.length > 0
            ? newsPosts
                .map((post) => NewsListItem(
                      post: post,
                    ))
                .toList()
            : [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      "Nothing here",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}

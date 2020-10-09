import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamger/components/async_button.dart';
import 'package:zamger/components/news/news_list.dart';
import 'package:zamger/store/news_controller.dart';
import 'package:zamger/utils/colors.dart';
import 'package:zamger/utils/utils.dart';

const TextInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: GREY_BORDER,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5));

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final rssLinkController = TextEditingController();

  var newsController = Get.find<NewsController>();

  @override
  void initState() {
    // var newsController = Get.find<ListingsController>();

    rssLinkController.text = newsController.rssLink;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NewsController.to.fetchAllNewsAction();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zamger obavijesti"),
      ),
      body: GetBuilder<NewsController>(
        builder: (newsController) => Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: rssLinkController,
                          decoration: TextInputDecoration.copyWith(
                            hintText: "Unesite svoj rss link",
                            labelText: "RSS link",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: AsyncButton(
                          child: Text(
                            'Pokreni',
                            style: TextStyle(color: Colors.purple),
                          ),
                          onPressed: () {
                            newsController.fetchAllNewsAction();
                          },
                          async: newsController.async,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  toUtf8(newsController.newsHeader),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Zadnji update: "),
                        TextSpan(
                          text: newsController.lastUpdated,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                NewsList(
                  newsPosts: newsController.newsPosts,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

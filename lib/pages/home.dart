import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamger/components/async_button.dart';
import 'package:zamger/components/news/news_list.dart';
import 'package:zamger/store/news_controller.dart';
import 'package:zamger/utils/colors.dart';
import 'package:zamger/utils/utils.dart';

const TextInputDecoration = InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: WHITE_BORDER, width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: WHITE_BORDER, width: 1),
    ),
    hintStyle: TextStyle(color: SECONDARY_COLOR),
    labelStyle: TextStyle(color: SECONDARY_COLOR),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: WHITE_BORDER,
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
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: rssLinkController,
                              style: TextStyle(
                                color: PRIMARY_COLOR,
                              ),
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
                                style: TextStyle(color: Colors.white),
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
                      newsController.newsHeader,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          children: [
                            TextSpan(text: "Zadnji update: "),
                            TextSpan(
                              text: newsController.lastUpdated,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NewsList(
                newsPosts: newsController.newsPosts,
              )
            ],
          ),
        ),
      ),
    );
  }
}

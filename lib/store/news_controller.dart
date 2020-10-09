import 'package:get/get.dart';
import 'package:zamger/models/news_post.dart';
import 'package:zamger/services/rss_feed.dart';

class NewsController extends GetxController {
  bool async = false;
  RxList<NewsPost> newsPosts = List<NewsPost>().obs;
  String rssLink = 'https://zamger.etf.unsa.ba/rss.php?id=ANzTmgVSkT';
  String newsHeader = '';
  String lastUpdated = '';

  static NewsController get to => Get.find(); // add this line

  void setNewsHeader(String header) {
    newsHeader = header;
    update();
  }

  void setLastUpdated(last) {
    lastUpdated = last;
    update();
  }

  Future<bool> fetchAllNewsAction() async {
    async = true;
    update();

    List<NewsPost> posts = await fetchAllNews(rssLink).catchError((error) {
      print(error);
      async = false;
      update();
    });

    if (posts != null) {
      newsPosts = List<NewsPost>.from(posts).obs;
      update();
    }

    async = false;
    update();

    // return res != null;
    return true;
  }
}

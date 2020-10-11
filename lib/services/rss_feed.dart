import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:zamger/models/news_post.dart';
import 'package:zamger/services/dio.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zamger/store/news_controller.dart';
import 'package:zamger/utils/utils.dart';

Future<List<NewsPost>> fetchAllNews(rssLink) async {
  String rawXml = await fetchRssFeed(rssLink);

  // String rawXml = await rootBundle.loadString('test.xml');

  final xml = XmlDocument.parse(rawXml);

  String newsHeader = xml.findAllElements('description').first.innerText;
  String lastUpdated = xml.findAllElements('pubDate').first.innerText;

  NewsController.to.setNewsHeader(newsHeader);

  var dateParser = new DateFormat('EEE, d MMM yyyy HH:mm:ss +Z');
  var dateFormatter = new DateFormat('d-MM-yyyy HH:mm:ss');

  try {
    DateTime date = dateParser.parse(lastUpdated);
    String formatted = dateFormatter.format(date).toString();
    NewsController.to.setLastUpdated(formatted);
  } catch (ex) {
    print(ex);
  }

  Iterable<XmlElement> newsItems = xml.findAllElements('item');

  List<NewsPost> posts = [];

  newsItems.forEach((item) {
    String title = item.getElement('title').innerText;
    String link = item.getElement('link').innerText;
    String description = item.getElement('description').innerText;

    posts.add(NewsPost(
      title: title,
      description: description,
      link: link,
    ));
  });

  return posts;
}

Future<String> fetchRssFeed(String rssLink) async {
  try {
    Response<String> response = await dio.get(rssLink);
    return response.data;
  } catch (error, stacktrace) {
    print(error);
    print(stacktrace);
    return null;
  }
}

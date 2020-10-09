import 'package:json_annotation/json_annotation.dart';

part 'news_post.g.dart';

@JsonSerializable()
class NewsPost {
  final String title;
  final String link;
  final String description;

  NewsPost({
    this.title,
    this.link,
    this.description,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) =>
      _$NewsPostFromJson(json);

  Map<String, dynamic> toJson() => _$NewsPostToJson(this);
}

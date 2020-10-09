// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPost _$NewsPostFromJson(Map<String, dynamic> json) {
  return NewsPost(
    title: json['title'] as String,
    link: json['link'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$NewsPostToJson(NewsPost instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
    };

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NewsModel? newsModelFromJson(String str) =>
    NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel? data) => json.encode(data!.toJson());

class NewsModel {
  NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    source: Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  NewsModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    title = documentSnapshot["title"];
    description = documentSnapshot["description"];
    urlToImage = documentSnapshot["urlToImage"];
    publishedAt = documentSnapshot["publishedAt"].toDate();
  }

  Map<String, dynamic> toJson() => {
    "source": source!.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  dynamic id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
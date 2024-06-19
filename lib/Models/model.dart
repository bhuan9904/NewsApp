// To parse this JSON data, do
//
//     final samplePost = samplePostFromJson(jsonString);

import 'dart:convert';

List<SamplePost> samplePostFromJson(String str) =>
    List<SamplePost>.from(json.decode(str).map((x) => SamplePost.fromJson(x)));

String samplePostToJson(List<SamplePost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SamplePost {
  String app;
  String postTitle;
  String postImage;
  DateTime postingDate;
  CategoryName categoryName;
  String url; // Added URL field

  SamplePost({
    required this.app,
    required this.postTitle,
    required this.postImage,
    required this.postingDate,
    required this.categoryName,
    required this.url,
  });

  factory SamplePost.fromJson(Map<String, dynamic> json) => SamplePost(
        app: json["App"],
        postTitle: json["PostTitle"],
        postImage: json["PostImage"],
        postingDate: DateTime.parse(json["PostingDate"]),
        categoryName: json["CategoryName"],
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "App": app,
        "PostTitle": postTitle,
        "PostImage": postImage,
        "PostingDate": postingDate.toIso8601String(),
        "CategoryName": categoryNameValues.reverse[categoryName],
        "Url": url,
      };
}

enum CategoryName {
  DEVOTIONAL,
  HEALTH,
  MISC,
  NEWS,
  SPORTS
}

final categoryNameValues = EnumValues({
  "Devotional": CategoryName.DEVOTIONAL,
  "Health": CategoryName.HEALTH,
  "Misc": CategoryName.MISC,
  "News": CategoryName.NEWS,
  "Sports": CategoryName.SPORTS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

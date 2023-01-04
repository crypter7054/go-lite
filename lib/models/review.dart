import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.id,
    required this.star,
    required this.suggestion,
    required this.comment,
  });

  ObjectId id;
  int star;
  List<String> suggestion;
  String comment;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        star: json["star"],
        suggestion: json["suggestion"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "star": star,
        "suggestion": suggestion,
        "comment": comment,
      };
}

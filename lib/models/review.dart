import 'package:mongo_dart/mongo_dart.dart';

class Review {
  ObjectId id;
  int star;
  List<String> suggestion;
  String comment;

  Review(
      {required this.id,
      required this.star,
      required this.suggestion,
      required this.comment});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'star': star,
      'suggestion': suggestion,
      'comment': comment,
    };
  }

  Review.fromMap(Map<String, dynamic> map)
      : star = map['star'],
        id = map['_id'],
        suggestion = map['suggestion'],
        comment = map['comment'];
}

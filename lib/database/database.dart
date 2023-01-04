import 'package:mongo_dart/mongo_dart.dart';
import '../models/review.dart';

import '../utils/constants.dart';

class MongoDatabase {
  static var db, reviewCollection;

  static connect() async {
    db = Db(MONGO_CONN_URL);
    await db.open();
    reviewCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {

    final reviews = await reviewCollection.find().toList();
    print(reviews);
    return reviews;

  }

  static insert(Review review) async {
    await reviewCollection.insertAll([review.toMap()]);
  }

  static update(Review review) async {
    var u = await reviewCollection.findOne({"_id": review.id});
    u["star"] = review.star;
    u["suggestion"] = review.suggestion;
    u["comment"] = review.comment;
    await reviewCollection.save(u);
  }

  static delete(Review review) async {
    await reviewCollection.remove(where.id(review.id));
  }
}

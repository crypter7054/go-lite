import 'package:mongo_dart/mongo_dart.dart';

import '../utils/constants_review.dart';

class MongoDatabase {
  static var db, reviewCollection;

  static Future<List> getDocuments() async {
    db = Db(MONGO_CONN_URL);
    await db.open();
    reviewCollection = db.collection(USER_COLLECTION);
    final reviews = await reviewCollection.find().toList();

    return reviews;
  }

  static insertReview(int star, List<String> suggestion, String comment){
    reviewCollection.insertOne({
      'star': star,
      'suggestion': suggestion,
      'comment': comment
    });
  }

  static deleteReview(ObjectId id){
    reviewCollection.deleteOne(where.id(id));
  }
}

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

  static deleteReview(ObjectId id){
    reviewCollection.deleteOne(where.id(id));
  }

  // static insert(Review review) async {
  //   await reviewCollection.insertAll([review.toMap()]);
  // }
  //
  // static update(Review review) async {
  //   var u = await reviewCollection.findOne({"_id": review.id});
  //   u["star"] = review.star;
  //   u["suggestion"] = review.suggestion;
  //   u["comment"] = review.comment;
  //   await reviewCollection.save(u);
  // }

  // static delete(Review review) async {
  //   await reviewCollection.remove(where.id(review.id));
  // }
}

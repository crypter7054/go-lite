import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  Db db = Db("mongodb://localhost:27017/golite");
  await db.open();

  print("Connected to database");

  DbCollection coll = db.collection("review");

  // READ
  // var review = await coll.find().toList(); // all
  // var review = await coll.find(where.eq('star', 5).limit(5)).toList(); // condition
  // var review = await coll.findOne(where.eq('star', 5)); // find one
  // print(review);

  // INSERT
  // await coll.insertOne({
  //   'star': 5,
  //   'suggestion': ['bersih', 'ramah'],
  //   'comment': 'mantap'
  // });
  // print("Insert Success");

  // UPDATE
  // await coll.update(where.eq('comment', 'mantap'), modify.set('comment', 'nonono')); // change value
  // await coll.update(where.eq('comment', 'nonono'), modify.set('suggestion', ['kotor', 'ngebut'])); // change value array
  // await coll.update(where.eq('comment', 'nonono'), modify.set('baru', 'hello')); // add new attribute
  // await coll.update(where.eq('comment', 'nonono'), modify.unset('baru')); // remove attribute
  // print("Update Success");

  // DELETE
  // await coll.deleteOne(where.eq('comment', 'nonono'));
  // print("Delete Success");

  await db.close();
}
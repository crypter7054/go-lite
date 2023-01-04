import 'package:mongo_dart/mongo_dart.dart';

import '../utils/constants_voucher.dart';

class MongoDatabase {
  static var db, voucherCollection;

  static Future<List> getDocuments() async {
    db = Db(MONGO_CONN_URL);
    await db.open();
    voucherCollection = db.collection(USER_COLLECTION);
    final vouchers = await voucherCollection.find().toList();
    print(vouchers[0]["terms&cond"]);

    return vouchers;
  }

  // static insert(Voucher voucher) async {
  //   await voucherCollection.insertAll([voucher.toMap()]);
  // }
  //
  // static update(Voucher voucher) async {
  //   var u = await voucherCollection.findOne({"_id": voucher.id});
  //   u["star"] = voucher.star;
  //   u["suggestion"] = voucher.suggestion;
  //   u["comment"] = voucher.comment;
  //   await voucherCollection.save(u);
  // }

  // static delete(Voucher voucher) async {
  //   await voucherCollection.remove(where.id(voucher.id));
  // }
}

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

  static insertVoucherTetap(String name, String desc, int discount_price, int min_trans, String payment, String guide, DateTime expire_date){
    voucherCollection.insertOne({
      'name': name,
      'terms&cond': [
        {
          'desc': desc,
          'discount_price': discount_price,
          'min_trans': min_trans,
          'payment': payment
        }
      ],
      'guide': guide,
      'expire_date': expire_date
    });
  }

  static insertVoucherPersen(String name, String desc, int discount_percent, int max_disc, int min_trans, List<String> payment, String guide, DateTime expire_date){
    voucherCollection.insertOne({
      'name': name,
      'terms&cond': [
        {
          'desc': desc,
          'discount_percent': discount_percent,
          'max_disc': max_disc,
          'min_trans': min_trans,
          'payment': payment
        }
      ],
      'guide': guide,
      'expire_date': expire_date
    });
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

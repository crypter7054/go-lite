import 'package:mongo_dart/mongo_dart.dart';

import '../utils/constants_voucher.dart';

class MongoDatabase {
  static var db, voucherCollection;

  static Future<List> getDocuments() async {
    db = Db(MONGO_CONN_URL);
    await db.open();
    voucherCollection = db.collection(USER_COLLECTION);
    final vouchers = await voucherCollection.find().toList();

    return vouchers;
  }

  static Future getOneDocuments(ObjectId id) async {
    db = Db(MONGO_CONN_URL);
    await db.open();
    voucherCollection = db.collection(USER_COLLECTION);
    final vouchers = await voucherCollection.find(where.id(id));

    return vouchers;
  }

  static insertVoucherTetap(String name, String desc, int discount_price, int min_trans, List<String> payment, String guide, DateTime expire_date){
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

  static updateVoucherTetap(ObjectId id,String name, String desc, int discount_price, int min_trans, List<String> payment, String guide, DateTime expire_date){
    voucherCollection.update(where.id(id),{
      "_id": id,
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

  static updateVoucherPersen(ObjectId id,String name, String desc, int discount_percent, int max_disc, int min_trans, List<String> payment, String guide, DateTime expire_date){
    voucherCollection.update(where.id(id),{
      "_id": id,
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

  static deleteVoucher(ObjectId id,){
    voucherCollection.deleteOne(where.id(id));
  }

}

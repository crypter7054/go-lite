import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:golite/navigationAdmin.dart';

import 'database/database_voucher.dart';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  late Future<List> response;

  // Sorting table.
  final int _currentSortColumn = 0;
  final bool _isSortAsc = true;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    response = MongoDatabase.getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          margin:
              const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.discount_outlined,
                    color: Colors.green.shade700,
                    size: 50,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Voucher list',
                    style:
                        TextStyle(color: Colors.green.shade700, fontSize: 20),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationAdmin(
                                page: DrawerSections.inputVoucher,
                              )),
                    );
                  }, // Fill here for navigation.
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.all(16)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Add a Voucher',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 0),
          child: (const Text(
            'Discount Voucher',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, left: 16, right: 16),
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: FutureBuilder(
                future: response,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Something went wrong, try again.',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  } else {
                    return PaginatedDataTable(
                        source: percentSource(snapshot.data),
                        columns: _columnDiscount(),
                        sortAscending: _isSortAsc,
                        sortColumnIndex: _currentSortColumn,
                        showCheckboxColumn: true);
                  }
                })),
        Container(
          margin:
              const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 0),
          child: (const Text(
            'Price Voucher',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
        ),
        SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 30, left: 16, right: 16),
                margin: const EdgeInsets.only(left: 12, right: 12),
                child: FutureBuilder(
                    future: response,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: Colors.white,
                          child: const LinearProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Something went wrong, try again.',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        );
                      } else {
                        return PaginatedDataTable(
                            dragStartBehavior: DragStartBehavior.start,
                            source: priceSource(snapshot.data),
                            columns: _columnPrice(),
                            sortAscending: _isSortAsc,
                            sortColumnIndex: _currentSortColumn,
                            showCheckboxColumn: true);
                      }
                    })))
      ],
    ));
  }

  DataTableSource percentSource(List<Map<String, dynamic>> voucherList) {
    List<Map<String, dynamic>> datalistDiscount = [];
    voucherList.forEach((v) {
      if (null != v['terms&cond'][0]['discount_percent'])
        datalistDiscount.add(v);
    });
    return VoucherPercentData(dataList: datalistDiscount);
  }

  DataTableSource priceSource(List<Map<String, dynamic>> voucherList) {
    List<Map<String, dynamic>> datalistPrice = [];
    voucherList.forEach((v) {
      if (null != v['terms&cond'][0]['discount_price']) datalistPrice.add(v);
    });
    return VoucherPriceData(dataList: datalistPrice);
  }

  List<DataColumn> _columnDiscount() {
    return [
      const DataColumn(
          label: Text("#",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Discount(%)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Max. Discount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Min. Transaction",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Payment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Guide",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Expire Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ];
  }

  List<DataColumn> _columnPrice() {
    return [
      const DataColumn(
          label: Text("#",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Discount(Rp)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Min. Transaction",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Payment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Guide",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Expire Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ];
  }
}

class VoucherPercentData extends DataTableSource {
  VoucherPercentData({required this.dataList});
  final List<Map<String, dynamic>> dataList;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Text(dataList[index]['name']),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['desc']),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['discount_percent'].toString()),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['max_disc'].toString()),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['min_trans'].toString()),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['payment'].join(', ')),
        ),
        DataCell(
          Text(dataList[index]['guide']),
        ),
        DataCell(
          Text(dataList[index]['expire_date'].toString()),
        ),
        DataCell(PopupMenu(id: dataList[index]['_id'])),
      ],
    );
  }
}

class VoucherPriceData extends DataTableSource {
  VoucherPriceData({required this.dataList});
  final List<Map<String, dynamic>> dataList;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Text(dataList[index]['name']),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['desc']),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['discount_price'].toString()),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['min_trans'].toString()),
        ),
        DataCell(
          Text(dataList[index]['terms&cond'][0]['payment'].join(', ')),
        ),
        DataCell(
          Text(dataList[index]['guide']),
        ),
        DataCell(
          Text(dataList[index]['expire_date'].toString()),
        ),
        DataCell(PopupMenu(id: dataList[index]['_id'])),
      ],
    );
  }
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key, required this.id});

  final mongo.ObjectId id;

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  var selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          setState(() {
            selectedOption = value.toString();
            if (selectedOption == 'deleteVoucher') {
              MongoDatabase.deleteVoucher(widget.id);
            } else if (selectedOption == 'updateVoucher') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationAdmin(
                          page: selectedOption,
                          id: widget.id,
                        )),
              );
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationAdmin(
                        page: selectedOption,
                      )),
            );
          });
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "updateVoucher",
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('Ubah',
                        style: TextStyle(color: Colors.green.shade700)),
                  ]),
            ),
            PopupMenuItem(
              value: "deleteVoucher",
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete_outlined,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Hapus', style: TextStyle(color: Colors.red)),
                  ]),
            ),
          ];
        });
  }
}

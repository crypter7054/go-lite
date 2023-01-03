import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:golite/navigationAdmin.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // Sorting table.
  final int _currentSortColumn = 0;
  final bool _isSortAsc = true;

  var tableRowDiscount = new TableRowDiscount();
  var tableRowPrice = new TableRowPrice();

  @override
  void initState() {
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
            child: PaginatedDataTable(
                source: tableRowDiscount,
                columns: _columnDiscount(),
                sortAscending: _isSortAsc,
                sortColumnIndex: _currentSortColumn,
                showCheckboxColumn: true)),
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
        Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, left: 16, right: 16),
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: PaginatedDataTable(
                source: tableRowPrice,
                columns: _columnPrice(),
                sortAscending: _isSortAsc,
                sortColumnIndex: _currentSortColumn,
                showCheckboxColumn: true)),
      ],
    ));
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

class TableRowDiscount extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      const DataCell(PopupMenu()),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}

class TableRowPrice extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      DataCell(Text("Cell $index")),
      const DataCell(PopupMenu()),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

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

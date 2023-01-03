import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // Sorting table.
  final int _currentSortColumn = 0;
  final bool _isSortAsc = true;

  var tableRow = new TableRow();

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
                  onPressed: () {}, // Fill here for navigation.
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
        Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, left: 16, right: 16),
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: PaginatedDataTable(
                    dragStartBehavior: DragStartBehavior.start,
                    source: tableRow,
                    columns: _createColumn(),
                    sortAscending: _isSortAsc,
                    sortColumnIndex: _currentSortColumn,
                    showCheckboxColumn: true)))
      ],
    ));
  }

  List<DataColumn> _createColumn() {
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

class TableRow extends DataTableSource {
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
      DataCell(Text((index + 1).toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 50;

  @override
  int get selectedRowCount => 0;
}

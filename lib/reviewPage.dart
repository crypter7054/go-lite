import 'package:flutter/material.dart';
import 'package:golite/navigationUser.dart';

import 'database/database.dart';
import 'models/review.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // Sorting table.
  final int _currentSortColumn = 0;
  final bool _isSortAsc = true;

  late Future<List> response;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    MongoDatabase.connect();
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
                    Icons.rate_review_outlined,
                    color: Colors.green.shade700,
                    size: 50,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Review list',
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
                          builder: (context) => NavigationUser(
                                page: DrawerSections.inputReview,
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
                        'Add a Review',
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
                        source: dataSource(snapshot.data),
                        columns: _createColumn(),
                        sortAscending: _isSortAsc,
                        sortColumnIndex: _currentSortColumn,
                        showCheckboxColumn: true);
                  }
                }))
      ],
    ));
  }

  DataTableSource dataSource(List<Review> reviewList) =>
      ReviewData(dataList: reviewList);

  List<DataColumn> _createColumn() {
    return [
      const DataColumn(
          label: Text("#",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Star",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Suggestion Review",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("Comment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text("",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ];
  }
}

class ReviewData extends DataTableSource {
  ReviewData({required this.dataList});
  final List<Review> dataList;

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
          Text(dataList[index].star.toString()),
        ),
        DataCell(
          Text(dataList[index].suggestion.join(", ")),
        ),
        DataCell(
          Text(dataList[index].comment),
        ),
        const DataCell(PopupMenu()),
      ],
    );
  }
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
          });
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "delete",
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

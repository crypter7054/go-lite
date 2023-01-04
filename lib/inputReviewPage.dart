import 'package:flutter/material.dart';
import 'package:golite/database/database_review.dart';

class InputReviewPage extends StatefulWidget {
  const InputReviewPage({super.key});

  @override
  State<InputReviewPage> createState() => _InputReviewPageState();
}

class _InputReviewPageState extends State<InputReviewPage> {
  // bool isChecked = false;

  TextEditingController star = TextEditingController();
  List<String> suggestion = [];
  TextEditingController comment = TextEditingController();

  List<Map> availableHobbies = [
    {"name": "mobilnya keren", "isChecked": false},
    {"name": "ngobrolnya seru", "isChecked": false},
    {
      "name": "bersih",
      "isChecked": false,
    },
    {"name": "nyaman", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.rate_review_outlined, color: Colors.green[700], size: 50,),
                    const SizedBox(
                      width: 12,
                    ),
                    Text('Add Review', style: TextStyle(color: Colors.green[700], fontSize: 20),)
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 40, bottom: 40, left: 32, right: 32),
                margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      title: TextFormField(
                        controller: star,
                        decoration: const InputDecoration(
                          labelText: 'Star',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Column(
                            children: availableHobbies.map((hobby){
                              return CheckboxListTile(
                                activeColor: Colors.green[700],
                                value: hobby["isChecked"],
                                title: Text(
                                  hobby["name"],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                                onChanged: (newValue){
                                  setState(() {
                                    hobby["isChecked"] = newValue;
                                  });
                                });
                            }).toList(),
                          ),
                          Wrap(
                            children: availableHobbies.map((hobby) {
                              if (hobby["isChecked"] == true){
                                return Card(
                                  elevation: 1,
                                  color: Colors.green[700],
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      hobby["name"],
                                      style: const TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: comment,
                        decoration: const InputDecoration(
                          labelText: 'Comment',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        // padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(top: 14, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  side: BorderSide(
                                      color: (Colors.green[700])!
                                  )
                              ),
                              onPressed: (){
                                setState(() {
                                });
                              },
                              child: Text('Batal', style: TextStyle(color: Colors.green[700]),),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.green[700],
                                  padding: const EdgeInsets.all(18),
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14
                                  )
                              ),
                              onPressed: (){
                                setState(() {
                                  for(int i=0; i < availableHobbies.length; i++){
                                    if(availableHobbies[i]['isChecked'] == true){
                                      suggestion.add(availableHobbies[i]['name']);
                                    }
                                  }
                                  MongoDatabase.insertReview(int.parse(star.text), suggestion, comment.text);
                                });
                              },
                              child: const Text('Submit'),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}




import 'dart:convert';

import 'package:api_crud/Insert_Smartphone.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  const ApiDemo({Key? key}) : super(key: key);

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                size: 25,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return InsertSmartphone(null);
                },
              )).then((value) {
                if (value == true) {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data Added Successfuly")),
                    );
                  });
                }
              });
            },
          ),
        ],
        title: Text("Call Api"),
      ),
      body: FutureBuilder(
          future: CallApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      background: Container(
                        color: Colors.redAccent,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Please Confirm"),
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("Cancel")),
                              ElevatedButton(
                                  onPressed: () {
                                    deletephone(snapshot.data![index]['id'])
                                        .then((value) => (value) {
                                          setState(() {
                                            return;
                                          });
                                    });
                                    Navigator.of(context).pop(true);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Data Deleted Successfuly")),
                                    );
                                  },
                                  child: Text("Delete"))
                            ],
                          ),
                        );
                      },
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            snapshot.data!.removeAt(index);
                          });
                        }
                      },
                      key: ValueKey(snapshot.data![index]['id'].toString()),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return InsertSmartphone(snapshot.data![index]);
                            },
                          )).then((value) {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Data Updated Successfuly")),
                              );
                            });
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.all(15),
                          elevation: 10,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            height: 120,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: NetworkImage(snapshot
                                              .data![index]['SmartPhoneImage']
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 35)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index]
                                                ['smartphoneNames'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(snapshot.data![index]
                                              ['smartphoneModel']),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(snapshot.data![index]
                                                  ['SmartPhonePrice']
                                              .toString()),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(snapshot.data![index]
                                                  ['smartPhoneMaker']
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  // child: Center(child: Text(snapshot.data![0]['name'].toString())),
                  );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }


  Future<List> CallApi() async {
    var response = await http.get(
        Uri.parse("https://63176e6fece2736550b31750.mockapi.io/Smartphones"));
    return jsonDecode(response.body);
  }

  Future<void> deletephone(id) async {
    var response = await http.delete(Uri.parse(
        "https://63176e6fece2736550b31750.mockapi.io/Smartphones/"+id));
    return;
  }
}

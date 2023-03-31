import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertSmartphone extends StatefulWidget {
  dynamic? map;

  InsertSmartphone(this.map);

  var fromKey = GlobalKey<FormState>();

  var name = TextEditingController();

  var Model = TextEditingController();

  var Price = TextEditingController();

  var Maker = TextEditingController();

  var Image = TextEditingController();

  @override
  State<InsertSmartphone> createState() => _InsertSmartphoneState();
}

class _InsertSmartphoneState extends State<InsertSmartphone> {
  var fromKey = GlobalKey<FormState>();

  void initState() {
    widget.name.text = widget.map == null ? '' : widget.map['smartphoneNames'];
    widget.Model.text = widget.map == null ? '' : widget.map['smartphoneModel'];
    widget.Price.text =
        widget.map == null ? '' : widget.map['SmartPhonePrice'].toString();
    widget.Maker.text = widget.map == null ? '' : widget.map['smartPhoneMaker'];
    widget.Image.text = widget.map == null ? '' : widget.map['SmartPhoneImage'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: fromKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter SmartphoneName",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return "Enter Valid Name";
                          }
                        },
                        controller: widget.name,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter SmartphoneModel",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Enter Valid Model";
                          }
                        },
                        controller: widget.Model,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter SmartphonePrice",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Enter Valid Price";
                          }
                        },
                        controller: widget.Price,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter SmartphoneMaker",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black)),
                        validator: (value) {
                          if (value == null && value!.isEmpty) {
                            return "Enter Valid MakerName";
                          }
                        },
                        controller: widget.Maker,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter SmartphoneImage",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Valid ImageUrl";
                          }
                        },
                        controller: widget.Image,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if(fromKey.currentState!.validate()){
                            if (widget.map == null) {
                              await AddSmartphone().then((value) => (value) {});
                            } else {
                              await EditSmartphone().then((value) => (value) {});
                            }
                            Navigator.of(context).pop(true);
                          }

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> AddSmartphone() async {
    var map = {};
    map['smartphoneNames'] = widget.name.text;
    map['smartphoneModel'] = widget.Model.text;
    map['SmartPhonePrice'] = widget.Price.text;
    map['smartPhoneMaker'] = widget.Maker.text;
    map['SmartPhoneImage'] = widget.Image.text;

    var response = http.post(
        Uri.parse(
          "https://63176e6fece2736550b31750.mockapi.io/Smartphones",
        ),
        body: map);
  }

  Future<void> EditSmartphone() async {
    var map = {};
    map['smartphoneNames'] = widget.name.text;
    map['smartphoneModel'] = widget.Model.text;
    map['SmartPhonePrice'] = widget.Price.text;
    map['smartPhoneMaker'] = widget.Maker.text;
    map['SmartPhoneImage'] = widget.Image.text;

    var response = await http.put(
        Uri.parse(
          "https://63176e6fece2736550b31750.mockapi.io/Smartphones/" +
              widget.map['id'].toString(),
        ),
        body: map);
  }
}

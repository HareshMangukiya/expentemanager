
import 'package:expentemanager/Screen/HomePage.dart';
import 'package:expentemanager/helper/Databasehedler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class transaction extends StatefulWidget {

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {
  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _Amount = TextEditingController();
  TextEditingController _dateinput = TextEditingController();
  var grp = "income";
  var selected = "food";

  _handalRadio(val) {
    setState(() {
      grp = val!;
    });
  }

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "income",
                        groupValue: grp,
                        onChanged: _handalRadio,
                      ),
                      Text("Income"),
                      Radio(
                        value: "expense",
                        groupValue: grp,
                        onChanged: _handalRadio,
                      ),
                      Text("Expense"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("category"),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        value: selected,
                        onChanged: (val) {
                          setState(() {
                            selected = val!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text("food"),
                            value: "food",
                          ),
                          DropdownMenuItem(
                            child: Text("office"),
                            value: "office",
                          ),
                          DropdownMenuItem(
                            child: Text("house"),
                            value: "house",
                          ),
                          DropdownMenuItem(
                              child: Text("investment"), value: "investment"),
                          DropdownMenuItem(child: Text("other"), value: "other"),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: TextFormField(
                      controller: _title,
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "please enter title";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: TextFormField(
                      controller: _remark,
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "please enter remark";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Remark",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: TextFormField(
                      controller: _Amount,
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "please enter remark";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Amount",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _dateinput,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                            ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              _dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFE7551),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      onPressed: () async  {
                        var title = _title.text.toString();
                        var remark = _remark.text.toString();
                        var category = selected.toString();
                        var type = grp.toString();
                        var amount = _Amount.text.toString();
                        var date = _dateinput.text.toString();

                        Databasehedler obj = new Databasehedler();
                       var status = await obj.insertTracation(type,category,title,remark,amount,date);
                       print("Record inserted at :"+status.toString());
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage()));


                        },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),


                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

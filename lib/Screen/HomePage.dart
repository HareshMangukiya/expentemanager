import 'package:expentemanager/Screen/BalanceSheet.dart';
import 'package:expentemanager/Screen/Transaction.dart';
import 'package:expentemanager/Screen/UpdateDatabase.dart';
import 'package:expentemanager/helper/Databasehedler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List>? alldata;

  Future<List> getdata(type) async {
    Databasehedler obj = new Databasehedler();
    var alldata = await obj.ViewTracation(type);
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata("all");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page")),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.currency_rupee,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BalanceSheet()));

            },
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => transaction()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  alldata = getdata("all");
                });
              }, child:Text("All")),
              ElevatedButton(onPressed: (){
                setState(() {
                  alldata = getdata("income");
                });
              }, child:Text("Income")),
              ElevatedButton(onPressed: (){
                setState(() {
                  alldata = getdata("expense");
                });
              }, child:Text("Expense")),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: alldata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("No Data Found"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: (snapshot.data![index]["type"]
                                      .toString()=="income")?Colors.green.shade50:Colors.red.shade50,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index]["title"]
                                              .toString()),
                                          Text(snapshot.data![index]["amount"]
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(snapshot.data![index]["category"]
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(snapshot.data![index]["remark"]
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index]["type"]
                                              .toString()),
                                          Text(snapshot.data![index]["tdate"]
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              AlertDialog alert = new AlertDialog(
                                                title: Text("Are You Sure!"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () async{
                                                      var id =snapshot.data![index]["tid"].toString();
                                                      Databasehedler obj = new Databasehedler();
                                                      var status = await obj.deleteNote(id);
                                                      if(status==1)
                                                        {
                                                          setState(() {
                                                            alldata = getdata("all");
                                                          });

                                                        }
                                                      else
                                                        {

                                                          print("Record Not Deleted");

                                                        }
                                                    },
                                                    child: Text("Yes"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text("No"),
                                                  ),
                                                ],
                                              );
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return alert;
                                                  });
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          SizedBox(
                                            width: 25.0,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              var id =snapshot.data![index]["tid"].toString();
                                              var tl =snapshot.data![index]["tid"].toString();
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(builder: (context) => UpdateDatabase(
                                                updateid: id,
                                                title: tl,
                                              )));
                                            },
                                            icon: Icon(Icons.update),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

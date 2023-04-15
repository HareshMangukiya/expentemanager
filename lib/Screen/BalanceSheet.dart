import 'package:flutter/material.dart';

import '../helper/Databasehedler.dart';

class BalanceSheet extends StatefulWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  State<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {


  var balance=0.0,income=0.0,expense=0.0;


  getdata() async {
    Databasehedler obj = new Databasehedler();
    var alldata = await obj.ViewTracation("all");
    alldata.forEach((row) {
      if(row["type"]=="income")
        {
          setState(() {
            income=income + double.parse(row["amount"].toString());
          });
        }
      else
        {
          setState(() {
            expense=expense + double.parse(row["amount"].toString());
          });
        }
    });
    setState(() {
      balance = income-expense;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("BalanceSheet")),
      ),
      body: SingleChildScrollView(

        child: Column(

          children: [
            SizedBox(height: 25.0,),
           Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               color: Colors.brown,
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Rs "+balance.toString(),style: TextStyle(color: Colors.white,fontSize: 25.0),),
                 Text("Balance",style: TextStyle(color: Colors.white,fontSize: 25.0),),
               ],
             ),
           ),
            SizedBox(height: 25.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.brown,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rs "+income.toString(),style: TextStyle(color: Colors.white,fontSize: 25.0),),
                      Text("Income",style: TextStyle(color: Colors.white,fontSize: 25.0),),
                    ],
                  ),
                ),
                SizedBox(width: 25.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.brown,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rs"+expense.toString(),style: TextStyle(color: Colors.white,fontSize: 25.0),),
                      Text("Expense",style: TextStyle(color: Colors.white,fontSize: 25.0),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

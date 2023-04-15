import 'package:expentemanager/Screen/CreatePin.dart';
import 'package:expentemanager/Screen/EnterPin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  checklogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EnterPin()));
    }
    else
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CreatePin()));
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      checklogin();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpleshScreen"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network("https://play-lh.googleusercontent.com/DuociTkA2k_hEo2k5fvBqGPAKLROAYDVEVmhj32A-i7GoBo7bxQl72cW5keyYuW-PQXb"),
            ],
          ),
        ),
      ),

    );
  }
}

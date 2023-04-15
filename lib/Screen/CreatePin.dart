import 'package:expentemanager/Screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  TextEditingController _password = TextEditingController();
  var password = "1111";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cretepin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cretepin",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff6C6C6C),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Color(0xff8D8D8D),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xffFE7551),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff6C6C6C),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Color(0xff8D8D8D),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xffFE7551),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
              ),
            ),
            SizedBox(height: 25.0,),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () async {
                if (
                _password.text.toString() == "1111") {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setString("islogin", "yes");


                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage()));
                }

              },
                child:
                Text(
                  "Submit",
                  style: TextStyle(fontSize: 25.0),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

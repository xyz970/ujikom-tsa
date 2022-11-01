import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ujikom1/dashboard_page.dart';
import 'package:ujikom1/models/User.dart';
import 'package:ujikom1/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: ListView(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      "Silahkan login dengan akun anda",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 11,
                          // fontWeight: FontWeight,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Username",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16.0),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  new Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        focusColor: Theme.of(context).colorScheme.primary,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Password",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16.0),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Icon(Icons.lock_open,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ),
                  new Expanded(
                    child: TextField(
                      obscureText: true,
                      controller: _passController,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: '*******',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 18,
                  margin: const EdgeInsets.only(top: 20.0),
                  // padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      var status = await login(
                          _usernameController.text, _passController.text);
                      var username = prefs.getString("username");
                      print(username);
                      if (status) {
                        Get.off(() => HomePage(username: username ?? ''));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Data Tidak ditemukan")));
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text(
                      "LOGIN",
                      // style:
                      //     TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  )),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextButton(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Tidak punya akun? Daftar Disini",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10.0),
                      ),
                    ),
                    onPressed: () => {Get.off(() => SignupPage())},
                  ),
                ),
              ]),
            ),
            SizedBox(
              //  width: MediaQuery.of(context).size.width/4,
              height: MediaQuery.of(context).size.height / 13,
            ),

            //End Blue Cloud
          ],
        ),
      ),
    );
  }
}

Future<bool> login(
  username,
  password,
) async {
  final prefs = await SharedPreferences.getInstance();
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "database.db");
  var db = openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT, nama TEXT,password TEXT,nomor_telpon TEXT)',
      );
    },
  );
  final database = await db;
  bool status = false;
  List<Map> result = await database.query("users");
  print(result);
  result.forEach((element) {
    if (element["username"] == username && element["password"] == password) {
      status = true;
      prefs.setString("username", username);
      prefs.setInt("id", element["id"]);
      print(element["id"]);
    }
  });
  return status;
}

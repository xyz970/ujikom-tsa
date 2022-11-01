import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ujikom1/login_page.dart';
import 'package:ujikom1/models/User.dart';

class SettingsPage extends StatefulWidget {
  final String username;
  const SettingsPage({Key? key, required this.username}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _no_hpController = TextEditingController();
  final _usernameController = TextEditingController();
  List<Map> data = [];

  // @override
  void initState() {
    inisiasi();
    super.initState();
  }

  Future<List<Map>> inisiasi() async {
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
    data = result;
    print(result);
    result.forEach((element) {
      if (element["username"] == widget.username) {
        _nameController.text = element["nama"];
        _passController.text = element["password"];
        _usernameController.text = element["username"];
        _no_hpController.text = element["nomor_telpon"];
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text("Pengaturan"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 30),
              child: Text(
                "Nama",
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        // hintText: "xx",
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Icon(Icons.person,
                        size: 20, color: Theme.of(context).colorScheme.primary),
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
                "Nomor Hp",
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
                    child: Icon(Icons.phone_android,
                        size: 20, color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _no_hpController,
                      decoration: InputDecoration(
                        focusColor: Theme.of(context).colorScheme.primary,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: 'ex 081....',
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
                      update(_usernameController.text, _nameController.text,
                          _passController.text, _no_hpController.text);
                      // inisiasi();
                      print(_nameController.text);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove("username");
                      prefs.remove("id");
                      Get.off(() => LoginPage());
                    },
                    child: Text(
                      "Update",
                      // style:
                      //     TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

void update(username, nama, password, no_hp) async {
  final prefs = await SharedPreferences.getInstance();
  var where = prefs.getInt("id");
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
  var user = User(
    username: username,
    nama: nama,
    password: password,
    nomor_telpon: no_hp,
  );
  await database
      .update('users', user.toMap(), where: 'id = ?', whereArgs: [where]);
  // var res = await database.execute(
  //     "UPDATE users SET id = NULL, username = '${username}', nama = '${nama}', password = '${password}', nomor_telpon = '${no_hp}' WHERE id = ? ",
  //     [2]);
  // print(await res);
}

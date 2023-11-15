import 'package:flutter/material.dart';

import '../../models/login_user.dart';
import '../../repository/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hideText = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Login"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                  hintText: "Insert your username",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  labelText: "Username"),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: password,
                obscureText: hideText,
                decoration: InputDecoration(
                  hintText: "Insert your Password",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  labelText: "Password",
                  suffixIcon: IconButton(
                      onPressed: () => changeStatusPassword(),
                      icon: Icon(
                          hideText ? Icons.visibility : Icons.visibility_off)),
                ),
              )),
          ElevatedButton(
              onPressed: () => processSubmit(), child: Text("Regist")),
          ElevatedButton(onPressed: () => processLogin(), child: Text("Login"))
        ],
      ),
    );
  }

  void changeStatusPassword() {
    setState(() {
      hideText = !hideText;
    });
  }

  Future processSubmit() async {
    // AuthService _auth = AuthService();
    dynamic result = await _authService.registerEmailPassword(
        LoginUser(name: username.text, password: password.text));
    if (result.uid == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(result.code),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(result.uid),
          );
        },
      );
    }
  }

  Future processLogin() async {
    // AuthService _auth = AuthService();
    dynamic result = await _authService.signInEmailPassword(
        LoginUser(name: username.text, password: password.text));
    if (result.uid == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(result.code),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success Login"),
            content: Text(result.uid),
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartup_project/screens/menu_options_screen.dart';

import '../auth/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passNodeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late String _mail;
  late String _pass;

  void _tryLogin() async {
    _formKey.currentState?.save();
    Login login = Login(mail: _mail, pass: _pass);
    if (await login.doLogin()) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MenuOptionsScreen()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passNodeFocus);
              },
              onSaved: (value) {
                value == null ? _mail = " " : _mail = value;
              },
              decoration: const InputDecoration(
                //label: Text("E-mail"),
                icon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              obscureText: true,
              focusNode: _passNodeFocus,
              onSaved: (value) {
                value == null ? _pass = " " : _pass = value;
              },
              onFieldSubmitted: (_) {
                _tryLogin();
              },
              decoration: const InputDecoration(
                //label: Text("Password"),
                icon: Icon(Icons.password),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _tryLogin();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

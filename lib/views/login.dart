import 'dart:developer';
import 'package:schedule_notification_app_demo/controller/logincontroller.dart';
import 'package:schedule_notification_app_demo/main.dart';
import 'package:schedule_notification_app_demo/views/biometric.dart';
import 'package:schedule_notification_app_demo/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/sql_helper.dart';
import '../../model/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  final _contro = Get.put(LoginController());
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _email = '';
  String _password = '';

  void _register() {
    Get.to(() => SignUp());
  }

  void _face() {
    Get.to(() => Biometric());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var loginBtn = Container(
        height: 50,
        width: 300,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          child: const Text(
            'LOGIN',
            style: TextStyle(
                fontFamily: "NexaBold", fontSize: 19, letterSpacing: 2),
          ),
          onPressed: () async {
            var db = DatabaseHelper();
            // db.getusers();
            db.getuser(_email);
            if (formKey.currentState != null &&
                formKey.currentState!.validate()) {
              var user = User("", _email, _password, true);
              // var db = DatabaseHelper();
              var userRetorno = User("", "", "", true);
              userRetorno = (await db.selectUser(user)) as User;
              // ignore: unnecessary_null_comparison
              if (userRetorno != null) {
                log(userRetorno.toString());
              } else {
                log(userRetorno.toString());
              }
            }
          },
        ));

    var loginForm = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Login",
            textScaleFactor: 2.0,
            style: TextStyle(
              fontFamily: "NexaBold",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please Enter Cms Id";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Cms Id',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(40.0), child: loginBtn),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Does not have account?'),
              TextButton(
                onPressed: _register,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 250,
        title: Image.asset('assets/logo.png', fit: BoxFit.cover),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      key: scaffoldKey,
      body: Center(
        child: loginForm,
      ),
    );
  }
}

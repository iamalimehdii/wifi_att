import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class attendance extends StatefulWidget {
  @override
  _attendanceState createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<void> senddata() async {
    var res = await http.post(
        Uri.parse("http://127.0.0.1:8080/practice_api/insertdata.php"),
        body: {
          "username": username.text,
          "email": email.text,
          "password": password.text,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 35,
                color: Color.fromARGB(255, 58, 51, 77),
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter Your Username',
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Username' : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Email' : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter Password' : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        senddata();
                      },
                      child: Text('Sign Up'),
                      color: Color.fromARGB(255, 58, 51, 77),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

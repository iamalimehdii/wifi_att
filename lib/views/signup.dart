import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/sql_helper.dart';
import '../../model/user_model.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "NexaBold",
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Name is Require";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Username is Require";
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
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
                        return "Password is Require";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      onPressed: _submit,
                      child: const Text(
                        'Create',
                        style: TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: 19,
                            letterSpacing: 2),
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  void _submit() {
    final form = formKey.currentState;

    if (form != null && form.validate()) {
      setState(() {
        _isLoading = true;

        if (form != null) {
          form.save();
        }

        var user = User(
          nameController.text,
          usernameController.text,
          passwordController.text,
          true,
        );

        var db = DatabaseHelper();
        db.saveUser(user).then((value) =>
            Fluttertoast.showToast(msg: "Account Created Successfully"));

        _isLoading = false;
        Get.back();
      });
    }
  }
}

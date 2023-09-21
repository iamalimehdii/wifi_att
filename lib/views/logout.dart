import 'package:schedule_notification_app_demo/main.dart';
import 'biometric.dart';
import 'package:schedule_notification_app_demo/views/login.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("LOG OUT"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/logout.png', // Replace with your image path
                    width: 250, // Adjust the width as needed
                    height: 250, // Adjust the height as needed
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: buildLogoutButton(context),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLogoutButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          'Log Out',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        ),
      );
}

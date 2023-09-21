import 'package:schedule_notification_app_demo/api/local_auth_api.dart';
import 'package:schedule_notification_app_demo/main.dart';
import 'package:schedule_notification_app_demo/views/logout.dart';
import 'package:flutter/material.dart';

const Color green = Color(0xff006600);

class Biometric extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          title: Text("VERIFY ATTENDANCE"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildHeader(),
                SizedBox(height: 32),
                buildAvailability(context),
                SizedBox(height: 24),
                buildAuthenticate(context),
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  buildText('Biometrics', isAvailable),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok'),
                )
              ],
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close,
                    color: Color.fromARGB(255, 29, 153, 76), size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Logout()),
            );
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          backgroundColor: green,
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget buildHeader() => Column(
        children: [
          Text(
            'FIngerprint or Face ID Authentication',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) {
              final colors = [Colors.green, Color.fromARGB(255, 14, 122, 32)];

              return RadialGradient(colors: colors).createShader(bounds);
            },
            child: Icon(Icons.face_retouching_natural,
                size: 100, color: Colors.white),
          ),
        ],
      );
}

import 'package:schedule_notification_app_demo/views/history.dart';
import 'package:schedule_notification_app_demo/views/login.dart';
import 'package:schedule_notification_app_demo/views/logout.dart';
import 'Services/notifi_service.dart';
import 'views/timer.dart';
import 'views/attendance.dart';
import 'package:schedule_notification_app_demo/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schedule_notification_app_demo/views/dashboard.dart';
import 'controller/logincontroller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:schedule_notification_app_demo/views/biometric.dart';

const Color green = Color(0xff006600);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Biometric Module';
  MaterialColor mycolor = MaterialColor(
    0xff006600,
    <int, Color>{
      50: Color(0xff006600),
      100: Color(0xff006600),
      200: Color(0xff006600),
      300: Color(0xff006600),
      400: Color(0xff006600),
      500: Color(0xff006600),
      600: Color(0xff006600),
      700: Color(0xff006600),
      800: Color(0xff006600),
      900: Color(0xff006600),
    },
  );

  MyApp({Key? key}) : super(key: key);
  final _contro = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: ThemeData(
          primarySwatch: mycolor,
        ),
        home: const SplashScreen()
        // LoginPage(),
        );
  }
}

class BottomNavBar extends StatefulWidget {
  // final String? username;
  const BottomNavBar({
    // this.username,
    key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt _selectedIndex = 0.obs;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(
      title: '',
    ),
    History(),
    Logout(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Obx(() => Center(
                child: _widgetOptions.elementAt(_selectedIndex.value),
              )),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  haptic: true,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 900),
                  gap: 8,
                  color: Colors.grey[800],
                  activeColor: Colors.green,
                  iconSize: 24,
                  tabBackgroundColor: Colors.green.withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  tabs: const [
                    GButton(
                      icon: Icons.wifi,
                      text: 'Attendance',
                    ),
                    GButton(
                      icon: Icons.history_rounded,
                      text: 'History',
                    ),
                    GButton(
                      icon: Icons.logout_rounded,
                      text: 'Logout',
                    )
                  ],
                  selectedIndex: _selectedIndex.value,
                  onTabChange: (index) {
                    _selectedIndex.value = index;
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 5;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TIME BEFORE ATTENDANCE',
        ),
        centerTitle: true,
        toolbarHeight: 60,
        backgroundColor: green,
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: const Color.fromARGB(255, 119, 197, 119),

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Color(0xff006600),

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Text Align for Countdown Text.

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.S,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: true,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: true,

          // This Callback will execute when the Countdown Starts.

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Navigate to the new page (face.dart) when the timer ends.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      attendance()), // Replace FacePage with the actual name of your face.dart file
            );
          },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Countdown Changed $timeStamp');
          },

          /* 
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
              the default behavior.
          */
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              // only format for '0'
              return "Attendance";
            } else {
              // other durations by it's default format
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

Widget buildLogoutButton(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      child: Text(
        'Logout',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => attendance()),
      ),
    );

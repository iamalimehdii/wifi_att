import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../../Services/notifi_service.dart';
import 'timer.dart';
import '../../main.dart';

class Dashboard extends StatefulWidget {
  /// Default constructor for [Dashboard] widget.
  const Dashboard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;

  bool get isStreaming => subscription != null;

  Future<void> _startScan(BuildContext context) async {
    // check if "can" startScan
    if (shouldCheckCan) {
      // check if can-startScan
      final can = await WiFiScan.instance.canStartScan();
      // if can-not, then show error
      if (can != CanStartScan.yes) {
        if (mounted)
          kShowSnackBar(context, "Can't Scan! Allow Location Services");
        return;
      }
    }

    // call startScan API
    final result = await WiFiScan.instance.startScan();
    if (mounted) kShowSnackBar(context, "startScan: $result");
    // reset access points.
    setState(() => accessPoints = <WiFiAccessPoint>[]);
  }

  Future<bool> _canGetScannedResults(BuildContext context) async {
    if (shouldCheckCan) {
      // check if can-getScannedResults
      final can = await WiFiScan.instance.canGetScannedResults();
      // if can-not, then show error
      if (can != CanGetScannedResults.yes) {
        if (mounted)
          kShowSnackBar(context, "Allow Location Services To Get Results");
        accessPoints = <WiFiAccessPoint>[];
        return false;
      }
    }
    return true;
  }

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      final results = await WiFiScan.instance.getScannedResults();
      setState(() => accessPoints = results);
    }
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => accessPoints = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }

  @override
  void dispose() {
    super.dispose();
    // stop subscription for scanned results
    _stopListeningToScanResults();
  }

  // build toggle with label
  Widget _buildToggle({
    required String label,
    bool value = false,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) =>
      Row(
        children: [
          if (label != null) Text(label),
          Switch(value: value, onChanged: onChanged, activeColor: activeColor),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VERIFY CLASS'),
          centerTitle: true,
          backgroundColor: Color(0xff006600),
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.location_on),
                      label: const Text('ALLOW'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff006600),
                        ), // Set the background color to blue
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set the text color to white
                      ),
                      onPressed: () async => _startScan(context),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.signal_wifi_4_bar),
                      label: const Text('SCAN'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff006600),
                        ), // Set the background color to blue
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set the text color to white
                      ),
                      onPressed: () async => _getScannedResults(context),
                    ),
                  ],
                ),
                const Divider(),
                Flexible(
                  child: Center(
                    child: accessPoints.isEmpty
                        ? const Text("NO SCANNED WIFIs")
                        : ListView.builder(
                            itemCount: accessPoints.length,
                            itemBuilder: (context, i) =>
                                _AccessPointTile(accessPoint: accessPoints[i])),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Show tile for AccessPoint.
///
/// Can see details when tapped.
class _AccessPointTile extends StatelessWidget {
  final WiFiAccessPoint accessPoint;

  const _AccessPointTile({Key? key, required this.accessPoint})
      : super(key: key);

  // build row that can display info, based on label: value pair.
  Widget _buildInfo(String label, dynamic value) => Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          children: [
            Text(
              "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(child: Text(value.toString()))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final title = accessPoint.ssid.isNotEmpty ? accessPoint.ssid : "**EMPTY**";

    // Check if signal strength is 60 dBM or greater
    final isStrongSignal = accessPoint.level >= -60;

    // Set the notification title and body
    final notificationTitle = 'Your Current Class';
    final notificationBody = 'You attendance can be marked in "$title" ';

    // If the signal is Strong, send a notification
    if (isStrongSignal) {
      NotificationService().showNotification(
        title: notificationTitle,
        body: notificationBody,
      );
    }

    final signalIcon = isStrongSignal
        ? Icons.signal_wifi_4_bar // Show a different icon for Strong signal
        : Icons.signal_wifi_0_bar;

    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(accessPoint.capabilities),
      onTap: () {
        // Show an AlertDialog as before

        // Now, navigate to the "TimerPage" when the notification is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimerPage(
              description: '',
              timer: MyHomePage(title: ''),
              title: 'NOTIFICATION',
            ),
          ),
        );
      },
    );
  }
}

/// Show snackbar.
void kShowSnackBar(BuildContext context, String message) {
  if (kDebugMode) print(message);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

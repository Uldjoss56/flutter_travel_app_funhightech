/*import 'dart:async';

import 'package:flutter/material.dart';


class MyAutoRefreshPage extends StatefulWidget {
  const MyAutoRefreshPage({super.key});

  @override
  _MyAutoRefreshPageState createState() => _MyAutoRefreshPageState();
}

class _MyAutoRefreshPageState extends State<MyAutoRefreshPage> {
  String data = "Initial Data"; // Initial data to display

  @override
  void initState() {
    super.initState();

    // Trigger an update every 20 seconds
    Timer.periodic(Duration(seconds: 20), (timer) {
      updateData(); // Function to update data
    });
  }

  // Function to simulate data update
  void updateData() {
    setState(() {
      data = "Updated Data at ${DateTime.now().toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Refresh Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Data:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              data,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
*/

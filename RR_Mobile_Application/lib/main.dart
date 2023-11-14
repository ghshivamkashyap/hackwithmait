import 'package:flutter/material.dart';
import 'package:qr_reader_app/screens/reader.dart';
import 'package:qr_reader_app/screens/scanqr.dart';
import 'package:qr_reader_app/screens/security_check.dart';

void main() {
  runApp(RapidReceiptsApp());
}

class RapidReceiptsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapid Receipts',
      theme: ThemeData(
        primaryColor: Color(0xFFFF6049), // Change primary color to orange
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapid Receipts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ScanScreen()));
                print('Reading QR code');
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2ECC71), // Use green color for "Start Shopping"
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('🛒 Start Shopping'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SecurityCheckScreen()));
                print('Performing Security Check');
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE74C3C), // Use red color for "Receipt Verification"
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('🔒 Receipt Verification'),
            ),
          ],
        ),
      ),
    );
  }
}

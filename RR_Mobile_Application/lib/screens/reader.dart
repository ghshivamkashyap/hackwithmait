// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:barcode_widget/barcode_widget.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: ScanScreen(),
//   ));
// }
//
// class ScanScreen extends StatefulWidget {
//   @override
//   _ScanScreenState createState() => _ScanScreenState();
// }
//
// class _ScanScreenState extends State<ScanScreen> {
//   List<String> cartItems = [];
//   Map<String, dynamic> productMap = {};
//   double totalPrice = 0.0;
//   List<String> productKeys = [];
//   String qrCodeData = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rapid Receipts'),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.shopping_cart),
//                 onPressed: () {
//                   // Navigate to the shopping cart or show cart contents
//                 },
//               ),
//               if (cartItems.isNotEmpty)
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.black,
//                     radius: 10,
//                     child: Text(
//                       cartItems.length.toString(),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (productMap.isNotEmpty)
//             Expanded(
//               child: ListView(
//                 children: productKeys.map((productId) {
//                   final productData = productMap[productId];
//                   final productName = productData['name'];
//                   final productPrice = productData['price'];
//                   totalPrice += productPrice;
//                   return Card(
//                     margin: EdgeInsets.all(8),
//                     elevation: 4,
//                     child: ListTile(
//                       title: Text('Product: $productName'),
//                       subtitle: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ),
//           if (qrCodeData.isNotEmpty)
//             Column(
//               children: [
//                 Text(
//                   'Scan it',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 BarcodeWidget(
//                   data: qrCodeData,
//                   barcode: Barcode.qrCode(),
//                   color: Colors.blue,
//                   height: 250,
//                   width: 250,
//                 ),
//               ],
//             ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: ElevatedButton(
//                   onPressed: scanQr,
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: Text('Add Items', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ),
//             if (cartItems.isNotEmpty)
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: ElevatedButton(
//                     onPressed: checkout,
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     child: Text('Checkout', style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> scanQr() async {
//     try {
//       FlutterBarcodeScanner.scanBarcode(
//         '#2A99CF',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       ).then((value) {
//         if (value.isNotEmpty) {
//           fetchApiData(value);
//         }
//       });
//     } catch (e) {
//       // Handle QR scan error
//     }
//   }
//
//   void checkout() async {
//     final productIds = productMap.keys.toList();
//     final apiUrl = 'https://gomall.techfestsliet.org/api/createbill';
//     final requestData = {
//       'products': productIds,
//     };
//     final requestBody = json.encode(requestData);
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: requestBody,
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final billId = responseData['bill'];
//
//         setState(() {
//           qrCodeData = billId;
//         });
//       } else {
//         print("Failed to create a bill. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   void fetchApiData(String scannedValue) async {
//     final apiUrl = 'https://gomall.techfestsliet.org/api/getproduct/$scannedValue';
//
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//
//       if (jsonData['iserror'] == false) {
//         final productData = jsonData['product'];
//         final id = productData['_id'];
//
//         productMap[id] = productData;
//         productKeys.add(id);
//
//         setState(() {
//           cartItems.add(scannedValue);
//         });
//       }
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:barcode_widget/barcode_widget.dart';

void main() {
  runApp(MaterialApp(
    home: ScanScreen(),
  ));
}

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<String> cartItems = [];
  Map<String, dynamic> productMap = {};
  double totalPrice = 0.0;
  List<String> productKeys = [];
  String qrCodeData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapid Receipts'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to the shopping cart or show cart contents
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 10,
                    child: Text(
                      cartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (productMap.isNotEmpty)
            Expanded(
              child: ListView(
                children: productKeys.map((productId) {
                  final productData = productMap[productId];
                  final productName = productData['name'];
                  final productPrice = productData['price'];
                  totalPrice += productPrice;
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 4,
                    child: ListTile(
                      title: Text('Product: $productName'),
                      subtitle: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          if (productMap.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          if (qrCodeData.isNotEmpty)
            Column(
              children: [
                Text(
                  'Scan it',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                BarcodeWidget(
                  data: qrCodeData,
                  barcode: Barcode.qrCode(),
                  color: Colors.blue,
                  height: 250,
                  width: 250,
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: scanQr,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2ECC71), // Use green color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text('Add Items', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            if (cartItems.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: checkout,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF6049), // Use orange color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('Checkout', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode(
        '#2A99CF',
        'Cancel',
        true,
        ScanMode.QR,
      ).then((value) {
        if (value.isNotEmpty) {
          fetchApiData(value);
        }
      });
    } catch (e) {
      // Handle QR scan error
    }
  }

  void checkout() async {
    final productIds = productMap.keys.toList();
    final apiUrl = 'https://gomall.techfestsliet.org/api/createbill';
    final requestData = {
      'products': productIds,
    };
    final requestBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final billId = responseData['bill'];

        setState(() {
          qrCodeData = billId;
        });
      } else {
        print("Failed to create a bill. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void fetchApiData(String scannedValue) async {
    final apiUrl = 'https://gomall.techfestsliet.org/api/getproduct/$scannedValue';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['iserror'] == false) {
        final productData = jsonData['product'];
        final id = productData['_id'];

        productMap[id] = productData;
        productKeys.add(id);

        setState(() {
          cartItems.add(scannedValue);
        });
      }
    }
  }
}



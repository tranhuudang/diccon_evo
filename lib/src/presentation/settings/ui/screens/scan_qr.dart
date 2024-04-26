import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class LoginInfo {
  String computerName;
  String os;
  String productId;
  DateTime requestTime;
  String userEmail;

  LoginInfo({
    required this.computerName,
    required this.os,
    required this.productId,
    required this.requestTime,
    required this.userEmail,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      computerName: json['computerName'],
      os: json['os'],
      productId: json['productId'],
      requestTime: (json['requestTime'] as Timestamp).toDate(),
      userEmail: json['userEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'computerName': computerName,
      'os': os,
      'productId': productId,
      'requestTime': Timestamp.fromDate(requestTime),
      'userEmail': userEmail,
    };
  }

  LoginInfo copyWith({
    String? computerName,
    String? os,
    String? productId,
    DateTime? requestTime,
    String? userEmail,
  }) {
    return LoginInfo(
      computerName: computerName ?? this.computerName,
      os: os ?? this.os,
      productId: productId ?? this.productId,
      requestTime: requestTime ?? this.requestTime,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  late QRViewController? qrViewController;
  late Barcode? barcode = null;

  late LoginInfo? loginInfo = null;

  Future<LoginInfo?> getLoginInfo(String code) async {
    final dataTrack = FirebaseFirestore.instance.collection("Login").doc(code);
    final documentSnapshot = await dataTrack.get();

    if (documentSnapshot.exists) {
      loginInfo = LoginInfo.fromJson(documentSnapshot.data()!);
      return loginInfo;
    } else {
      return null;
    }
  }

  void setLoginData(String code) async {
    final dataTrack = FirebaseFirestore.instance.collection("Login").doc(code);
    final String? email = FirebaseAuth.instance.currentUser?.email;
    final newLoginData = loginInfo?.copyWith(userEmail: email);
    await dataTrack.set(newLoginData!.toJson());
  }

  @override
  Widget build(BuildContext context) {
    final qrViewKey = GlobalKey(debugLabel: 'QR');
    return Scaffold(
      appBar: AppBar(
        title: Text('QR login'.i18n),
      ),
      body: loginInfo == null
              ? Column(
                children: [
                  Expanded(
                    child: QRView(
                        key: qrViewKey,
                        onQRViewCreated: (QRViewController controller) {
                          qrViewController = controller;
                          // Flag to prevent multiple scans
                          controller.scannedDataStream.listen((scanData) async {
                            if (scanData.code != null) {
                              qrViewController?.stopCamera();
                              controller.dispose();
                              setState(() {
                                barcode = scanData;
                              });
                              print(scanData.code);
                    
                              loginInfo = await getLoginInfo(scanData.code!);
                              // Update UI after loginInfo is fetched
                              setState(() {});
                            }
                          });
                        },
                      ),
                  ),
                  Container(child:
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instructions:'),
                          Text('1: Point your device towards the QR code displayed on the Windows device screen.'),
                        Text('2: Wait for the scanner to recognize and process the QR code.'),
                          Text('3: Once the QR code is successfully scanned, you will able to get access to required-login function in Windows devices.'),
                        ],
                      ),
                    ),)
                ],
              )
              : Column(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          context.theme.colorScheme.primary, BlendMode.srcIn),
                      child: Image(
                        image: AssetImage(
                            LocalDirectory.textRecognizerIllustration),
                        height: 200,
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.height,
                          Text('Do you want to login to this device?'.i18n),
                          Text(
                              '${'Computer name'.i18n}: ${loginInfo!.computerName}',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            'OS: ${loginInfo?.os}',
                            style: context.theme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                    8.height,
                    FilledButton(
                        onPressed: () {
                          if (barcode!.code != null) {
                            setLoginData(barcode!.code!);
                          }
                          context.showSnackBar(content: "Login successful");
                          context.pop();
                        },
                        child: Text('Log in'.i18n))
                  ],
                ),

    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConnectAccountView extends StatefulWidget {
  const ConnectAccountView({super.key});

  @override
  State<ConnectAccountView> createState() => _ConnectAccountViewState();
}

class _ConnectAccountViewState extends State<ConnectAccountView> {
  late Timer timer;

  late Future<String> uniqueCode;

  bool isLoginSuccess = false;

  void waitingForScanQR() async {
    final code = await Md5Generator.composeMD5IdForFirebaseDbDesktopLogin();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      print('Waiting for user scan QR');
      final dataTrack =
          FirebaseFirestore.instance.collection("Login").doc(code);
      final documentSnapshot = await dataTrack.get();

      if (documentSnapshot.exists) {
        var userId = documentSnapshot.data()?["userEmail"];
        print(userId);
        if (userId != '') {
          timer.cancel();
          setState(() {
            isLoginSuccess = true;
          });
        }
      }
    });
  }

  void createLoginRequest() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    String productId = windowsInfo.productId;
    String computerName = windowsInfo.computerName;
    String os = windowsInfo.buildNumber > 10240 ? 'Windows 11' : 'Windows 10';
    final code = await Md5Generator.composeMD5IdForFirebaseDbDesktopLogin();
    final dataTrack = FirebaseFirestore.instance.collection("Login").doc(code);
    final loginData = {
      'os': os,
      'productId': productId,
      'computerName': computerName,
      'requestTime': DateTime.now(),
      'userEmail': ''
    };
    await dataTrack.set(loginData);
  }

  @override
  void initState() {
    super.initState();
    uniqueCode = Md5Generator.composeMD5IdForFirebaseDbDesktopLogin();
    createLoginRequest();
    waitingForScanQR();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'.i18n),
      ),
      body: Column(
        children: [
          !isLoginSuccess
              ? Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Wrap(
                          children: [
                            Text(
                                'Please use your phone and click at menu button:'
                                    .i18n),
                            const Icon(Icons.menu),
                            3.width,
                            const Icon(Icons.arrow_forward),
                            3.width,
                            Text(
                              'Account'.i18n,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            3.width,
                            const Icon(Icons.arrow_forward),
                            3.width,
                            Text(
                              'Scan to login'.i18n,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: uniqueCode,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return QrImageView(
                                data: snapshot.data!,
                                version: QrVersions.auto,
                                size: 150,
                                backgroundColor: Colors.white,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 60.w,
                    child: Column(
                      children: [
                        50.height,
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              context.theme.colorScheme.primary,
                              BlendMode.srcIn),
                          child: Image(
                            image: AssetImage(
                                LocalDirectory.textRecognizerIllustration),
                            height: 200,
                          ),
                        ),
                        Text(
                          'Login successful'.i18n,
                          style: context.theme.textTheme.headlineMedium,
                        ),
                        16.height,
                        Text(
                            'Congratulations! Your login was successful. You can now enjoy using the app on Windows just like you would on Android.'
                                .i18n),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

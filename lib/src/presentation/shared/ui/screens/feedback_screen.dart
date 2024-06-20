import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      String feedback = _feedbackController.text;
      String os = '';
      String device = '';
      if (Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        os = "${androidInfo.version.baseOS} ${androidInfo.version.release}";
        device = androidInfo.device;
      }
      if (Platform.isWindows){
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;

        os = windowsInfo.buildNumber > 10240 ? 'Windows 11' : 'Windows 10';
        device = windowsInfo.computerName;
      }
      await FirebaseFirestore.instance.collection(FirebaseConstant.firestore.feedback).add({
        'feedback': feedback,
        'email': currentUser?.email ?? '',
        'device': device,
        'os': os,
        'diccon-version': NumberConstants.appVersion,
        'timestamp': FieldValue.serverTimestamp(),
      });

      context.showSnackBar(
        content: 'Feedback submitted successfully!'.i18n,
      );

      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'.i18n),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(LocalDirectory.textRecognizerIllustration),
                  height: 140,
                ),
              ),
              32.height,
              Text(
                  'Your feedback matters! Help us improve your learning experience by sharing your thoughts. We appreciate your input and use it to make our app better for you.'
                      .i18n),
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(labelText: 'Feedback'.i18n),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback'.i18n;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text('Send'.i18n),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

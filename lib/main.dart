import 'dart:io';
import 'package:diccon_evo/bloc_provider_scope.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'firebase_options.dart';

part 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _Initializer.start();
  runApp(
    const BlocProviderScope(
        child: App(),
      ),
  );
}

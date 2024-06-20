import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diccon_evo/src/core/core.dart';

class Md5Generator {
  static Future<String> composeMD5IdForFirebaseDbDesktopLogin() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    var deviceId = windowsInfo.deviceId;
    var bytes = utf8.encode(deviceId);
    var resultMd5 = md5.convert(bytes);
    log('Created MD5 for Desktop login');
    return resultMd5.toString();
  }

  static String composeMd5IdForFirebaseDbPremium({required String userEmail}) {
    userEmail = userEmail.trim().toLowerCase();
    var composeString = userEmail + Env.premiumToken;
    var bytes = utf8.encode(composeString);
    var resultMd5 = md5.convert(bytes);
    return resultMd5.toString();
  }

  static String composeMd5IdForStoryFirebaseDb({required String sentence}) {
    return _composeMd5(fromString: sentence);
  }

  static String composeMd5IdForDialogueReadState({required String fromConversationDescription}) {
    return _composeMd5(fromString: fromConversationDescription);
  }

  static String composeMd5IdForWordDefinitionFirebaseDb(
      {required String word, required String options, required String lang}) {
    word = word.trim().toLowerCase();
    options = options.trim();
    var composeString = word + options + lang;
    var bytes = utf8.encode(composeString);
    var resultMd5 = md5.convert(bytes);
    return resultMd5.toString();
  }

  static String composeMd5IdForSoloConversationFileName(
      {required String sentence}) {
    return _composeMd5(fromString: sentence);
  }

  static String _composeMd5({required String fromString}) {
    fromString = fromString.toLowerCase().trim();
    final composeString = fromString;
    final bytes = utf8.encode(composeString);
    final resultMd5 = md5.convert(bytes);
    final result = resultMd5.toString();
    DebugLog.info(result);
    return result;
  }
}

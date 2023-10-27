import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

Widget playStoreBadge() {
  return InkWell(
    onTap: () async {
      final Uri url = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.zeroboy.diccon_evo');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }, // Replace with your image path

    child: Image.asset(
      "assets/badges/en_badge_web_generic.png",
    ),
  );
}

Widget amazonStoreBadge() {
  return InkWell(
    onTap: () async {
      final Uri url =
      Uri.parse('https://www.amazon.com/dp/B0CBP3XSQJ/ref=apps_sf_sta');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }, // Replace with your image path

    child: Image.asset(
      "assets/badges/amazon-appstore-badge-english-white.png",
    ),
  );
}

Widget microsoftStoreBadge() {
  return InkWell(
    onTap: () async {
      final Uri url = Uri.parse(
          'https://apps.microsoft.com/store/detail/diccon-evo/9NPF4HBMNG5D');
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }, // Replace with your image path

    child: SvgPicture.asset(
      "assets/badges/ms-en-US-dark.svg",
    ),
  );
}
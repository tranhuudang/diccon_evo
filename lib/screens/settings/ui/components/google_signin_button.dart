import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
class GoogleSignInButton extends StatelessWidget {
  final Function()? onPressed;
  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              padding: const EdgeInsets.all(3),
              color: Colors.white,
              child: const Image(
                height: 20,
                image: AssetImage("assets/google.svg"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text("Continue with Google".i18n),
        ],
      ),
    );
  }
}

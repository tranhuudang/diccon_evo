import 'package:flutter/material.dart';

class PlanButton extends StatelessWidget {
  const PlanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Text("BETA", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
    );
  }
}
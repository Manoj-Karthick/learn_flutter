import 'package:flutter/material.dart';

class Modes extends StatelessWidget {
  const Modes(this.mode, this.isActive, this.handleMode, {super.key});

  final Map<String, dynamic> mode;
  final bool isActive;
  final Function(String) handleMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          handleMode(mode["key"]!);
        },
        child: Text(
          mode["name"]!,
          style: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

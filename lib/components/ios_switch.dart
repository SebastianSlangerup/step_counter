import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosSwitch extends StatefulWidget {
  const IosSwitch({
    super.key,
    required this.isEnabled,
    required this.onChanged, // Add this line
  });

  final bool isEnabled;
  final Function(bool) onChanged; // Add this line

  @override
  State<IosSwitch> createState() => _IosSwitchState();
}

class _IosSwitchState extends State<IosSwitch> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: widget.isEnabled,
      activeColor: CupertinoColors.activeGreen,
      onChanged: widget.onChanged, // Use the passed onChanged function
    );
  }
}
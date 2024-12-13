import 'package:flutter/material.dart';

class NavigationDelay extends StatefulWidget {
  final Duration delayDuration;
  final Widget navigateTo;
  final Widget child;

  const NavigationDelay({
    super.key,
    required this.delayDuration,
    required this.navigateTo,
    required this.child,
  });

  @override
  _NavigationDelayState createState() => _NavigationDelayState();
}

class _NavigationDelayState extends State<NavigationDelay> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delayDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.navigateTo),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

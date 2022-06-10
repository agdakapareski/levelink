import 'package:flutter/material.dart';

class PaddedWidget extends StatelessWidget {
  final Widget? child;
  const PaddedWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

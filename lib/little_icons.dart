import 'package:flutter/material.dart';

class LittleIcons extends StatelessWidget {
  const LittleIcons({
    Key? key,
    required this.isCorrect,
  }) : super(key: key);

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    if (isCorrect) {
      return const Icon(
        Icons.check,
        color: Colors.green,
        size: 30.0,
      );
    } else {
      return const Icon(
        Icons.close,
        color: Colors.red,
        size: 30.0,
      );
    }
  }
}

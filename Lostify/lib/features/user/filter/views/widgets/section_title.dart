import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final TextStyle style;

  const SectionTitle(this.text, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

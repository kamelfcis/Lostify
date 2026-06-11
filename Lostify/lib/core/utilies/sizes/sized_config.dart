import 'package:flutter/material.dart';

class SizeConfig {
  // Sensible fallback dimensions (logical pixels) used until init() is called
  // with a valid non-zero size (e.g. Samsung A56 ≈ 384 × 832 dp).
  static double width = 375.0;
  static double height = 812.0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Only update when the platform has reported a real layout size.
    if (size.width > 0 && size.height > 0) {
      width = size.width;
      height = size.height;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CommonText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? GoogleFonts.urbanist(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/theme.dart' as colors;

class Button extends StatelessWidget {
  final String labelText;
  final Function onTap;
  const Button({
    Key? key,
    required this.labelText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
            color: colors.Colors.yellowColor,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            labelText,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyboardNumberWidget extends StatelessWidget {
  final String? number;
  final Function()? onPressed;
  const KeyboardNumberWidget({Key? key, this.number, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Text(
            number!,
            style: GoogleFonts.ubuntu(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 48,
            ),
          ),
        ),
      ),
    );
  }
}
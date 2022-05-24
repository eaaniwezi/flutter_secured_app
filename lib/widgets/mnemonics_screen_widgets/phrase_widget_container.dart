import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhraseWidgetContainer extends StatelessWidget {
  const PhraseWidgetContainer({
    Key? key,
    required this.phrases,
  }) : super(key: key);

  final String phrases;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffCCCCCC)),
        child: Center(
          child: Text(
            phrases,
            style: GoogleFonts.ubuntu(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

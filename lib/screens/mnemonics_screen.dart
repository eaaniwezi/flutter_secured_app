import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secured_flutter_app/widgets/button.dart';

class MnemonicsScreen extends StatelessWidget {
  const MnemonicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Button(labelText: "Назад", onTap: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            _headerText(text: "Помните!", isHeader: true),
            _descriptionText(),
            _headerText(text: "Ваше секретная фраза", isHeader: false),
          ],
        ),
      ),
    );
  }

  _descriptionText() {
    return Text(
      "\nНикому не передавайте кодовую фразу,\nсохраните ее в надежном месте. Если вы\nпотеряете фразу, вы не сможете\nвостановить доступ к кошельку.\n\n",
      textAlign: TextAlign.center,
      style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xff6A6A6A)),
    );
  }

  _headerText({
    required String text,
    required bool isHeader,
  }) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
          fontWeight: isHeader == true ? FontWeight.w700 : FontWeight.w500,
          fontSize: isHeader == true ? 32 : 16,
        ),
      ),
    );
  }
}

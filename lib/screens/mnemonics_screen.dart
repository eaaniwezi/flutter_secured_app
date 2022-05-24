// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../const/theme.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:secured_flutter_app/widgets/button.dart';
import 'package:secured_flutter_app/repositories/security_repository.dart';
import 'package:secured_flutter_app/widgets/mnemonics_screen_widgets/mnemonics_builder_widget.dart';

class MnemonicsScreen extends StatelessWidget {
  const MnemonicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final securityRepository = SecurityRepository();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      bottomNavigationBar: Button(labelText: "Назад", onTap: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.04),
            _headerText(text: "Помните!", isHeader: true),
            _descriptionText(),
            _headerText(text: "Ваше секретная фраза\n\n", isHeader: false),
            MnemonicsBuilderWidget(securityRepository: securityRepository),
            SizedBox(height: size.height * 0.025),
            Button(
              textColor: colors.Colors.blueColor,
              buttonColor: colors.Colors.blueColor,
              labelText: "Скопировать",
              onTap: () {},
            )
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

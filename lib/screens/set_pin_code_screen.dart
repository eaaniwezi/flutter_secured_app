// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:secured_flutter_app/screens/mnemonics_screen.dart';

import '../const/theme.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secured_flutter_app/repositories/security_repository.dart';
import 'package:secured_flutter_app/widgets/pin_code_screen_widgets/digit_holder_widget.dart';
import 'package:secured_flutter_app/widgets/pin_code_screen_widgets/keyboard_number_widget.dart';

class SetPinCodeScreen extends StatefulWidget {
  const SetPinCodeScreen({Key? key}) : super(key: key);

  @override
  State<SetPinCodeScreen> createState() => _SetPinCodeScreenState();
}

class _SetPinCodeScreenState extends State<SetPinCodeScreen> {
  var selectedindex = 0;
  String code = '';
  final securityRepository = SecurityRepository();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: numPad(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.3),
            Text('Создайте PIN-код',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: colors.Colors.greyColor,
                )),
            SizedBox(height: 20),
            buildPinRow(),
          ],
        ),
      ),
    );
  }

  buildPinRow() {
    var width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DigitHolder(
            width: width, index: 0, selectedIndex: selectedindex, code: code),
        DigitHolder(
            width: width, index: 1, selectedIndex: selectedindex, code: code),
        DigitHolder(
            width: width, index: 2, selectedIndex: selectedindex, code: code),
        DigitHolder(
            width: width, index: 3, selectedIndex: selectedindex, code: code),
      ],
    );
  }

  numPad() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumberWidget(
                number: "1",
                onPressed: () {
                  addDigit(1);
                },
              ),
              KeyboardNumberWidget(
                number: "2",
                onPressed: () {
                  addDigit(2);
                },
              ),
              KeyboardNumberWidget(
                number: "3",
                onPressed: () {
                  addDigit(3);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumberWidget(
                number: "4",
                onPressed: () {
                  addDigit(4);
                },
              ),
              KeyboardNumberWidget(
                number: "5",
                onPressed: () {
                  addDigit(5);
                },
              ),
              KeyboardNumberWidget(
                number: "6",
                onPressed: () {
                  addDigit(6);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumberWidget(
                number: "7",
                onPressed: () {
                  addDigit(7);
                },
              ),
              KeyboardNumberWidget(
                number: "8",
                onPressed: () {
                  addDigit(8);
                },
              ),
              KeyboardNumberWidget(
                number: "9",
                onPressed: () {
                  addDigit(9);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    backspace();
                  },
                  icon: Text(
                    "Назад",
                    style: GoogleFonts.ubuntu(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              KeyboardNumberWidget(
                number: "0",
                onPressed: () {
                  addDigit(0);
                },
              ),
              IconButton(
                highlightColor: code.length == 4 ? null : Colors.white,
                splashColor: code.length == 4 ? null : Colors.white,
                onPressed: () {
                  code.length == 4 ? submit() : print("scan me");
                },
                icon: code.length == 4
                    ? SvgPicture.asset("assets/good.svg")
                    : Text(""),
              ),
            ],
          ),
        ],
      ),
    );
  }

  submit() async {
    final bool savedPin = await securityRepository.setPinCode(pinCode: code);
    if (savedPin == true) {
      setState(() {
        code = '';
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return MnemonicsScreen();
      }), (route) => false);
    }
  }

  addDigit(int digit) {
    if (code.length < 4) {
      setState(() {
        code = code + digit.toString();

        selectedindex = code.length;
      });
    }
  }

  backspace() {
    if (code.isEmpty) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
    });
  }
}

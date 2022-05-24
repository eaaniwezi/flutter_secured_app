// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../const/theme.dart' as colors;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:stream_duration/stream_duration.dart';
import 'package:secured_flutter_app/screens/mnemonics_screen.dart';
import 'package:secured_flutter_app/repositories/security_repository.dart';
import 'package:secured_flutter_app/widgets/pin_code_screen_widgets/digit_holder_widget.dart';
import 'package:secured_flutter_app/widgets/pin_code_screen_widgets/keyboard_number_widget.dart';

class LoginPinCodeScreen extends StatefulWidget {
  const LoginPinCodeScreen({Key? key}) : super(key: key);

  @override
  State<LoginPinCodeScreen> createState() => _LoginPinCodeScreenState();
}

class _LoginPinCodeScreenState extends State<LoginPinCodeScreen> {
  String code = '';
  var selectedindex = 0;
  bool wrongCode = false;
  int numberOfTrials = 0;
  String? leftTrials;
  bool isBlocked = false;
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
            isBlocked == false
                ? _textWidget('Введите PIN-код')
                : Text('Приложение\nзаблокировано',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.black,
                    )),
            SizedBox(height: 20),
            isBlocked == false
                ? buildPinRow()
                : _textWidget("Повторите попытку через"),
            SizedBox(height: isBlocked == false ? 20 : 0),
            (isBlocked == false)
                ? wrongCode == true
                    ? _textWidget('Осталось $leftTrials попыток!')
                    : _textWidget("")
                : _textWidget(""),
            isBlocked == false ? _textWidget("") : _countDown()
          ],
        ),
      ),
    );
  }

  _countDown() {
    return SlideCountdown(
      padding: EdgeInsets.only(top: 0, bottom: 0),
      duration: Duration(minutes: 100000, seconds: 30),
      streamDuration:
          StreamDuration(Duration(minutes: 4, seconds: 30), onDone: () {
        securityRepository.blockAccount(isBlocked: "FALSE");
        setState(() {
          isBlocked = false;
        });
      }),
      decoration: BoxDecoration(color: Colors.white),
      textStyle: GoogleFonts.ubuntu(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: colors.Colors.greyColor,
      ),
    );
  }

  _textWidget(String titile) {
    return Center(
      child: Text(titile,
          textAlign: TextAlign.center,
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: colors.Colors.greyColor,
          )),
    );
  }

  buildPinRow() {
    var width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DigitHolder(
            wrongCode: wrongCode,
            width: width,
            index: 0,
            selectedIndex: selectedindex,
            code: code),
        DigitHolder(
            wrongCode: wrongCode,
            width: width,
            index: 1,
            selectedIndex: selectedindex,
            code: code),
        DigitHolder(
            wrongCode: wrongCode,
            width: width,
            index: 2,
            selectedIndex: selectedindex,
            code: code),
        DigitHolder(
            wrongCode: wrongCode,
            width: width,
            index: 3,
            selectedIndex: selectedindex,
            code: code),
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
                    "Выйти",
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
                onPressed: () {
                  code.isEmpty ? fingerPrintScan() : backspace();
                },
                icon: SvgPicture.asset(
                  code.isEmpty ? "assets/scan.svg" : "assets/clear.svg",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  fingerPrintScan() async {
    final result = await securityRepository.bioMetrics();
    if (result == true) {
      setState(() {
        code = '';
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return MnemonicsScreen();
      }), (route) => false);
    } else {
      setState(() {
        numberOfTrials++;
      });
      var result = await securityRepository.numberOfTrials(
          numberOfTrials: numberOfTrials);
      leftTrials = result.toString();
      setState(() {});
      if (result <= 0) {
        await securityRepository.blockAccount(isBlocked: "TRUE");
        setState(() {
          isBlocked = true;
        });
      }
    }
  }

  submit() async {
    final bool pinCode = await securityRepository.loginCode(pinCode: code);
    if (pinCode == true) {
      setState(() {
        code = '';
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return MnemonicsScreen();
      }), (route) => false);
    } else {
      setState(() {
        wrongCode = true;
        numberOfTrials++;
      });
      var result = await securityRepository.numberOfTrials(
          numberOfTrials: numberOfTrials);
      leftTrials = result.toString();
      setState(() {});
      if (result <= 0) {
        await securityRepository.blockAccount(isBlocked: "TRUE");
        setState(() {
          isBlocked = true;
        });
      }
    }
  }

  addDigit(int digit) {
    if (isBlocked == false) {
      if (code.length < 4) {
        setState(() {
          code = code + digit.toString();

          selectedindex = code.length;
        });
      }

      if (code.length == 4) {
        submit();
      }
    } else {}
  }

  backspace() {
    if (code.isEmpty) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
      wrongCode = false;
    });
  }
}

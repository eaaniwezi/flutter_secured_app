// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../const/theme.dart' as colors;

class DigitHolder extends StatelessWidget {
  final int? selectedIndex;
  final int? index;
  final String? code;
  const DigitHolder({
    @required this.selectedIndex,
    Key? key,
    @required this.width,
    this.index,
    this.code,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 16,
      width: 16,
      margin: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          color: colors.Colors.greyColor.withOpacity(0.2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: index == selectedIndex
                  ? Colors.transparent
                  : Colors.transparent,
              offset: Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ]),
      child: code!.length > index!
          ? Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: code!.length == 4
                    ? colors.Colors.greenColor
                    : colors.Colors.orangeColor,
                shape: BoxShape.circle,
              ),
            )
          : Container(),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:secured_flutter_app/repositories/security_repository.dart';
import 'package:secured_flutter_app/widgets/mnemonics_screen_widgets/phrase_widget_container.dart';

class MnemonicsBuilderWidget extends StatelessWidget {
  const MnemonicsBuilderWidget({
    Key? key,
    required this.securityRepository,
  }) : super(key: key);

  final SecurityRepository securityRepository;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Color(0xffF3F6F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 5),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: securityRepository.getMnemonics().length,
          itemBuilder: (context, index) {
            var phrases = securityRepository.getMnemonics()[index];
            return PhraseWidgetContainer(phrases: phrases);
          },
        ),
      ),
    );
  }
}

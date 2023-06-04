import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.btnIcon,
  });
  final Widget btnIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 70,
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.elliptical(35, 35),
        ),
        border: Border.fromBorderSide(
          BorderSide(width: 1),
        ),
      ),
      child: btnIcon,
    );
  }
}

import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String text;
  final TextStyle? subTitleStyle;

  const InfoText({super.key, required this.text, this.subTitleStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        text,
        style: subTitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class SmallInfoText extends StatelessWidget {
  final String text;
  final TextStyle? subTitleStyle;

  const SmallInfoText({super.key, required this.text, this.subTitleStyle});

  @override
  Widget build(BuildContext context) {
    final smallInfoTextStyle = Theme.of(context).textTheme.titleSmall;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        text,
        style: smallInfoTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

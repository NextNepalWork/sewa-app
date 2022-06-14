import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/constants.dart';

class SewaLogo extends StatelessWidget {
  const SewaLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.splashLogo,
      fit: BoxFit.cover,
    );
  }
}

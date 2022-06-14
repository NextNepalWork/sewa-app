import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/value_manager.dart';

class TitleHeading extends StatelessWidget {
  final void Function() onTap;
  final String? text1;
  final String? text2;
  const TitleHeading({Key? key, required this.onTap, this.text1, this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text1 ?? "",
            style: Theme.of(context).textTheme.headline1,
          ),
          GestureDetector(
            onTap: onTap,
            child: LocaleText(
              text2 ?? AppStrings.seeMore,
              style: getSemiBoldStyle(
                  color: ColorManager.primaryBlue.withOpacity(1),
                  fontSize: SewaFontSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}

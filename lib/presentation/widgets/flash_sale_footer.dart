import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:sewa_digital/constant/constants.dart';

class FlashSaleFooter extends StatelessWidget implements PreferredSizeWidget {
  final int? endDate;
  const FlashSaleFooter({Key? key, this.endDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p20 + AppPadding.p20,
          right: AppPadding.p20 + AppPadding.p20,
          bottom: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.flash_on,
                color: ColorManager.white,
              ),
              Text(
                "Hurry Up",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: ColorManager.white),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: ColorManager.white)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: CountdownTimer(
                endTime: int.parse(endDate.toString()) * 1000,
                endWidget: SizedBox(
                  width: 185,
                  child: Text(
                    "The Current Time has expired",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: ColorManager.white, fontSize: SewaFontSize.s12),
                  ),
                ),
                textStyle: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: ColorManager.white),
                onEnd: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(70);
  }
}

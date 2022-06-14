import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';

class SewaSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SewaSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.searchProductRoute);
              },
              child: Container(
                height: 40.0,
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: ColorManager.grey1,
                      size: 24,
                    ),
                    const SizedBox(
                      width: AppSize.s8,
                    ),
                    LocaleText(
                      AppStrings.searchProduct,
                      style: getMediumStyle(
                        color: ColorManager.grey1,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s16,
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(70);
  }
}

import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/constants.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.customerSupport),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s10)),
            elevation: 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sewaHeader(),
                  const SizedBox(
                    height: AppSize.s14,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sewaTitle(AppStrings.location),
                          sewaTitle(AppStrings.name),
                          sewaTitle(AppStrings.email + "    "),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sewaSubtitle("Kathmandu"),
                          sewaSubtitle("9863667252"),
                          sewaSubtitle("info@sewa.com")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  sewaTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        title,
        style: getBoldStyle(color: ColorManager.grey, fontSize: AppSize.s14),
      ),
    );
  }

  sewaSubtitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p5),
      child: Text(
        title,
        style: getSemiBoldStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorManager.white
              : ColorManager.black,
        ),
      ),
    );
  }

  sewaHeader() {
    return Image.asset(
      ImageAssets.appLogo,
      fit: BoxFit.cover,
      height: 120,
    );
  }
}

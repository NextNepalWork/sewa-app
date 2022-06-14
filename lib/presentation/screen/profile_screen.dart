import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:sewa_digital/presentation/pages/address_page.dart';
import 'package:sewa_digital/presentation/pages/change_password_page.dart';
import 'package:sewa_digital/presentation/pages/order_page.dart';
import 'package:sewa_digital/presentation/pages/payment_page.dart';
import 'package:sewa_digital/presentation/pages/profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: const LocaleText(AppStrings.profile),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s10,
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p15),
                  child: SizedBox(
                    height: 45,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => switchIndex(index)!));
                      },
                      minLeadingWidth: 15.0,
                      leading: Icon(profileData[index].icon),
                      title: LocaleText(
                        profileData[index].title,
                        style: getMediumStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                            fontSize: AppSize.s14),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p20 + AppPadding.p10),
                  child: Divider(),
                );
              },
              itemCount: profileData.length)
        ],
      ),
    );
  }

  Widget? switchIndex(int index) {
    switch (index) {
      case 0:
        return const ProfilePage();
      case 1:
        return const OrderHistoryPage(
          uniqueKey: "uniqueKey",
        );
      case 2:
        return const AddressPage();
      case 3:
        return const ChangePasswordPage();
      case 4:
        return const PaymentPage();

      default:
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/cubit/theme_cubit.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:launch_review/launch_review.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int value = 0;
  var languages = <String>["English", "नेपाली"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.setting),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListTile(
              minLeadingWidth: 15.0,
              leading: const Icon(Icons.dark_mode),
              title: LocaleText(AppStrings.dark,
                  style: Theme.of(context).textTheme.subtitle1),
              trailing: BlocBuilder<SwitchCubit, SwitchState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDarkThemeOn,
                    onChanged: (value) {
                      context.read<SwitchCubit>().toggleSwitch(value);
                    },
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Divider(),
          ),
          Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTileTheme(
                  minVerticalPadding: 0,
                  dense: true,
                  child: ExpansionTile(
                      leading: Icon(
                        Icons.language_outlined,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorManager.white
                            : ColorManager.grey,
                      ),
                      title: LocaleText(AppStrings.lang,
                          style: Theme.of(context).textTheme.subtitle1),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorManager.white
                            : ColorManager.grey,
                      ),
                      children: List.generate(languages.length, (index) {
                        var lang = languages[index];
                        value = UserPreferences.getLang() == null
                            ? value
                            : UserPreferences.getLang()!;
                        return RadioListTile(
                          value: index,
                          groupValue: value,
                          onChanged: (val) async {
                            setState(() {
                              value = int.parse(val.toString());
                            });
                            await UserPreferences.setLang(value);
                            switchLanguage(value);
                          },
                          title: Text(
                            lang.toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        );
                      })),
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Divider(),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 45,
                    child: ListTile(
                      onTap: () {
                        switchIndex(index);
                      },
                      minLeadingWidth: 15.0,
                      leading: Icon(settingData[index].icon),
                      title: LocaleText(settingData[index].title,
                          style: Theme.of(context).textTheme.subtitle1),
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
                  padding: EdgeInsets.only(left: 30, right: 30, top: 8),
                  child: Divider(),
                );
              },
              itemCount: settingData.length),
        ],
      ),
    );
  }

  switchIndex(int index) {
    switch (index) {
      case 0:
        return Navigator.pushNamed(context, Routes.termsRoute);
      case 1:
        return Navigator.pushNamed(context, Routes.returnPolicyRoute);
      case 2:
        return Navigator.pushNamed(context, Routes.privacyPolicyRoute);
      case 3:
        return LaunchReview.launch(androidAppId: "com.customer.sewaexpress");
      case 4:
        return Share.share(
            "https://play.google.com/store/apps/details?id=com.customer.sewaexpress");
      default:
    }
  }

  switchLanguage(int index) {
    switch (index) {
      case 0:
        return LocaleNotifier.of(context)!.change("en");
      case 1:
        return LocaleNotifier.of(context)!.change("ne");
      default:
    }
  }
}

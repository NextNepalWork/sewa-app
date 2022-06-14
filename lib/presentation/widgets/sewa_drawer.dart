import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sewa_digital/business_logic/bloc/auth/auth_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SewaDrawer extends StatefulWidget {
  const SewaDrawer({Key? key}) : super(key: key);

  @override
  State<SewaDrawer> createState() => _SewaDrawerState();
}

class _SewaDrawerState extends State<SewaDrawer> {
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppSize.s240,
        child: Drawer(
          elevation: 0,
          child: Column(
            children: [
              AppSession.userId == null
                  ? Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: .1,
                      semanticContainer: false,
                      margin: EdgeInsets.zero,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorManager.black
                          : const Color(0xfff6f6f6),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppPadding.p20 +
                                AppPadding.p20 +
                                AppPadding.p10),
                        child: Image.asset(ImageAssets.splashLogo),
                      ),
                    )
                  : UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorManager.black
                              : ColorManager.grey3.withOpacity(.1)),
                      currentAccountPicture: InkWell(
                        onTap: () {
                          AppSession.userId == null
                              ? Navigator.pushNamed(context, Routes.loginRoute)
                              : Navigator.pushNamed(
                                      context, Routes.profileRoute)
                                  .then((value) {
                                  setState(() {});
                                });
                        },
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage(ImageAssets.profilePicture),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: ColorManager.primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      accountName: Text(UserPreferences.getName().toString(),
                          style: Theme.of(context).textTheme.headline1),
                      accountEmail: Text(
                        UserPreferences.getEmail().toString(),
                        style: getSemiBoldStyle(
                            color: ColorManager.grey, fontSize: AppSize.s14),
                      )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      drawerData.length,
                      (index) => sewaListTile(
                        drawerData[index].icon,
                        drawerData[index].title,
                        () {
                          setState(() {
                            selectedIndex = index;
                          });
                          drawerIndex(index);
                        },
                        selected: selectedIndex == index ? true : false,
                      ),
                    ),
                  ),
                ),
              ),
              AppSession.userId != null
                  ? BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is UnAuthenticated) {
                          ToastManager.sewaSnackBar(
                              context, "logout successful");
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return ListTile(
                          onTap: () async {
                            BlocProvider.of<AuthBloc>(context)
                                .add(PerformLogout());
                            await FacebookAuth.i.logOut();
                            await GoogleSignIn().signOut();
                          },
                          minLeadingWidth: 20.0,
                          leading: const Icon(Icons.logout),
                          title: LocaleText(
                            AppStrings.logout,
                            maxLines: 1,
                            style: getSemiBoldStyle(
                                color: ColorManager.grey,
                                fontSize: AppSize.s14),
                          ),
                        );
                      },
                    )
                  : ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.loginRoute)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      minLeadingWidth: 20.0,
                      leading: const Icon(Icons.login),
                      title: LocaleText(
                        AppStrings.auth,
                        style: getSemiBoldStyle(
                            color: ColorManager.grey, fontSize: AppSize.s14),
                      ),
                    ),
            ],
          ),
        ));
  }

  Widget sewaListTile(Widget icon, String title, Function() onTap,
      {bool? selected}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.only(left: AppMargin.m8),
            height: 25,
            width: 4,
            color: selected == true ? ColorManager.orange : Colors.transparent),
        Expanded(
          child: ListTile(
            minLeadingWidth: 20.0,
            selected: selected ?? false,
            onTap: onTap,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            horizontalTitleGap: AppPadding.p8,
            leading: icon,
            title: LocaleText(title,
                style: getSemiBoldStyle(
                    color: selected == true
                        ? ColorManager.primaryBlue
                        : ColorManager.grey,
                    fontSize: SewaFontSize.s14)),
          ),
        ),
      ],
    );
  }

  drawerIndex(int index) {
    switch (index) {
      case 0:
        return Navigator.pop(context);
      case 1:
        return Navigator.of(context).pushNamed(Routes.categoryRoute);
      case 2:
        return AppSession.userId == null
            ? Navigator.pushNamed(context, Routes.loginRoute).then((value) {
                setState(() {});
              })
            : Navigator.of(context).pushNamed(Routes.wishlistRoute);
      case 3:
        return AppSession.userId == null
            ? Navigator.pushNamed(context, Routes.loginRoute).then((value) {
                setState(() {});
              })
            : Navigator.of(context).pushNamed(Routes.orderPageRoute);
      case 4:
        return Navigator.of(context).pushNamed(Routes.trackOrderRoute);
      case 5:
        return _launchInBrowser("https://www.sewaexpress.com/shops/create");
      case 6:
        return Navigator.of(context).pushNamed(Routes.referPageRoute);

      case 7:
        return Navigator.of(context).pushNamed(Routes.notificationPageRoute);
      case 8:
        return Navigator.of(context).pushNamed(Routes.settingRoute);
      case 9:
        return Navigator.of(context).pushNamed(Routes.helpRoute);
      case 10:
        return Navigator.of(context).pushNamed(Routes.faqPageRoute);
      default:
    }
  }
}

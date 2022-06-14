import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/profile/profile_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.myProfile),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20 + AppPadding.p5,
                      vertical: AppPadding.p10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        backgroundImage: AssetImage(ImageAssets.profilePicture),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.response.name.toString(),
                                style: Theme.of(context).textTheme.headline1),
                            Text(
                              state.response.email.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sewaListTile(
                    state,
                    Icons.person,
                    state.response.name == null
                        ? "N/A"
                        : state.response.name.toString()),
                sewaListTile(
                    state,
                    Icons.email,
                    state.response.name == null
                        ? "N/A"
                        : state.response.email.toString()),
                sewaListTile(
                    state,
                    Icons.phone,
                    state.response.phone == null
                        ? "N/A"
                        : state.response.phone.toString()),
                sewaListTile(
                    state,
                    Icons.flag,
                    state.response.country == null
                        ? "N/A"
                        : state.response.country.toString()),
                sewaListTile(
                    state,
                    Icons.location_on,
                    state.response.address == null
                        ? "N/A"
                        : state.response.address.toString()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.updateProfileRoute);
                        },
                        child:
                            LocaleText(AppStrings.updateProfile.toUpperCase())),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  sewaListTile(ProfileLoaded state, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p15, vertical: AppPadding.p5),
      child: ListTile(
        horizontalTitleGap: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8)),
        tileColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : ColorManager.white,
        leading: CircleAvatar(
          backgroundColor: ColorManager.grey.withOpacity(.3),
          child: Icon(
            icon,
            color: ColorManager.white,
          ),
        ),
        title: Text(title),
      ),
    );
  }
}

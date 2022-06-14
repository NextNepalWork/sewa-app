import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/notification/notification_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/repo/notification_repo.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: BlocProvider(
        create: (context) =>
            NotificationBloc(RealNotificationRepo())..add(GetNotifications()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationError) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else if (state is NotificationLoaded) {
              return state.response.data!.isEmpty
                  ? Center(
                      child: Text(
                        "Empty",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.response.data!.length,
                      itemBuilder: (context, index) {
                        var notifications = state.response.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p10,
                              vertical: AppPadding.p10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            horizontalTitleGap: 10.0,
                            tileColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorManager.black
                                    : ColorManager.white,
                            leading: Image.asset(ImageAssets.appIcon),
                            title: Text(
                              "Sewa Express",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            subtitle: Text(
                              notifications.message.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return LoadingEffect(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    color: ColorManager.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m5),
                  height: 80,
                  width: double.infinity,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

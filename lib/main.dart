import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'business_logic/cubit/theme_cubit.dart';
import 'constant/constants.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'presentation/widgets/sewa_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await dotenv.load(fileName: ".env");
  await Locales.init(['en', 'ne']);
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("44f55d66-8a77-486a-9220-27d2e3b9243f");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SewaProvider(
      child: BlocProvider(
        create: (context) => SwitchCubit(),
        child: BlocBuilder<SwitchCubit, SwitchState>(
          builder: (context, state) {
            return LocaleBuilder(
              builder: (locale) => MaterialApp(
                  localizationsDelegates: Locales.delegates,
                  supportedLocales: Locales.supportedLocales,
                  locale: locale,
                  debugShowCheckedModeBanner: false,
                  theme: state.theme,
                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: Routes.splashRoute),
            );
          },
        ),
      ),
    );
  }
}

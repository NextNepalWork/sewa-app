import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/sewa_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  _startDelay() {
    timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  _goNext() {
    Navigator.pushReplacementNamed(
      context,
      Routes.mainRoute,
    );
  }

  @override
  void initState() {
    checkIfUserIsLoggedIn();
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SewaLogo(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> checkIfUserIsLoggedIn() async {
    AppSession.userId = UserPreferences.getUserId();
    AppSession.accessToken = UserPreferences.getToken();
  }
}

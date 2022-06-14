import 'package:flutter/material.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer & Earn"),
      ),
      body: Center(
        child: Text(
          "Coming Soon",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}

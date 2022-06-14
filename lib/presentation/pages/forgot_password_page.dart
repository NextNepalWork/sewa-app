import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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

  final TextEditingController _email = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14, vertical: AppPadding.p10),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: ValidatorManager.validateEmpty,
                  controller: _email,
                  decoration: const InputDecoration(
                      labelText: "Email", hintText: "Email"),
                ),
                const SizedBox(
                  height: AppSize.s14,
                ),
                BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordError) {
                      ToastManager.sewaSnackBar(
                          context, state.message.toString());
                    } else if (state is ForgotPasswordLoaded) {
                      ToastManager.sewaSnackBar(
                          context, state.response.message.toString());
                      _launchInBrowser(
                          "https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin");
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              BlocProvider.of<ForgotPasswordBloc>(context)
                                  .add(ForgotPassword(_email.text.trim()));
                            }
                          },
                          child: Text(state is ForgotPasswordLoading
                              ? "Please wait"
                              : "Send Password Reset Link".toUpperCase())),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

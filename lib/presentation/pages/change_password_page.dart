import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/business_logic/bloc/changePassword/change_password_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  void dispose() {
    _newPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.changePassword),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p14, vertical: AppPadding.p10),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: ValidatorManager.validateEmpty,
                controller: _oldPassword,
                decoration: const InputDecoration(
                    labelText: "Old Password", hintText: "Old Password"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: isVisible ? false : true,
                textInputAction: TextInputAction.next,
                validator: ValidatorManager.validateEmpty,
                controller: _newPassword,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    labelText: "New Password",
                    hintText: "New Password"),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value != _newPassword.text) {
                    return AppStrings.notMatched;
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password"),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ChangePasswordError) {
                    ToastManager.sewaSnackBar(
                        context, state.message.toString());
                  } else if (state is ChangePasswordLoaded) {
                    ToastManager.sewaSnackBar(
                        context, state.response.message.toString());
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            BlocProvider.of<ChangePasswordBloc>(context).add(
                                UpdatePassword(_newPassword.text.trim(),
                                    _oldPassword.text.trim()));
                          }
                        },
                        child: LocaleText(state is ChangePasswordLoading
                            ? AppStrings.pleaseWait
                            : AppStrings.changePassword)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

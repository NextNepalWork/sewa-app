import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/auth/auth_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IconButton(
                padding: const EdgeInsets.all(AppPadding.p20),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                )),
            Center(
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          sewaHeader(),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          sewaFormField(
                              validator: ValidatorManager.validateEmpty,
                              controller: _name,
                              type: TextInputType.text,
                              icon: Icons.person,
                              hint: AppStrings.name),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          sewaFormField(
                              validator: ValidatorManager.validateEmpty,
                              controller: _email),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          sewaFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                } else if (value.length < 10) {
                                  return "Invalid number";
                                } else {
                                  return null;
                                }
                              },
                              controller: _phone,
                              maxLength: 10,
                              type: TextInputType.number,
                              icon: Icons.phone,
                              hint: AppStrings.phoneNumber),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          sewaFormField(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              validator: ValidatorManager.validatePassword,
                              controller: _password,
                              type: TextInputType.visiblePassword,
                              action: TextInputAction.done,
                              icon: Icons.lock,
                              obscureText: isVisible ? false : true,
                              hint: AppStrings.password),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          sewaFormField(
                              validator: (value) {
                                if (value != _password.text) {
                                  return AppStrings.notMatched;
                                } else {
                                  return null;
                                }
                              },
                              controller: _confirmPassword,
                              type: TextInputType.visiblePassword,
                              action: TextInputAction.done,
                              icon: Icons.lock,
                              obscureText: true,
                              hint: AppStrings.confirmPassword),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is Registered) {
                                ToastManager.sewaSnackBar(
                                    context, state.response.message.toString());
                                Navigator.pop(context);
                              } else if (state is UnAuthenticated) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ToastManager.sewaSnackBar(
                                    context, state.message.toString());
                              } else if (state is AuthFailed) {
                                ToastManager.sewaSnackBar(
                                    context, state.message.toString());
                              }
                            },
                            builder: (context, state) {
                              return state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      height: 45,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(PerformRegister(
                                                      _name.text.trim(),
                                                      _email.text.trim(),
                                                      _password.text.trim(),
                                                      _confirmPassword.text
                                                          .trim(),
                                                      _phone.text.trim()));
                                            }
                                          },
                                          child: LocaleText(
                                            AppStrings.register,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    fontSize: SewaFontSize.s14,
                                                    color: ColorManager.white),
                                          )),
                                    );
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            LocaleText(AppStrings.alreadyHaveAnAccount,
                                style: getMediumStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: AppSize.s14)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: LocaleText(AppStrings.login,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.primaryBlue,
                                      fontSize: AppSize.s14)),
                            ),
                          ])
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sewaHeader() {
    return Image.asset(
      ImageAssets.appLogo,
      fit: BoxFit.cover,
      height: 130,
    );
  }

  sewaFormField(
      {TextInputType? type,
      TextInputAction? action,
      IconData? icon,
      int? maxLength,
      String? hint,
      bool obscureText = false,
      Widget? suffixIcon,
      String? Function(String?)? validator,
      TextEditingController? controller}) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      keyboardType: type ?? TextInputType.emailAddress,
      textInputAction: action ?? TextInputAction.next,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        counterText: '',
        prefixIcon: Icon(
          icon ?? Icons.email,
          size: 20,
        ),
        filled: true,
        fillColor: ColorManager.white,
        hintText: hint ?? AppStrings.email,
        labelText: hint ?? AppStrings.email,
      ),
    );
  }
}

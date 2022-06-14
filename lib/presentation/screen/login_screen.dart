import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/auth/auth_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/socialLogin/social_login_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/social_login_response.dart';
import 'package:sewa_digital/presentation/screen/register_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20 + AppPadding.p5),
                      child: Column(
                        children: [
                          sewaHeader(),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          sewaFormField(
                              validator: ValidatorManager.validateEmpty,
                              controller: _email),
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
                              validator: ValidatorManager.validateEmpty,
                              controller: _password,
                              type: TextInputType.visiblePassword,
                              obscureText: isVisible ? false : true,
                              action: TextInputAction.done,
                              icon: Icons.lock,
                              hint: AppStrings.password),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.forgotPasswordRoute);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) =>
                                //         const ForgotPasswordPage()));
                              },
                              child: LocaleText(
                                AppStrings.forgotPassword,
                                style: getSemiBoldStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: SewaFontSize.s14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) async {
                              if (state is Authenticated) {
                                AppSession.userId = state.response.user!.id;
                                AppSession.accessToken =
                                    state.response.access_token;

                                await UserPreferences.setToken(
                                    state.response.access_token);
                                await UserPreferences.setEmail(
                                    state.response.user!.email);
                                await UserPreferences.setName(
                                    state.response.user!.name);
                                await UserPreferences.setUserId(
                                    state.response.user!.id!);
                                ToastManager.sewaSnackBar(
                                    context, state.response.message.toString());

                                Navigator.of(context).pop();
                              } else if (state is UnAuthenticated) {
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
                                                  .add(PerformLogin(
                                                      _email.text.trim(),
                                                      _password.text.trim()));
                                            }
                                          },
                                          child: LocaleText(
                                            AppStrings.login,
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
                            height: AppSize.s14,
                          ),
                          BlocConsumer<SocialLoginBloc, SocialLoginState>(
                            listener: (context, state) async {
                              if (state is SocialAuthenticated) {
                                AppSession.userId = state.response.user!.id;
                                AppSession.accessToken =
                                    state.response.access_token;

                                await UserPreferences.setToken(
                                    state.response.access_token);
                                await UserPreferences.setEmail(
                                    state.response.user!.email);
                                await UserPreferences.setName(
                                    state.response.user!.name);
                                await UserPreferences.setUserId(
                                    state.response.user!.id!);
                                ToastManager.sewaSnackBar(
                                    context, state.response.message.toString());

                                Navigator.of(context).pop();
                              } else if (state is SocialUnAuthenticated) {
                                ToastManager.sewaSnackBar(
                                    context, state.message.toString());
                              } else if (state is SocialLoginFailed) {
                                ToastManager.sewaSnackBar(
                                    context, state.message.toString());
                              }
                            },
                            builder: (context, state) {
                              return SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue[800],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onPressed: () {
                                      facebookLogin(context);
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.facebook,
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          width: AppSize.s20,
                                        ),
                                        Text(
                                          "Login With Facebook",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  fontSize: SewaFontSize.s14,
                                                  color: ColorManager.white),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 0.3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () {
                                  _googleSignInProcess(context);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.google,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: AppSize.s20,
                                    ),
                                    Text(
                                      "Sign in With Google",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(fontSize: SewaFontSize.s14),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: AppSize.s16,
                          ),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            LocaleText(AppStrings.dontHaveAnAccount,
                                style: getMediumStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: AppSize.s14)),
                            const SizedBox(
                              width: AppSize.s5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const RegisterScreen()));
                              },
                              child: LocaleText(AppStrings.register,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.primaryBlue,
                                      fontSize: AppSize.s14)),
                            ),
                          ]),
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
      String? Function(String?)? validator,
      IconData? icon,
      String? hint,
      bool obscureText = false,
      Widget? suffixIcon,
      TextEditingController? controller}) {
    return TextFormField(
      validator: validator,
      keyboardType: type ?? TextInputType.emailAddress,
      textInputAction: action ?? TextInputAction.next,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox(),
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

  facebookLogin(BuildContext context) async {
    try {
      final result = await FacebookAuth.i.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData(
          fields: "name,email,id",
        );

        FacebookResponse response = FacebookResponse.fromJson(userData);

        context.read<SocialLoginBloc>().add(PerformSocialLogin(
            email: response.email, name: response.name, provider: response.id));
      }
    } catch (error) {
      ToastManager.sewaSnackBar(context, "Something wrong");
    }
  }

  void _googleSignInProcess(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var response = await _googleSignIn.signIn();
      context.read<SocialLoginBloc>().add(PerformSocialLogin(
          email: response!.email,
          name: response.displayName,
          provider: response.id));
    } catch (e) {
      ToastManager.sewaSnackBar(context, "Something wrong");
    }
  }
}

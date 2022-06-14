import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/updateProfile/update_profile_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _country.dispose();
    _phone.dispose();
    _address.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.updateProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15, vertical: AppPadding.p10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: ValidatorManager.validateEmpty,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _name,
                  decoration: const InputDecoration(
                      labelText: "Name", hintText: "Name"),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  validator: ValidatorManager.validateEmpty,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _country,
                  decoration: const InputDecoration(
                      labelText: "Country", hintText: "Country"),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    } else if (value.length < 10) {
                      return "Invalid number";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: _phone,
                  decoration: const InputDecoration(
                      counterText: '',
                      labelText: "Phone number",
                      hintText: "Phone number"),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextFormField(
                  validator: ValidatorManager.validateEmpty,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _address,
                  decoration: const InputDecoration(
                      labelText: "Address", hintText: "Address"),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<UpdatedProfileBloc, UpdatedProfileState>(
                  listener: (context, state) async {
                    if (state is UpdatedProfileError) {
                      ToastManager.sewaSnackBar(
                          context, state.message.toString());
                    } else if (state is UpdatedProfileLoaded) {
                      ToastManager.sewaSnackBar(
                          context, state.response.message.toString());

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return state is UpdatedProfileLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<UpdatedProfileBloc>(context)
                                        .add(GetUpdatedProfile(
                                      _name.text.trim(),
                                      _country.text.trim(),
                                      _phone.text.trim(),
                                      _address.text.trim(),
                                    ));
                                  }
                                },
                                child: LocaleText(
                                    AppStrings.updateProfile.toUpperCase())),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

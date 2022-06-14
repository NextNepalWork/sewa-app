import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/deliveryCharge/delivery_charge_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/deliveryLocation/delivery_location_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/district/district_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/validator_manager.dart';
import 'package:sewa_digital/business_logic/bloc/address/address_bloc.dart';
import 'package:sewa_digital/constant/value_manager.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({Key? key}) : super(key: key);

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedDistrict;
  num shippingCost = 0;

  String? selectedAddress;
  @override
  void initState() {
    getDistrict(context);
    super.initState();
  }

  @override
  void dispose() {
    _address.dispose();
    _phone.dispose();
    _postalCode.dispose();

    _city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.addNewAddress),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
        child: Form(
          key: _formKey,
          child: BlocConsumer<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state is AddressError) {
                ToastManager.sewaSnackBar(context, state.message.toString());
              } else if (state is NewAddressLoaded) {
                ToastManager.sewaSnackBar(
                    context, state.response.message.toString());

                BlocProvider.of<AddressBloc>(context).add(GetAddress());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    BlocBuilder<DistrictBloc, DistrictState>(
                      builder: (context, state) {
                        if (state is DistrictError) {
                          return Text(state.message.toString());
                        } else if (state is DistrictLoaded) {
                          return DropdownButtonFormField(
                            elevation: 2,
                            validator: (value) {
                              if (value == null) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            hint: Text(
                              "Select District",
                              style:
                                  getMediumStyle(color: ColorManager.darkGrey),
                            ),
                            items: state.response.data!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id.toString(),
                                      child: Text(item.name.toString()),
                                    ))
                                .toList(),
                            value: selectedDistrict,
                            onChanged: (value) {
                              setState(() {
                                selectedDistrict = value as String;

                                getAddress(context,
                                    int.parse(selectedDistrict.toString()));
                              });
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    selectedDistrict == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: BlocBuilder<DeliveryLocationBloc,
                                DeliveryLocationState>(
                              builder: (context, state) {
                                if (state is DeliveryLocationError) {
                                  return Text(state.message.toString());
                                } else if (state is DeliveryLocationLoaded) {
                                  return DropdownButtonFormField(
                                    elevation: 2,
                                    validator: (value) {
                                      if (value == null) {
                                        return "This field is required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    hint: Text(
                                      "Select location",
                                      style: getMediumStyle(
                                          color: ColorManager.darkGrey),
                                    ),
                                    items: state.response.data!
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: Text(item.name.toString()),
                                            ))
                                        .toList(),
                                    value: selectedAddress,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAddress = value as String;
                                        getDeliveryCharge(
                                            context,
                                            int.parse(
                                                selectedAddress.toString()));
                                      });
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: ValidatorManager.validateEmpty,
                      controller: _address,
                      decoration: const InputDecoration(
                          labelText: AppStrings.address,
                          hintText: AppStrings.address),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        } else if (value.length < 10) {
                          return "Invalid number";
                        } else {
                          null;
                        }
                      },
                      controller: _phone,
                      decoration: const InputDecoration(
                          counterText: '',
                          labelText: AppStrings.phone,
                          hintText: AppStrings.phone),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: "Nepal",
                      decoration: const InputDecoration(
                          labelText: AppStrings.country,
                          hintText: AppStrings.country),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      controller: _city,
                      validator: ValidatorManager.validateEmpty,
                      decoration: const InputDecoration(
                          labelText: AppStrings.city,
                          hintText: AppStrings.city),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    selectedAddress == null
                        ? const SizedBox()
                        : BlocBuilder<DeliveryChargeBloc, DeliveryChargeState>(
                            builder: (context, state) {
                              if (state is DeliveryChargeError) {
                                return Text(state.message.toString());
                              } else if (state is DeliveryChargeLoaded) {
                                shippingCost = num.parse(state
                                    .response.data!.delivery_charge
                                    .toString());
                                return Center(
                                  child: Text(
                                    "Delivery Cost Rs." +
                                        num.parse(state
                                                .response.data!.delivery_charge
                                                .toString())
                                            .toStringAsFixed(0),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await UserPreferences.setShippingCost(
                                  int.parse(shippingCost.toStringAsFixed(0)));
                              BlocProvider.of<AddressBloc>(context).add(
                                  AddNewAddress(
                                      address: _address.text,
                                      phone: _phone.text,
                                      postalCode: _postalCode.text,
                                      country: "Nepal",
                                      city: _city.text,
                                      deliveryLocation: selectedAddress));
                            }
                          },
                          child: LocaleText(state is AddressLoading
                              ? AppStrings.pleaseWait.toUpperCase()
                              : AppStrings.addNewAddress.toUpperCase())),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getDistrict(context) {
    BlocProvider.of<DistrictBloc>(context).add(GetDistrict());
  }

  getAddress(context, int id) {
    BlocProvider.of<DeliveryLocationBloc>(context).add(GetDeliveryLocation(id));
  }

  getDeliveryCharge(context, int id) {
    BlocProvider.of<DeliveryChargeBloc>(context).add(GetDeliveryCharge(id));
  }
}

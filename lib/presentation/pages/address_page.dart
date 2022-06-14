import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/address/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';

import 'add_adress_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int? currentIndex;
  @override
  void initState() {
    getAddress(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.myAddress),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressError) {
            ToastManager.sewaSnackBar(context, state.message.toString());
          } else if (state is DeleteAddressLoaded) {
            getAddress(context);
            ToastManager.sewaSnackBar(
                context, state.response.message.toString());
          }
        },
        builder: (context, state) {
          if (state is AddressError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AddressLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.response.data!.length,
                      itemBuilder: (context, index) {
                        var addressData = state.response.data![index];
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10)),
                            elevation: 0.1,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10)),
                              leading: CircleAvatar(
                                  backgroundColor:
                                      ColorManager.grey.withOpacity(.3),
                                  child: Icon(Icons.location_on,
                                      color: ColorManager.white)),
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPadding.p15),
                                child: Text(addressData.address.toString() +
                                    "," +
                                    addressData.country.toString()),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  Text(addressData.phone.toString()),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AddressBloc>(context)
                                        .add(DeleteAddress(addressData.id!));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                    state.response.data!.length == 3
                        ? const SizedBox()
                        : SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const AddNewAddressPage()));
                                },
                                child: LocaleText(
                                    AppStrings.addNewAddress.toUpperCase())),
                          ),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getAddress(context) {
    BlocProvider.of<AddressBloc>(context).add(GetAddress());
  }
}

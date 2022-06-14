import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/address/address_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/cart_response.dart';
import 'package:sewa_digital/presentation/pages/add_adress_page.dart';
import 'package:sewa_digital/presentation/screen/place_order_screen.dart';

class AddAddressScreen extends StatefulWidget {
  final num subtotal;
  final num shipping;
  final num tax;
  final num orderTotal;
  final List<CartDataResponse> cartData;
  const AddAddressScreen(
      {Key? key,
      required this.cartData,
      required this.subtotal,
      required this.shipping,
      required this.tax,
      required this.orderTotal})
      : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
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
        title: const LocaleText(AppStrings.shippingTo),
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
          if (state is AddressLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
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
                          onTap: () {
                            setState(() {
                              getDeliveryCharge(
                                  context,
                                  int.parse(addressData.delivery_location
                                      .toString()));

                              currentIndex = index;
                            });
                          },
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
                                  backgroundColor: currentIndex == index
                                      ? ColorManager.primaryBlue
                                      : ColorManager.grey.withOpacity(.3),
                                  child: Icon(
                                    Icons.check,
                                    color: currentIndex == index
                                        ? ColorManager.white
                                        : ColorManager.black,
                                  )),
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
                                    height: AppSize.s8,
                                  ),
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
                    currentIndex == null
                        ? const SizedBox()
                        : BlocBuilder<DeliveryChargeBloc, DeliveryChargeState>(
                            builder: (context1, state1) {
                              return state1 is DeliveryChargeLoaded
                                  ? SizedBox(
                                      height: 45,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        PlaceOrderScreen(
                                                          orderTotal:
                                                              widget.orderTotal,
                                                          tax: widget.tax,
                                                          shipping:
                                                              widget.shipping,
                                                          subtotal:
                                                              widget.subtotal,
                                                          cartData:
                                                              widget.cartData,
                                                          address: state
                                                                  .response
                                                                  .data![
                                                              currentIndex!],
                                                        )));
                                          },
                                          child: LocaleText(
                                              AppStrings.next.toUpperCase())),
                                    )
                                  : const SizedBox();
                            },
                          ),
                    const SizedBox(
                      height: 10,
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

  getDeliveryCharge(context, int id) {
    BlocProvider.of<DeliveryChargeBloc>(context).add(GetDeliveryCharge(id));
  }
}

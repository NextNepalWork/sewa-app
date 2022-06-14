import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/deliveryCharge/delivery_charge_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/address_response.dart';
import 'package:sewa_digital/data/model/cart_response.dart';
import 'package:sewa_digital/presentation/screen/payment_screen.dart';

class PlaceOrderScreen extends StatefulWidget {
  final List<CartDataResponse> cartData;
  final AddressDataResponse address;
  final num subtotal;
  num shipping;
  final num tax;
  num orderTotal;
  PlaceOrderScreen(
      {Key? key,
      required this.cartData,
      required this.address,
      required this.subtotal,
      required this.shipping,
      required this.tax,
      required this.orderTotal})
      : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String shippingCharge = '';
  @override
  void initState() {
    shippingCharge = context.read<DeliveryChargeBloc>().charge;
    widget.shipping = widget.shipping +
        num.parse(num.parse(shippingCharge).toStringAsFixed(0));

    widget.orderTotal = widget.orderTotal + widget.shipping;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.placeYourOrder),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cartData.length,
              itemBuilder: (context, index) {
                var cartData = widget.cartData[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s5,
                  ),
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(AppSize.s8),
                            child: SizedBox(
                              height: 80,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10),
                                child: Image.network(
                                  ImageAssets.baseUrl +
                                      cartData.product!.image.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      cartData.product!.name.toString(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  cartData.variation!.isEmpty
                                      ? const SizedBox()
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                cartData.variation.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                                maxLines: 2,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: AppSize.s10,
                                            ),
                                          ],
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rs." + cartData.price.toString(),
                                        style: getSemiBoldStyle(
                                            color: ColorManager.grey1,
                                            fontSize: SewaFontSize.s14),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: AppSize.s12),
                                        child: Text(
                                          "x" + cartData.quantity.toString(),
                                          style: getSemiBoldStyle(
                                              color: ColorManager.grey1,
                                              fontSize: SewaFontSize.s14),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSize.s8,
                ),
                elevation: 0,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  leading: CircleAvatar(
                      backgroundColor: ColorManager.primaryBlue,
                      child: Icon(Icons.check, color: ColorManager.white)),
                  title: Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p15),
                    child: Text(widget.address.address.toString() +
                        "," +
                        widget.address.country.toString()),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      Text(widget.address.phone.toString()),
                      const SizedBox(
                        height: AppSize.s14,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: AppPadding.p20),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorManager.black
                        : ColorManager.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s20),
                        topRight: Radius.circular(AppSize.s20))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Column(
                    children: [
                      sewaRow(AppStrings.subTotal, widget.subtotal.toString()),
                      sewaRow(AppStrings.tax, widget.tax.toString()),
                      sewaRow(AppStrings.shipping, widget.shipping.toString()),
                      sewaRow(AppStrings.total, widget.orderTotal.toString()),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p15),
                        child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PaymentScreen(
                                            address: widget.address,
                                            grandTotal: widget.orderTotal,
                                          )));
                                },
                                child:
                                    const LocaleText(AppStrings.placeOrder))),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  sewaRow(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            title,
            style: getSemiBoldStyle(
                color: ColorManager.grey, fontSize: AppSize.s14),
          ),
          Text(
            "Rs." + price.toString(),
            style: getMediumStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorManager.white
                    : ColorManager.black,
                fontSize: AppSize.s14),
          )
        ],
      ),
    );
  }
}

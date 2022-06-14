import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/cart/cart_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/value_manager.dart';
import 'package:sewa_digital/presentation/screen/add_address_screen.dart';
import 'package:sewa_digital/business_logic/bloc/generalSetting/general_setting_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  num subtotal = 0;
  num shipping = 0;
  num tax = 0;
  num orderTotal = 0;
  @override
  void initState() {
    getGeneralSettingData(context);
    getCartData(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.cart),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ToastManager.sewaSnackBar(context, state.message.toString());
          } else if (state is AddToCartLoaded) {
            getCartData(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ToastManager.sewaSnackBar(
                context, state.response.message.toString());
          }
        },
        builder: (context, state) {
          if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CartLoaded) {
            if (state.response.data!.isNotEmpty) {
              subtotal = state.response.data!.fold(
                  0,
                  (previousValue, element) =>
                      num.parse(previousValue.toString()) +
                      element.price! * num.parse(element.quantity.toString()));
              tax = state.response.data!.fold(
                  0,
                  (previousValue, element) =>
                      num.parse(previousValue.toString()) + element.tax!);

              orderTotal = subtotal + (subtotal * tax) / 100;
            }
            return state.response.data!.isEmpty
                ? Center(
                    child: Text(AppStrings.cartEmpty,
                        style: Theme.of(context).textTheme.headline1),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.response.data!.length,
                          itemBuilder: (context, index) {
                            var cartData = state.response.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.s5,
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Card(
                                      elevation: 0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(
                                                AppSize.s8),
                                            child: SizedBox(
                                              height: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s10),
                                                child: Image.network(
                                                  ImageAssets.baseUrl +
                                                      cartData.product!.image
                                                          .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )),
                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 250,
                                                    child: Text(
                                                      cartData.product!.name
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s10,
                                                  ),
                                                  cartData.variation!.isEmpty
                                                      ? const SizedBox()
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 250,
                                                              child: Text(
                                                                cartData
                                                                    .variation
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle1,
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height:
                                                                  AppSize.s10,
                                                            ),
                                                          ],
                                                        ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Rs." +
                                                            cartData.price
                                                                .toString(),
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .grey1,
                                                            fontSize:
                                                                SewaFontSize
                                                                    .s14),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: AppSize
                                                                    .s12),
                                                        child: Text(
                                                          "x" +
                                                              cartData.quantity
                                                                  .toString(),
                                                          style: getSemiBoldStyle(
                                                              color:
                                                                  ColorManager
                                                                      .grey1,
                                                              fontSize:
                                                                  SewaFontSize
                                                                      .s14),
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(DeleteCartProduct(
                                                  cartData.id!));
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: AppPadding.p20),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                              sewaRow(AppStrings.subTotal, subtotal.toString()),
                              sewaRow(AppStrings.tax, tax.toString()),
                              BlocBuilder<GeneralSettingBloc,
                                  GeneralSettingState>(
                                builder: (context, generalState) {
                                  if (generalState is GeneralSettingError) {
                                    return Text(generalState.message);
                                  } else if (generalState
                                      is GeneralSettingLoaded) {
                                    for (var item
                                        in generalState.response.data!) {
                                      if (item.type == "shipping_type" &&
                                          item.value ==
                                              "product_wise_shipping") {
                                        shipping = state.response.data!.fold(
                                            0,
                                            (previousValue, element) =>
                                                num.parse(
                                                    previousValue.toString()) +
                                                element.shipping_cost!);
                                        orderTotal = subtotal + shipping;
                                      } else {
                                        for (var item
                                            in generalState.response.data!) {
                                          if (item.type == "shipping_type" &&
                                              item.value == "flat_rate") {
                                            for (var item in generalState
                                                .response.data!) {
                                              if (item.type ==
                                                  "flat_rate_shipping_cost") {
                                                shipping =
                                                    num.parse(item.value);
                                                orderTotal =
                                                    subtotal + shipping;
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }

                                    return Column(
                                      children: [
                                        sewaRow(AppStrings.shipping,
                                            shipping.toString()),
                                        sewaRow(AppStrings.total,
                                            orderTotal.toString()),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: AppSize.s14,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p15),
                                child: SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddAddressScreen(
                                                        cartData: state
                                                            .response.data!,
                                                        shipping: shipping,
                                                        subtotal: subtotal,
                                                        tax: tax,
                                                        orderTotal: orderTotal,
                                                      )));
                                        },
                                        child: const LocaleText(
                                            AppStrings.checkout))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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

  sewaRow(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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

  getCartData(context) {
    BlocProvider.of<CartBloc>(context).add(GetFromCart());
  }

  getGeneralSettingData(context) {
    BlocProvider.of<GeneralSettingBloc>(context).add(GetGeneralSetting());
  }
}

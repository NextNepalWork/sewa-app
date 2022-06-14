import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/orderHistoryDetail/order_history_detail_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/trackOrder/track_order_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/string_manager.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final TextEditingController _trackOrder = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.trackOrder),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15, vertical: AppPadding.p10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                validator: ValidatorManager.validateEmpty,
                controller: _trackOrder,
                decoration: const InputDecoration(
                    labelText: "Track Order", hintText: "Order code"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<TrackOrderBloc>(context)
                              .add(TrackYourOrder(_trackOrder.text.trim()));
                        }
                      },
                      child: const LocaleText(AppStrings.trackOrder))),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              BlocConsumer<TrackOrderBloc, TrackOrderState>(
                listener: (context, state) {
                  if (state is TrackOrderError) {
                    ToastManager.sewaSnackBar(
                        context, state.message.toString());
                  }
                },
                builder: (context, state) {
                  if (state is TrackOrderLoaded) {
                    context.read<OrderHistoryDetailBloc>().add(
                        GetOrderHistoryDetail(
                            state.response.order_code!.order_id!));
                    return Column(
                      children: [
                        Card(
                          elevation: 0.3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Summary",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p16,
                                          vertical: AppPadding.p5),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text(
                                        state
                                            .response.order_code!.payment_status
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p18),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            keyText("Order Code:"),
                                            keyText("Order Date:"),
                                            keyText("Customer:"),
                                            keyText("Email:"),
                                            keyText("Shipping address:"),
                                            keyText("Total amount:"),
                                            keyText("Payment method:"),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            valueText(state
                                                .response.order_code!.code
                                                .toString()),
                                            valueText(state
                                                .response.order_code!.date
                                                .toString()),
                                            valueText(state
                                                .response.order_code!.user!.name
                                                .toString()),
                                            valueText(state.response.order_code!
                                                .user!.email
                                                .toString()),
                                            valueText(state.response.order_code!
                                                    .shipping_address!.address
                                                    .toString() +
                                                "," +
                                                state.response.order_code!
                                                    .shipping_address!.city
                                                    .toString() +
                                                "," +
                                                state.response.order_code!
                                                    .shipping_address!.country
                                                    .toString()),
                                            valueText("Rs." +
                                                state.response.order_code!
                                                    .grand_total
                                                    .toString()),
                                            valueText(state.response.order_code!
                                                .payment_type
                                                .toString()),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              BlocBuilder<OrderHistoryDetailBloc,
                                  OrderHistoryDetailState>(
                                builder: (context, state1) {
                                  return state1 is OrderHistoryDetailLoaded
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Delivery Status:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Colors.grey
                                                            .withOpacity(.7)),
                                              ),
                                              Text(
                                                state1.response.data![0]
                                                    .delivery_status
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  keyText(String text) => Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p15, bottom: AppPadding.p14),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: ColorManager.grey.withOpacity(.7)),
        ),
      );
  valueText(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Text(text,
            maxLines: 1, style: Theme.of(context).textTheme.subtitle1),
      );
}

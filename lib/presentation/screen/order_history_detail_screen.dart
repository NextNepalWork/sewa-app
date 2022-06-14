import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/orderHistoryDetail/order_history_detail_bloc.dart';
import 'package:sewa_digital/business_logic/orderCancel/order_cancel_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/order_history.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  final OrderHistoryDataResponse orderHistory;
  const OrderHistoryDetailScreen({Key? key, required this.orderHistory})
      : super(key: key);

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
  @override
  void initState() {
    getOrderHistoryDetail(context, widget.orderHistory.order_id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orderDetails),
      ),
      body: BlocBuilder<OrderHistoryDetailBloc, OrderHistoryDetailState>(
        builder: (context, state) {
          if (state is OrderHistoryDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is OrderHistoryDetailLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Code:",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text: widget.orderHistory.code
                                              .toString()));
                                      ToastManager.sewaSnackBar(context,
                                          "Order id Copied to clipboard");
                                    },
                                    child: Tooltip(
                                      preferBelow: false,
                                      message: "",
                                      child: Text(
                                        widget.orderHistory.code.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: ColorManager.orange),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppPadding.p12,
                          ),
                          Card(
                            elevation: 0.1,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10)),
                              leading: Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPadding.p5),
                                child: CircleAvatar(
                                    backgroundColor: ColorManager.primaryBlue,
                                    child: Icon(Icons.person,
                                        color: ColorManager.white)),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPadding.p15),
                                child: Text(
                                    widget.orderHistory.user!.name.toString()),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  Text(widget.orderHistory.user!.email
                                      .toString()),
                                  const SizedBox(
                                    height: AppSize.s12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widget.orderHistory.shipping_address == null
                              ? const SizedBox()
                              : Card(
                                  elevation: 0.1,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10)),
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            ColorManager.primaryBlue,
                                        child: Icon(Icons.location_on,
                                            color: ColorManager.white)),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          top: AppPadding.p15),
                                      child: Text(widget.orderHistory
                                              .shipping_address!.address
                                              .toString() +
                                          "," +
                                          widget.orderHistory.shipping_address!
                                              .country
                                              .toString()),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(widget.orderHistory
                                            .shipping_address!.phone
                                            .toString()),
                                        const SizedBox(
                                          height: AppSize.s14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Column(
                              children: List.generate(
                                  state.response.data!.length, (index) {
                            var orderData = state.response.data![index];
                            return Column(
                              children: [
                                Card(
                                  elevation: 0.1,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10)),
                                    leading: Padding(
                                      padding: const EdgeInsets.only(
                                          top: AppPadding.p15),
                                      child: CircleAvatar(
                                          backgroundColor:
                                              ColorManager.primaryBlue,
                                          child: Icon(Icons.history,
                                              color: ColorManager.white)),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: AppSize.s8,
                                        ),
                                        Text(
                                          orderData.product.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        const SizedBox(
                                          height: AppSize.s8,
                                        ),
                                        orderData.variation!.isEmpty
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    orderData.variation
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s8,
                                                  ),
                                                ],
                                              ),
                                        const SizedBox(
                                          height: AppSize.s5,
                                        ),
                                        Text(
                                          "Rs." + orderData.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: ColorManager.orange,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s8,
                                        ),
                                        Text(
                                          "Qt." + orderData.quantity.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppPadding.p10,
                                              vertical: AppPadding.p5),
                                          decoration: BoxDecoration(
                                              color: ColorManager.grey2
                                                  .withOpacity(.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Status:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              Text(
                                                orderData.delivery_status ==
                                                        "cancel"
                                                    ? "Cancelled"
                                                    : orderData.delivery_status
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: orderData
                                                                    .delivery_status ==
                                                                "cancel"
                                                            ? orderData.delivery_status ==
                                                                    "pending"
                                                                ? Colors.yellow
                                                                : ColorManager
                                                                    .error
                                                            : ColorManager
                                                                .black),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: AppSize.s14),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: AppPadding.p20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorManager.black
                        : ColorManager.white,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Column(
                      children: [
                        sewaRow(AppStrings.subTotal,
                            widget.orderHistory.subtotal.toString()),
                        sewaRow(
                            AppStrings.tax, widget.orderHistory.tax.toString()),
                        sewaRow(AppStrings.shipping,
                            widget.orderHistory.shipping_cost.toString()),
                        sewaRow(AppStrings.total,
                            widget.orderHistory.grand_total.toString()),
                        const SizedBox(
                          height: AppPadding.p10,
                        ),
                        state is OrderHistoryDetailLoaded &&
                                state.response.data![0].delivery_status ==
                                    "cancel"
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p14),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: ColorManager.error,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Are you sure you want to cancel this order?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          actions: [
                                            MaterialButton(
                                                child:
                                                    const Text(AppStrings.no),
                                                onPressed: () => Navigator.pop(
                                                    context, false)),
                                            BlocConsumer<OrderCancelBloc,
                                                OrderCancelState>(
                                              listener: (context, state) {
                                                if (state is OrderCancelError) {
                                                  ToastManager.sewaSnackBar(
                                                      context,
                                                      state.message.toString());
                                                } else if (state
                                                    is OrderCancelLoaded) {
                                                  ToastManager.sewaSnackBar(
                                                      context,
                                                      state.response.message
                                                          .toString());
                                                  getOrderHistoryDetail(
                                                      context,
                                                      widget.orderHistory
                                                          .order_id!);
                                                  Navigator.pop(context, true);
                                                }
                                              },
                                              builder: (context, state) {
                                                return MaterialButton(
                                                    child: const Text(
                                                        AppStrings.yes),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              OrderCancelBloc>()
                                                          .add(OrderCancel(
                                                              orderCode: widget
                                                                  .orderHistory
                                                                  .code
                                                                  .toString()));
                                                    });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: ColorManager.white),
                                    ),
                                  ),
                                ),
                              ),
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

  getOrderHistoryDetail(context, int orderId) {
    BlocProvider.of<OrderHistoryDetailBloc>(context)
        .add(GetOrderHistoryDetail(orderId));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/orderHistory/order_history_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/business_logic/bloc/cart/cart_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  final String? uniqueKey;
  const OrderHistoryPage({Key? key, this.uniqueKey}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    getOrderHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.uniqueKey != null
            ? Navigator.pop(context)
            : Navigator.of(context).popUntil((route) => route.isFirst);
        widget.uniqueKey != null
            ? ""
            : BlocProvider.of<CartBloc>(context).add(GetFromCart());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleText(AppStrings.myOrders),
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (context, state) {
          if (state is OrderHistoryError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is OrderHistoryLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.s8),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var orderHistory = state.response.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppMargin.m8, vertical: AppMargin.m5),
                          elevation: 0.1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.orderHistoryDetailRoute,
                                  arguments: orderHistory);
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        AppSize.s5),
                                                    bottomRight:
                                                        Radius.circular(
                                                            AppSize.s5)),
                                            color: ColorManager.primaryBlue),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p5),
                                          child: Text(
                                            (index + 1).toString(),
                                            textAlign: TextAlign.center,
                                            style: getMediumStyle(
                                                color: ColorManager.white),
                                          ),
                                        )),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(AppSize.s5),
                                              bottomLeft:
                                                  Radius.circular(AppSize.s5)),
                                          color: orderHistory.payment_status!
                                                      .toLowerCase() ==
                                                  "paid"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p5),
                                          child: Text(
                                            orderHistory.payment_status
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: getMediumStyle(
                                                color: ColorManager.white),
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                customRow(context, orderHistory.code.toString(),
                                    "Order Code:"),
                                customRow(
                                    context,
                                    orderHistory.payment_type.toString(),
                                    "Payment Method:"),
                                customRow(
                                    context,
                                    "Rs." + orderHistory.grand_total.toString(),
                                    "Price"),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 0,
                        );
                      },
                      itemCount: state.response.data!.length),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  customRow(BuildContext context, String subtitle, String title) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.p15, bottom: AppPadding.p8),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: ColorManager.grey1.withOpacity(.6)),
            ),
          ),
        ),
        Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )),
      ],
    );
  }

  getOrderHistory(context) {
    BlocProvider.of<OrderHistoryBloc>(context).add(GetOrderHistory());
  }
}

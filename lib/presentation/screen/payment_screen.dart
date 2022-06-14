import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sewa_digital/business_logic/bloc/placeOrder/place_order_bloc.dart';
import 'package:sewa_digital/business_logic/notification/notification_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/address_response.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:sewa_digital/presentation/screen/thank_you_screen.dart';

class PaymentScreen extends StatefulWidget {
  final num grandTotal;
  final AddressDataResponse address;
  const PaymentScreen({
    Key? key,
    required this.address,
    required this.grandTotal,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? currentIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          AppStrings.choosePaymentMethod,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              paymentGateway.length,
              (index) => Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: currentIndex == index
                                ? ColorManager.orange
                                : ColorManager.grey),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      child: Image.asset(
                        paymentGateway[index].icon,
                        height: 100,
                        width: 190,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
            child: BlocConsumer<PlaceOrderBloc, PlaceOrderState>(
              listener: (context1, state) {
                if (state is PlaceOrderError) {
                  ToastManager.sewaSnackBar(context, state.message.toString());
                } else if (state is PlaceOrderLoaded) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  pushNotification(context);
                  ToastManager.sewaSnackBar(
                      context, state.response.message.toString());

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ThankYouScreen(
                            grandTotal: widget.grandTotal,
                            index: currentIndex!,
                            orderCode: state.response.order_code.toString(),
                          )));
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: currentIndex == null
                          ? null
                          : () {
                              if (currentIndex == 0) {
                                BlocProvider.of<PlaceOrderBloc>(context).add(
                                    PlaceOrder(
                                        shippingAddress:
                                            widget.address.toJson(),
                                        paymentType: "cash_on_delivery",
                                        paymentStatus: "Unpaid",
                                        grandTotal: widget.grandTotal,
                                        couponDiscount: 0));
                              } else {
                                BlocProvider.of<PlaceOrderBloc>(context).add(
                                    PlaceOrder(
                                        shippingAddress:
                                            widget.address.toJson(),
                                        paymentType: "esewa",
                                        paymentStatus: "unpaid",
                                        grandTotal: widget.grandTotal,
                                        couponDiscount: 0));
                              }
                            },
                      child: LocaleText(state is PlaceOrderLoading
                          ? AppStrings.pleaseWait
                          : AppStrings.submit.toUpperCase())),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  pushNotification(BuildContext context) async {
    context.read<NotificationBloc>().add(PostNotifications());

    final status = await OneSignal.shared.getDeviceState();
    OneSignal.shared.setExternalUserId(UserPreferences.getUserId().toString());

    OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: [
          status!.userId.toString()
        ],
        additionalData: {
          "include_external_user_ids": UserPreferences.getUserId().toString()
        },
        heading: "Sewa Express",
        content: "Thank you for ordering from Sewa Express"));
  }
}

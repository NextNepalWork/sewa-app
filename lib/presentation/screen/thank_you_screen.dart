import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/cart/cart_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/updateTransaction/update_transaction_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/esewa_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ThankYouScreen extends StatefulWidget {
  final int index;
  final String orderCode;
  final num grandTotal;
  const ThankYouScreen(
      {Key? key,
      required this.index,
      required this.orderCode,
      required this.grandTotal})
      : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  late ESewaConfiguration _configuration;
  late ESewaPnp _esewaPnp;
  String? successMessage;
  @override
  void initState() {
    _configuration = ESewaConfiguration(
      clientID: dotenv.env["ESEWA_CLIENT_ID"].toString(),
      secretKey: dotenv.env["ESEWA_SECRET_KEY"].toString(),
      environment: ESewaConfiguration.ENVIRONMENT_LIVE,
    );
    _esewaPnp = ESewaPnp(configuration: _configuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        BlocProvider.of<CartBloc>(context).add(GetFromCart());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.thankYou),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.check,
                  size: 70,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.index == 1
                  ? const SizedBox()
                  : successMessage == null
                      ? const SizedBox()
                      : Text(AppStrings.congrats,
                          style: getBoldStyle(
                              color: ColorManager.primaryBlue,
                              fontSize: SewaFontSize.s20)),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.index == 1
                    ? AppStrings.orderStatusMessage1
                    : AppStrings.orderStatusMessage,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.grey, fontSize: SewaFontSize.s14),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.index == 1
                  ? successMessage == null
                      ? ESewaPaymentButton(
                          _esewaPnp,
                          amount: double.parse(
                              widget.grandTotal.toStringAsFixed(0)),
                          productId: widget.orderCode.toString(),
                          productName: widget.orderCode.toString(),
                          callBackURL: "",
                          onSuccess: (result) {
                            setState(() {
                              successMessage = result.productId;
                            });
                            BlocProvider.of<UpdateTransactionBloc>(context).add(
                                GetUpdateTransaction(
                                    result.productId.toString(),
                                    EsewaResponse(
                                            date: result.date,
                                            productId: result.productId,
                                            productName: result.productName,
                                            referenceId: result.referenceId,
                                            status: result.status)
                                        .toJson()));

                            ToastManager.sewaSnackBar(
                                context, result.message.toString());
                          },
                          onFailure: (e) {
                            ToastManager.sewaSnackBar(
                                context, e.message.toString());
                          },
                        )
                      : SizedBox(
                          width: 180,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.orderStatusRoute);
                              },
                              child: Text(
                                "Order Status",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              )),
                        )
                  : SizedBox(
                      width: 180,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.orderStatusRoute);
                          },
                          child: Text(
                            "Order Status",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                          )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

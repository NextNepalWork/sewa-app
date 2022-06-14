import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment Partners"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s10, vertical: AppSize.s14),
          child: Column(
            children: paymentGateway
                .map(
                  (method) => Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 180,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Image.asset(
                      method.icon,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }
}

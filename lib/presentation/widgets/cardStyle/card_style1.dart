import 'package:flutter/material.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class CardStyle1 extends StatelessWidget {
  final ProductDataResponse products;
  const CardStyle1({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220, width: 180, child: CardStyle2(product: products));
  }
}

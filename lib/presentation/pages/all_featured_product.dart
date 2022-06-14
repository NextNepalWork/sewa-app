import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class AllFeaturedProduct extends StatefulWidget {
  final List<ProductDataResponse> data;
  const AllFeaturedProduct({Key? key, required this.data}) : super(key: key);

  @override
  State<AllFeaturedProduct> createState() => _AllFeaturedProductState();
}

class _AllFeaturedProductState extends State<AllFeaturedProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.justForYou),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0),
          itemCount: widget.data.length,
          itemBuilder: (BuildContext context, int index) {
            final product = widget.data[index];
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.detailProductRoute,
                      arguments: product.id!);
                },
                child: CardStyle2(product: product));
          },
        ),
      ),
    );
  }
}

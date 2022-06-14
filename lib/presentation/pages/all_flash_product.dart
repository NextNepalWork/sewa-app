import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/flash_deal_response.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';
import 'package:sewa_digital/presentation/widgets/flash_sale_footer.dart';

class AllFlashProduct extends StatelessWidget {
  final FlashDealDataResponse data;
  const AllFlashProduct({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: ColorManager.orange,
          title: const LocaleText(AppStrings.flashSale),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: ColorManager.white),
          bottom: FlashSaleFooter(
            endDate: int.parse(data.end_date.toString()),
          ),
          iconTheme: IconThemeData(color: ColorManager.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0),
          itemCount: data.products!.data!.length,
          itemBuilder: (BuildContext context, int index) {
            final product = data.products!.data![index];
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

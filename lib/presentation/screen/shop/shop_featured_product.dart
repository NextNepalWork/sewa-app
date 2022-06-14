import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/shop/shopProduct/shop_product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class ShopFeaturedProduct extends StatefulWidget {
  final int id;
  const ShopFeaturedProduct({Key? key, required this.id}) : super(key: key);

  @override
  State<ShopFeaturedProduct> createState() => _ShopFeaturedProductState();
}

class _ShopFeaturedProductState extends State<ShopFeaturedProduct> {
  @override
  void initState() {
    getShopFeatured(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopProductBloc, ShopProductState>(
      builder: (context, state) {
        if (state is ShopProductError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ShopProductLoaded) {
          return state.response.data!.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.noData,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s5, vertical: AppSize.s5),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.response.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0),
                    itemBuilder: (context, index) {
                      final categoryProduct = state.response.data![index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.detailProductRoute,
                                arguments: categoryProduct.id!);
                          },
                          child: CardStyle2(product: categoryProduct));
                    },
                  ),
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  getShopFeatured(context, int id) {
    BlocProvider.of<ShopProductBloc>(context).add(GetShopFeaturedProduct(id));
  }
}

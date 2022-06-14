import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/featuredProducts/featured_product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style1.dart';
import 'package:sewa_digital/presentation/widgets/title_heading.dart';

class HomeFeaturedProduct extends StatefulWidget {
  const HomeFeaturedProduct({Key? key}) : super(key: key);

  @override
  State<HomeFeaturedProduct> createState() => _HomeFeaturedProductState();
}

class _HomeFeaturedProductState extends State<HomeFeaturedProduct> {
  @override
  void initState() {
    getFeaturedProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedProductBloc, FeaturedProductState>(
      builder: (context, state) {
        if (state is FeaturedProductError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FeaturedProductLoaded) {
          return state.response.data!.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleHeading(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.allFeaturedProductRoute,
                            arguments: state.response.data!);
                      },
                      text1: AppStrings.featuredProduct,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      height: 240,
                      child: ListView.builder(
                        itemCount: state.response.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var products = state.response.data![index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.detailProductRoute,
                                    arguments: products.id!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 4),
                                child: CardStyle1(products: products),
                              ));
                        },
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
    );
  }

  getFeaturedProduct(context) {
    BlocProvider.of<FeaturedProductBloc>(context).add(GetFeaturedProducts());
  }
}

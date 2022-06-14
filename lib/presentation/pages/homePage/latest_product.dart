import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/products/product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style1.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';
import 'package:sewa_digital/presentation/widgets/title_heading.dart';

class HomeLatestProduct extends StatefulWidget {
  const HomeLatestProduct({Key? key}) : super(key: key);

  @override
  State<HomeLatestProduct> createState() => _HomeLatestProductState();
}

class _HomeLatestProductState extends State<HomeLatestProduct> {
  @override
  void initState() {
    getLatestProduct(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ProductLoaded) {
          return state.response.data!.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleHeading(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.allLatestProductRoute);
                      },
                      text1: AppStrings.latestProduct,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
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
          return LoadingEffect(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 160,
                    width: 180,
                    child: Card(
                      elevation: 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  color: Colors.white,
                                ),
                                width: 200,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  getLatestProduct(context) {
    BlocProvider.of<ProductBloc>(context).add(GetProducts());
  }
}

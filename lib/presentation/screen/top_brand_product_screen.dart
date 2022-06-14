import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/brandProduct/brand_product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class TopBrandProduct extends StatefulWidget {
  final int brandId;
  const TopBrandProduct({Key? key, required this.brandId}) : super(key: key);

  @override
  State<TopBrandProduct> createState() => _TopBrandProductState();
}

class _TopBrandProductState extends State<TopBrandProduct> {
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getAllBrandProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.topBrandProduct),
      ),
      body: BlocBuilder<BrandProductBloc, BrandProductState>(
        builder: (context, state) {
          switch (state.status) {
            case BrandProductsStatus.success:
              _disableLoadMore();
              if (state.products!.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noData,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.products!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = state.products![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.detailProductRoute,
                                    arguments: product.id!);
                              },
                              child: CardStyle2(product: product),
                            );
                          },
                        ),
                        if (!state.hasReachedMax! &&
                            state.products!.isNotEmpty &&
                            state.products!.length % 10 == 0)
                          Center(
                            child: Container(
                                margin: const EdgeInsets.all(AppMargin.m16),
                                width: 24.0,
                                height: 24.0,
                                child: const CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                );
              }

            case BrandProductsStatus.failure:
              return const Text("Error");
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  getAllBrandProduct(context) {
    BlocProvider.of<BrandProductBloc>(context)
        .add(GetBrandProducts(widget.brandId));
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getAllBrandProduct(context);
    }
  }

  _disableLoadMore() {
    isLoadingMore = false;
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}

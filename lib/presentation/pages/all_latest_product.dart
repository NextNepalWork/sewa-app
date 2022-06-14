import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/allProduct/all_product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class AllLatestProduct extends StatefulWidget {
  const AllLatestProduct({Key? key}) : super(key: key);

  @override
  State<AllLatestProduct> createState() => _AllLatestProductState();
}

class _AllLatestProductState extends State<AllLatestProduct> {
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getAllLatestProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.justForYou),
      ),
      body: BlocBuilder<AllProductBloc, AllProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.success:
              _disableLoadMore();
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .8,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 5.0),
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
                              child: CardStyle2(product: product));
                        },
                      ),
                      if (!state.hasReachedMax! &&
                          state.products!.isNotEmpty &&
                          state.products!.length % 10 == 0)
                        Center(
                          child: Container(
                              margin: const EdgeInsets.all(16.0),
                              width: 24.0,
                              height: 24.0,
                              child: const CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              );

            case ProductsStatus.failure:
              return const Text(AppStrings.error);
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  getAllLatestProduct(context) {
    BlocProvider.of<AllProductBloc>(context).add(GetAllProducts());
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getAllLatestProduct(context);
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

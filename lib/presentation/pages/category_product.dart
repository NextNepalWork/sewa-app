import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/category_response.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';
import 'package:sewa_digital/presentation/widgets/sub_category_footer.dart';

class CategoryProduct extends StatefulWidget {
  final CategoryDataResponse categoryData;

  const CategoryProduct({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  State<CategoryProduct> createState() => _AllLatestProductState();
}

class _AllLatestProductState extends State<CategoryProduct> {
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  String? filterValue;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getSubCategory(context);
    getCategoryProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? ColorManager.black
            : ColorManager.white,
        title: Text(widget.categoryData.name.toString()),
        bottom: SubCategoryFooter(categoryId: widget.categoryData.id!),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  filterValue = value.toString();
                });
                BlocProvider.of<CategoryProductBloc>(context).add(
                    GetCategoryProducts(widget.categoryData.id!,
                        filter: filterValue));
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.filter_alt),
              itemBuilder: (context) => filterData
                  .map((e) => PopupMenuItem(
                        child: Text(e.key),
                        value: e.value,
                      ))
                  .toList()),
        ],
      ),
      body: BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
          switch (state.status) {
            case CategoryStatus.loading:
              if (state.products!.isEmpty && state.hasReachedMax == true) {
                return Center(
                    child: Text(AppStrings.noData,
                        style: Theme.of(context).textTheme.headline1));
              }
              break;

            case CategoryStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case CategoryStatus.success:
              _disableLoadMore();
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      state.products!.isEmpty
                          ? Center(
                              child: Text(AppStrings.noData,
                                  style: Theme.of(context).textTheme.headline1),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: .8,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 5.0),
                              physics: const NeverScrollableScrollPhysics(),
                              // controller: scrollController,
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
                              margin: const EdgeInsets.all(16.0),
                              width: 24.0,
                              height: 24.0,
                              child: const CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              );

            case CategoryStatus.failure:
              return const Text(AppStrings.error);
            default:
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  getCategoryProduct(context) {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(GetCategoryProducts(widget.categoryData.id!));
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getCategoryProduct(context);
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

  getSubCategory(
    context,
  ) {
    BlocProvider.of<SubCategoryBloc>(context)
        .add(GetSubCategory(widget.categoryData.id!));
  }
}

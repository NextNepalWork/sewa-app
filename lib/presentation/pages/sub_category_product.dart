import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/childCategory/subCategory/child_category_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/subCategoryProduct/sub_category_product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';
import 'package:sewa_digital/presentation/widgets/child_category_footer.dart';

class SubCategoryProduct extends StatefulWidget {
  final SubCategoryDataResponse data;
  const SubCategoryProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<SubCategoryProduct> createState() => _SubCategoryProductState();
}

class _SubCategoryProductState extends State<SubCategoryProduct> {
  final ScrollController scrollController = ScrollController();
  String? filterValue;
  bool isLoadingMore = false;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getChildCategory(context);
    getSubCategoryProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? ColorManager.black
            : ColorManager.white,
        title: Text(widget.data.name.toString()),
        bottom: ChildCategoryFooter(
          categoryId: widget.data.id!,
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  filterValue = value.toString();
                });
                BlocProvider.of<SubCategoryProductBloc>(context).add(
                    GetSubCategoryProducts(widget.data.id!,
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
      body: BlocBuilder<SubCategoryProductBloc, SubCategoryProductState>(
        builder: (context, state) {
          switch (state.status) {
            case SubCategoryStatus.loading:
              if (state.products!.isEmpty && state.hasReachedMax == true) {
                return Center(
                    child: Text(AppStrings.noData,
                        style: Theme.of(context).textTheme.headline1));
              }
              break;

            case SubCategoryStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SubCategoryStatus.success:
              _disableLoadMore();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      state.products!.isEmpty
                          ? Center(
                              child: Text(
                                AppStrings.noData,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: .8,
                                      crossAxisCount: 2,
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

            case SubCategoryStatus.failure:
              return const Text("Error");
            default:
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  getSubCategoryProduct(context) {
    BlocProvider.of<SubCategoryProductBloc>(context)
        .add(GetSubCategoryProducts(widget.data.id!));
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getSubCategoryProduct(context);
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

  getChildCategory(
    context,
  ) {
    BlocProvider.of<ChildCategoryBloc>(context)
        .add(GetChildCategory(widget.data.id!));
  }
}

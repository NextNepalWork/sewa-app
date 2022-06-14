import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/childCategoryProduct/child_category_product_bloc.dart';

import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style2.dart';

class ChildCategoryProduct extends StatefulWidget {
  final SubSubCategoryDataResponse data;
  const ChildCategoryProduct({Key? key, required this.data}) : super(key: key);

  @override
  State<ChildCategoryProduct> createState() => _ChildCategoryProductState();
}

class _ChildCategoryProductState extends State<ChildCategoryProduct> {
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  String? filterValue;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getChildCategoryProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name.toString()),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  filterValue = value.toString();
                });
                BlocProvider.of<ChildCategoryProductBloc>(context).add(
                    GetChildCategoryProducts(widget.data.id!,
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
      body: BlocBuilder<ChildCategoryProductBloc, ChildCategoryProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ChildCategoryStatus.loading:
              if (state.products!.isEmpty && state.hasReachedMax == true) {
                return Center(
                    child: Text(AppStrings.noData,
                        style: Theme.of(context).textTheme.headline1));
              }
              break;

            case ChildCategoryStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ChildCategoryStatus.success:
              _disableLoadMore();
              return state.products!.isEmpty
                  ? Center(
                      child: Text(AppStrings.noData,
                          style: Theme.of(context).textTheme.headline1),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: SingleChildScrollView(
                        controller: scrollController,
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
                                    margin: const EdgeInsets.all(16.0),
                                    width: 24.0,
                                    height: 24.0,
                                    child: const CircularProgressIndicator()),
                              ),
                          ],
                        ),
                      ),
                    );

            case ChildCategoryStatus.failure:
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

  getChildCategoryProduct(context) {
    BlocProvider.of<ChildCategoryProductBloc>(context)
        .add(GetChildCategoryProducts(widget.data.id!));
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getChildCategoryProduct(context);
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

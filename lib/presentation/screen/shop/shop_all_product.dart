import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sewa_digital/business_logic/bloc/searchShopProduct/search_shop_product_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';

// class ShopAllProduct extends StatefulWidget {
//   final int id;
//   const ShopAllProduct({Key? key, required this.id}) : super(key: key);

//   @override
//   State<ShopAllProduct> createState() => _ShopAllProductState();
// }

// class _ShopAllProductState extends State<ShopAllProduct> {
//   @override
//   void initState() {
//     getShopAll(context,  widget.id);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ShopProductBloc, ShopProductState>(
//       builder: (context, state) {
//         if (state is ShopProductError) {
//           return Center(
//             child: Text(state.message),
//           );
//         } else if (state is ShopProductLoaded) {
//           return state.response.data!.isEmpty
//               ? Center(
//                   child: Text(
//                     AppStrings.noData,
//                     style: Theme.of(context).textTheme.headline1,
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: AppPadding.p5, vertical: AppPadding.p5),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: state.response.data!.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             childAspectRatio: .8,
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 5.0,
//                             crossAxisSpacing: 5.0),
//                     itemBuilder: (context, index) {
//                       final categoryProduct = state.response.data![index];
//                       return GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, Routes.detailProductRoute,
//                                 arguments: categoryProduct.id!);
//                           },
//                           child: CardStyle2(product: categoryProduct));
//                     },
//                   ),
//                 );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   getShopAll(context, int id) {
//     BlocProvider.of<ShopProductBloc>(context).add(GetShopAllProduct(id));
//   }
// }
class ShopAllProduct extends StatefulWidget {
  final int id;
  const ShopAllProduct({Key? key, required this.id}) : super(key: key);

  @override
  State<ShopAllProduct> createState() => _ShopAllProductState();
}

class _ShopAllProductState extends State<ShopAllProduct> {
  final ScrollController scrollController = ScrollController();
  String? filterValue;
  bool isLoadingMore = false;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getSearchProduct(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            titleSpacing: 0.0,
            bottom: PreferredSize(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              filterValue = value.toString();
                            });
                            BlocProvider.of<SearchShopBloc>(context).add(
                                GetSearchShopProduct(
                                    filter: filterValue,
                                    shopId: widget.id.toString()));
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.filter_list),
                          itemBuilder: (context) => filterData
                              .map((e) => PopupMenuItem(
                                    child: Text(e.key),
                                    value: e.value,
                                  ))
                              .toList()),
                    ],
                  ),
                ),
                preferredSize: const Size.fromHeight(35)),
            actions: const [],
          ),
        ),
        body: BlocBuilder<SearchShopBloc, SearchShopState>(
          builder: (context, state) {
            if (state is SearchShopState) {
              switch (state.status) {
                case SearchShopStatus.loading:
                  if (state.products!.isEmpty && state.hasReachedMax == true) {
                    return Center(
                        child: Text(AppStrings.noData,
                            style: Theme.of(context).textTheme.headline1));
                  }
                  break;

                case SearchShopStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SearchShopStatus.success:
                  _disableLoadMore();
                  if (state.products!.isEmpty) {
                    return Center(
                        child: Text(AppStrings.noData,
                            style: Theme.of(context).textTheme.headline1));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: .8,
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 5.0),
                                shrinkWrap: true,
                                itemCount: state.products!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final product = state.products![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          Routes.detailProductRoute,
                                          arguments: product.id!);
                                    },
                                    child: Card(
                                      elevation: 0,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8)),
                                                child: product.thumbnail_image
                                                            .toString() ==
                                                        ImageAssets
                                                            .backendPlaceHolder
                                                    ? Image.asset(
                                                        ImageAssets.placeholder)
                                                    : Image.network(
                                                        ImageAssets.baseUrl +
                                                            product
                                                                .thumbnail_image
                                                                .toString(),
                                                        fit: BoxFit.contain,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child: Text(product.name.toString(),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Rs." +
                                                    product
                                                        .base_discounted_price!
                                                        .toString() +
                                                    "    ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                        color:
                                                            ColorManager.orange,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    product.base_discounted_price!
                                                                .toString() ==
                                                            product.unit_price!
                                                                .toString()
                                                        ? ""
                                                        : "Rs." +
                                                            product.unit_price!
                                                                .toString(),
                                                style: const TextStyle(
                                                    fontSize: SewaFontSize.s12,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ])),
                                          const SizedBox(
                                            height: AppSize.s8,
                                          ),
                                          RatingBar.builder(
                                            wrapAlignment: WrapAlignment.start,
                                            initialRating: double.parse(
                                                product.rating.toString()),
                                            minRating: 5,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemSize: 14,
                                            ignoreGestures: true,
                                            itemCount: 5,
                                            itemBuilder: (context, index) {
                                              return const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              );
                                            },
                                            onRatingUpdate: (value) {},
                                          ),
                                          const SizedBox(
                                            height: AppSize.s10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                  }

                case SearchShopStatus.failure:
                  return const Text("Error");
                default:
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  getSearchProduct(context) {
    BlocProvider.of<SearchShopBloc>(context)
        .add(GetSearchShopProduct(shopId: widget.id.toString()));
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getSearchProduct(context);
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

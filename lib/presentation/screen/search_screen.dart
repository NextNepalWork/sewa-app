import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sewa_digital/business_logic/bloc/searchProduct/search_product_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/drawer_model.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  late TextEditingController query;
  String? filterValue;
  String? clear;
  bool isLoadingMore = false;
  final suggestionList = <String>[];
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    getSearchProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40.0,
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorManager.grey.withOpacity(.4)
                          : ColorManager.grey.withOpacity(.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Autocomplete(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        } else {
                          return suggestionList.where((hint) => hint
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        }
                      },
                      onSelected: (option) {
                        BlocProvider.of<SearchBloc>(context)
                            .add(GetSearchProduct(
                          query: option.toString(),
                        ));
                      },
                      optionsViewBuilder:
                          (context, Function(String) onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 355,
                                width: 300,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return ListTile(
                                        onTap: () {
                                          onSelected(option.toString());
                                        },
                                        title: SubstringHighlight(
                                          text: option.toString(),
                                          term: query.text,
                                          textStyleHighlight: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.orange),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemCount: options.length),
                              )),
                        );
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        query = textEditingController;
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          enableSuggestions: true,
                          onChanged: (value) {
                            setState(() {
                              clear = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            focusNode.unfocus();

                            // suggestionList.add(value);
                            BlocProvider.of<SearchBloc>(context)
                                .add(GetSearchProduct(query: value.toString()));
                          },
                          onEditingComplete: onFieldSubmitted,
                          decoration: InputDecoration(
                              suffixIcon: clear == null
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        query.clear();
                                      },
                                      child: const Icon(Icons.clear)),
                              prefixIcon: const Icon(
                                Icons.search,
                              ),
                              hintStyle: Theme.of(context).textTheme.subtitle2,
                              hintText: "What are you looking for?",
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  filterValue = value.toString();
                });
                BlocProvider.of<SearchBloc>(context).add(GetSearchProduct(
                  filter: filterValue,
                ));
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
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchState) {
            switch (state.status) {
              case SearchStatus.loading:
                if (state.products!.isEmpty && state.hasReachedMax == true) {
                  return Center(
                      child: Text(AppStrings.noData,
                          style: Theme.of(context).textTheme.headline1));
                }
                break;

              case SearchStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SearchStatus.success:
                _disableLoadMore();
                if (state.products!.isEmpty) {
                  return Center(
                      child: Text(AppStrings.noData,
                          style: Theme.of(context).textTheme.headline1));
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          GridView.builder(
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
                                                    topLeft: Radius.circular(8),
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
                                                        product.thumbnail_image
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
                                                product.base_discounted_price!
                                                    .toString() +
                                                "    ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: ColorManager.orange,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        TextSpan(
                                            text: product.base_discounted_price!
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

              case SearchStatus.failure:
                return const Text("Error");
              default:
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  getSearchProduct(context) {
    BlocProvider.of<SearchBloc>(context).add(GetSearchProduct());
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

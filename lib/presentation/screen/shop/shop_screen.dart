import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/searchShopProduct/search_shop_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/shop/shopDetail/shop_detail_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/repo/repos.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_all_product.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_brand_product.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_featured_product.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_new_product.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_top_product.dart';

class ShopScreen extends StatefulWidget {
  final int id;
  final String title;
  const ShopScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int id = 1;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    getShopDetail(context, widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<ShopDetailBloc, ShopDetailState>(
            builder: (context, state) {
          if (state is ShopDetailError) {
            return Center(child: Text(state.message));
          } else if (state is ShopDetailLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        List.generate(state.response.data!.length, (index) {
                      var shopDetail = state.response.data![index];
                      id = shopDetail.user_id!;
                      return Column(
                        children: [
                          SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 0.1,
                                child: SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.network(
                                    ImageAssets.baseUrl +
                                        shopDetail.logo.toString(),
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    ColorManager.orange),
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          "No Image",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )),
                        ],
                      );
                    })),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: TabBar(
                    labelStyle: Theme.of(context).textTheme.subtitle1,

                    controller: _tabController,
                    //isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(2),
                    indicator: ShapeDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    unselectedLabelColor: Colors.black87,
                    labelColor: Colors.white,
                    tabs: const [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Featured",
                      ),
                      Tab(
                        text: "Top",
                      ),
                      Tab(
                        text: "New",
                      ),
                      Tab(
                        text: "Brands",
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: AppSize.s4),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      BlocProvider(
                        create: (context) => SearchShopBloc(RealSearchRepo()),
                        child: ShopAllProduct(
                            id: state.response.data![0].user_id!),
                      ),
                      ShopFeaturedProduct(id: widget.id),
                      ShopTopProduct(id: widget.id),
                      ShopNewProduct(id: widget.id),
                      ShopBrandProduct(id: widget.id)
                    ],
                  ),
                ))
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  getShopDetail(context, int id) {
    BlocProvider.of<ShopDetailBloc>(context).add(GetShopDetail(id));
  }
}

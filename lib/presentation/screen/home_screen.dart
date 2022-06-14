import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/pages/homePage/home_page.dart';
import 'package:sewa_digital/business_logic/bloc/cart/cart_bloc.dart';
import 'package:sewa_digital/presentation/widgets/sewa_drawer.dart';
import 'package:sewa_digital/presentation/widgets/sewa_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    AppSession.userId == null ? "" : getCartData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppStrings.appCloseMessage,
                style: Theme.of(context).textTheme.subtitle1),
            actions: [
              MaterialButton(
                  child: const Text(AppStrings.no),
                  onPressed: () => Navigator.pop(context, false)),
              MaterialButton(
                  child: const Text(AppStrings.yes),
                  onPressed: () => Navigator.pop(context, true)),
            ],
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: const SewaDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(115),
          child: AppBar(
              title: SizedBox(
                height: 60,
                child: Image.asset(
                  ImageAssets.appBarLogo,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p15),
                  child: GestureDetector(
                    onTap: () {
                      AppSession.userId == null
                          ? Navigator.pushNamed(context, Routes.loginRoute)
                          : Navigator.pushNamed(context, Routes.cartRoute);
                    },
                    child: Badge(
                      padding: const EdgeInsets.all(6),
                      position: BadgePosition.topEnd(top: 1),
                      badgeContent: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartError) {
                            return Text("0",
                                style: getSemiBoldStyle(
                                    color: ColorManager.white));
                          } else if (state is CartLoaded) {
                            return Text(
                              state.response.data!.length.toString(),
                              style:
                                  getSemiBoldStyle(color: ColorManager.white),
                            );
                          } else {
                            return Text("0",
                                style: getSemiBoldStyle(
                                    color: ColorManager.white));
                          }
                        },
                      ),
                      badgeColor: ColorManager.primaryBlue,
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ),
                )
              ],
              bottom: const SewaSearchBar()),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            refreshAllPage(context);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Column(
                children: const [
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeSlider(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeCategory(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  FlashSale(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeTopBrand(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeLatestProduct(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeBanner(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                  HomeFeaturedProduct(),
                  SizedBox(
                    height: AppSize.s10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  refreshAllPage(context) {
    BlocProvider.of<SliderBloc>(context).add(GetHomeSlider());
    BlocProvider.of<CategoryBloc>(context).add(GetCategory());
    BlocProvider.of<FlashSaleBloc>(context).add(GetFlashSale());
    BlocProvider.of<TopBrandBloc>(context).add(GetTopBrand());
    BlocProvider.of<ProductBloc>(context).add(GetProducts());
    BlocProvider.of<BannerBloc>(context).add(GetBanner());
    BlocProvider.of<FeaturedProductBloc>(context).add(GetFeaturedProducts());
  }

  getCartData(context) {
    BlocProvider.of<CartBloc>(context).add(GetFromCart());
  }
}

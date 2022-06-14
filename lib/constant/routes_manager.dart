import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/allProduct/all_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/childCategoryProduct/child_category_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/subCategoryProduct/sub_category_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/policies/policies_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/trackOrder/track_order_bloc.dart';
import 'package:sewa_digital/business_logic/cubit/network_cubit.dart';
import 'package:sewa_digital/constant/assets_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/string_manager.dart';
import 'package:sewa_digital/data/model/category_response.dart';
import 'package:sewa_digital/data/model/flash_deal_response.dart';
import 'package:sewa_digital/data/model/order_history.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/model/shop_response.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
import 'package:sewa_digital/data/repo/repos.dart';
import 'package:sewa_digital/data/repo/search_repo.dart';
import 'package:sewa_digital/presentation/pages/address_page.dart';
import 'package:sewa_digital/presentation/pages/all_brand_page.dart';
import 'package:sewa_digital/presentation/pages/all_category_page.dart';
import 'package:sewa_digital/presentation/pages/all_featured_product.dart';
import 'package:sewa_digital/presentation/pages/all_flash_product.dart';
import 'package:sewa_digital/presentation/pages/all_latest_product.dart';
import 'package:sewa_digital/presentation/pages/category_page.dart';
import 'package:sewa_digital/presentation/pages/category_product.dart';
import 'package:sewa_digital/presentation/pages/child_category_product.dart';
import 'package:sewa_digital/presentation/pages/faq.dart';
import 'package:sewa_digital/presentation/pages/forgot_password_page.dart';
import 'package:sewa_digital/presentation/pages/help_page.dart';
import 'package:sewa_digital/presentation/pages/notifications.dart';
import 'package:sewa_digital/presentation/pages/order_page.dart';
import 'package:sewa_digital/presentation/pages/policiesPage/privacy.dart';
import 'package:sewa_digital/presentation/pages/policiesPage/return.dart';
import 'package:sewa_digital/presentation/pages/policiesPage/terms.dart';
import 'package:sewa_digital/presentation/pages/refer.dart';
import 'package:sewa_digital/presentation/pages/sub_category_product.dart';
import 'package:sewa_digital/presentation/pages/track_order.dart';
import 'package:sewa_digital/presentation/pages/update_profile_page.dart';
import 'package:sewa_digital/presentation/pages/wishlist_page.dart';
import 'package:sewa_digital/presentation/screen/cart_screen.dart';
import 'package:sewa_digital/presentation/screen/home_screen.dart';
import 'package:sewa_digital/presentation/screen/login_screen.dart';
import 'package:sewa_digital/presentation/screen/order_history_detail_screen.dart';
import 'package:sewa_digital/presentation/screen/product_detail.dart';
import 'package:sewa_digital/presentation/screen/profile_screen.dart';
import 'package:sewa_digital/presentation/screen/register_screen.dart';
import 'package:sewa_digital/presentation/screen/search_screen.dart';
import 'package:sewa_digital/presentation/screen/setting_screen.dart';
import 'package:sewa_digital/presentation/screen/splash_screen.dart';
import 'package:sewa_digital/business_logic/bloc/brandProduct/brand_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/categoryProduct/category_product_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/searchProduct/search_product_bloc.dart';
import 'package:sewa_digital/presentation/screen/top_brand_product_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String profileRoute = "/profileScreen";
  static const String categoryRoute = "/categoryScreen";
  static const String settingRoute = "/settingScreen";
  static const String helpRoute = "/helpScreen";
  static const String cartRoute = "/cartScreen";
  static const String allCategoryRoute = "/allCategoryRoute";
  static const String categoryProductRoute = "/CategoryProductRoute";
  static const String allFlashProductRoute = "/AllFlashProductRoute";
  static const String detailProductRoute = "/detailProduct";
  static const String topBrandProductRoute = "/topBrandProduct";
  static const String allBrandRoute = "/allBrands";
  static const String trackOrderRoute = "/trackOrder";
  static const String allLatestProductRoute = "/allLatestProduct";
  static const String allFeaturedProductRoute = "/allFeaturedProduct";
  static const String searchProductRoute = "/searchProduct";
  static const String wishlistRoute = "/wishlistScreen";
  static const String subCategoryProductRoute = "/subCategoryProduct";
  static const String childCategoryProductRoute = "/childCategoryProduct";
  static const String orderHistoryDetailRoute = "/orderHistoryDetail";
  static const String updateProfileRoute = "/updateProfile";
  static const String orderStatusRoute = "/orderStatus";
  static const String addressRoute = "/addressStatus";
  static const String termsRoute = "/terms&conditions";
  static const String returnPolicyRoute = "/returnPolicy";
  static const String privacyPolicyRoute = "/privacyPolicy";
  static const String orderPageRoute = "/orderPage";
  static const String faqPageRoute = "/fagPage";
  static const String referPageRoute = "/referPage";
  static const String notificationPageRoute = "/notificationPage";
  static const String mainRoute = "/main";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        final isOnline = context.read<ConnectivityCubit>().state;
        if (!isOnline) {
          return noInternetWidget(context);
        }
        switch (routeSettings.name) {
          case Routes.splashRoute:
            return const SplashScreen();
          case Routes.loginRoute:
            return const LoginScreen();
          case Routes.registerRoute:
            return const RegisterScreen();
          case Routes.mainRoute:
            return const HomeScreen();
          case Routes.profileRoute:
            return const ProfileScreen();
          case Routes.settingRoute:
            return const Setting();
          case Routes.referPageRoute:
            return const ReferAndEarn();
          case Routes.notificationPageRoute:
            return const Notifications();
          case Routes.faqPageRoute:
            return const FAQ();
          case Routes.categoryRoute:
            return const CategoryPage();
          case Routes.forgotPasswordRoute:
            return const ForgotPasswordPage();
          case Routes.orderPageRoute:
            return const OrderHistoryPage(
              uniqueKey: "uniqueKey",
            );

          case Routes.trackOrderRoute:
            return BlocProvider(
              create: (context) => TrackOrderBloc(RealOrderHistoryRepo()),
              child: const TrackOrder(),
            );
          case Routes.helpRoute:
            return const CustomerSupport();
          case Routes.cartRoute:
            return const CartScreen();

          case Routes.wishlistRoute:
            return const WishListPage();
          case Routes.updateProfileRoute:
            return const UpdateProfilePage();
          case Routes.orderStatusRoute:
            return const OrderHistoryPage();
          case Routes.addressRoute:
            return const AddressPage();
          case Routes.privacyPolicyRoute:
            return BlocProvider(
              create: (context) =>
                  PoliciesBloc(RealPoliciesRepo())..add(GetPrivacyPolicies()),
              child: const PrivacyPolicy(),
            );
          case Routes.returnPolicyRoute:
            return BlocProvider(
              create: (context) =>
                  PoliciesBloc(RealPoliciesRepo())..add(GetReturnPolicies()),
              child: const ReturnPolicy(),
            );
          case Routes.termsRoute:
            return BlocProvider(
              create: (context) => PoliciesBloc(RealPoliciesRepo())
                ..add(GetTermsAndConditions()),
              child: const TermsAndConditions(),
            );

          case Routes.searchProductRoute:
            return BlocProvider(
              create: (context) => SearchBloc(RealSearchRepo()),
              child: const SearchScreen(),
            );
          case Routes.orderHistoryDetailRoute:
            return OrderHistoryDetailScreen(
                orderHistory: arguments as OrderHistoryDataResponse);
          case Routes.allFeaturedProductRoute:
            return AllFeaturedProduct(
                data: arguments as List<ProductDataResponse>);
          case Routes.subCategoryProductRoute:
            return BlocProvider(
              create: (context) => SubCategoryProductBloc(RealProductRepo()),
              child: SubCategoryProduct(
                  data: arguments as SubCategoryDataResponse),
            );
          case Routes.childCategoryProductRoute:
            return BlocProvider(
              create: (context) => ChildCategoryProductBloc(RealProductRepo()),
              child: ChildCategoryProduct(
                  data: arguments as SubSubCategoryDataResponse),
            );
          case Routes.allLatestProductRoute:
            return BlocProvider(
              create: (context) => AllProductBloc(RealProductRepo()),
              child: const AllLatestProduct(),
            );
          case Routes.allCategoryRoute:
            return AllCategoryPage(
                data: arguments as List<CategoryDataResponse>);
          case Routes.categoryProductRoute:
            return BlocProvider(
              create: (context) => CategoryProductBloc(RealProductRepo()),
              child: CategoryProduct(
                  categoryData: arguments as CategoryDataResponse),
            );
          case Routes.allFlashProductRoute:
            return AllFlashProduct(data: arguments as FlashDealDataResponse);
          case Routes.detailProductRoute:
            return ProductDetail(id: arguments as int);
          case Routes.topBrandProductRoute:
            return BlocProvider(
              create: (context) => BrandProductBloc(RealProductRepo()),
              child: TopBrandProduct(brandId: arguments as int),
            );
          case Routes.allBrandRoute:
            return AllBrands(data: arguments as List<ShopDataResponse>);

          default:
            return unDefinedRoute();
        }
      },
    );
    // final isOnline=context.
  }

  static unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Text(AppStrings.noRouteFound),
    );
  }

  static noInternetWidget(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImageAssets.internet,
              height: 250,
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            Text(
              AppStrings.noInternet,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}

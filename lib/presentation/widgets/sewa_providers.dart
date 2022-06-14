import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/business_logic/bloc/buyNow/buy_now_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/changePassword/change_password_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/forgotPassword/forgot_password_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/socialLogin/social_login_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/updateTransaction/update_transaction_bloc.dart';
import 'package:sewa_digital/business_logic/cubit/choice_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/color_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/counter_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/index_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/network_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/stock_cubit.dart';
import 'package:sewa_digital/business_logic/notification/notification_bloc.dart';
import 'package:sewa_digital/business_logic/orderCancel/order_cancel_bloc.dart';
import 'package:sewa_digital/data/repo/delivery_repo.dart';
import 'package:sewa_digital/data/repo/notification_repo.dart';
import 'package:sewa_digital/data/repo/repos.dart';

class SewaProvider extends StatelessWidget {
  final Widget child;
  const SewaProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ConnectivityCubit(true),
      ),
      BlocProvider(
        create: (context) => StockCubit(),
      ),
      BlocProvider(
        create: (context) => ChoiceCubit(),
      ),
      BlocProvider(
        create: (context) => ColorCubit(),
      ),
      BlocProvider(
        create: (context) => CounterCubit(),
      ),
      BlocProvider(
        create: (context) => IndexCubit(),
      ),
      BlocProvider(
        create: (context) => UpdateTransactionBloc(RealPlaceOrderRepo()),
      ),
      BlocProvider(create: (context) => BannerBloc(RealBannerRepo())),
      BlocProvider(create: (context) => SliderBloc(RealBannerRepo())),
      BlocProvider(create: (context) => CategoryBloc(RealCategoryRepo())),
      BlocProvider(create: (context) => ChangePasswordBloc(RealAuthRepo())),
      BlocProvider(create: (context) => ForgotPasswordBloc(RealAuthRepo())),
      BlocProvider(
          create: (context) => SubCategoryBloc(
                RealCategoryRepo(),
              )),
      BlocProvider(
        create: (context) => NotificationBloc(RealNotificationRepo()),
      ),
      BlocProvider(
          create: (context) => ChildCategoryBloc(
                RealCategoryRepo(),
              )),
      BlocProvider(create: (context) => SocialLoginBloc(RealAuthRepo())),
      BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
      BlocProvider(create: (context) => ProductBloc(RealProductRepo())),
      BlocProvider(create: (context) => FeaturedProductBloc(RealProductRepo())),
      BlocProvider(create: (context) => ProductDetailBloc(RealProductRepo())),
      BlocProvider(create: (context) => RelatedProductBloc(RealProductRepo())),
      BlocProvider(create: (context) => ShopDetailBloc(RealProductRepo())),
      BlocProvider(create: (context) => ShopProductBloc(RealProductRepo())),
      BlocProvider(
          create: (context) => DistrictBloc(RealDeliveryLocationRepo())),
      BlocProvider(
          create: (context) =>
              DeliveryLocationBloc(RealDeliveryLocationRepo())),
      BlocProvider(
          create: (context) => DeliveryChargeBloc(RealDeliveryLocationRepo())),
      BlocProvider(
          create: (context) => CartBloc(
                RealCartRepo(),
              )),
      BlocProvider(
          create: (context) => BuyNowBloc(
                RealCartRepo(),
              )),
      BlocProvider(
          create: (context) => GeneralSettingBloc(
              RealGeneralSettingRepo(), BlocProvider.of<CartBloc>(context))),
      BlocProvider(create: (context) => AddressBloc(RealAddressRepo())),
      BlocProvider(create: (context) => SearchBloc(RealSearchRepo())),
      BlocProvider(create: (context) => TopBrandBloc(RealProductRepo())),
      BlocProvider(create: (context) => FlashSaleBloc(RealProductRepo())),
      BlocProvider(create: (context) => PlaceOrderBloc(RealPlaceOrderRepo())),
      BlocProvider(create: (context) => VariantBloc(RealVariantRepo())),
      BlocProvider(
          create: (context) => OrderHistoryBloc(RealOrderHistoryRepo())),
      BlocProvider(
          create: (context) => OrderCancelBloc(RealOrderHistoryRepo())),
      BlocProvider(
          create: (context) => OrderHistoryDetailBloc(RealOrderHistoryRepo())),
      BlocProvider(create: (context) => UpdatedProfileBloc(RealProfileRepo())),
      BlocProvider(create: (context) => AddToWishlistBloc(RealWishlistRepo())),
      BlocProvider(
          create: (context) => WishlistBloc(
              RealWishlistRepo(), BlocProvider.of<AddToWishlistBloc>(context))),
      BlocProvider(
          create: (context) => ProfileBloc(
              RealProfileRepo(),
              BlocProvider.of<UpdatedProfileBloc>(context),
              BlocProvider.of<AuthBloc>(context),
              BlocProvider.of<SocialLoginBloc>(context))
            ..add(GetProfile())),
    ], child: child);
  }
}

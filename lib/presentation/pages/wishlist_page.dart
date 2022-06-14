import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sewa_digital/business_logic/bloc/addToWishList/add_wishlist_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/wishlist/wishlist_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    getWishlistData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.wishList),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistError) {
            return Center(
              child: Text(state.message.toString()),
            );
          } else if (state is WishlistLoaded) {
            return state.response.data!.isEmpty
                ? Center(
                    child: Text(AppStrings.empty,
                        style: Theme.of(context).textTheme.headline1),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p5, vertical: AppPadding.p10),
                    child: ListView.builder(
                      itemCount: state.response.data!.length,
                      itemBuilder: (context, index) {
                        var wishlistData = state.response.data![index];
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.detailProductRoute,
                                    arguments: int.parse(wishlistData
                                        .product!.product_id
                                        .toString()));
                              },
                              child: Card(
                                elevation: 0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Image.network(
                                          ImageAssets.baseUrl +
                                              wishlistData
                                                  .product!.thumbnail_image
                                                  .toString(),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: AppSize.s10),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                wishlistData.product!.name
                                                    .toString(),
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            const SizedBox(
                                              height: AppSize.s8,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "Rs." +
                                                    wishlistData.product!
                                                        .base_discounted_price!
                                                        .toStringAsFixed(0) +
                                                    "    ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        color:
                                                            ColorManager.orange,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              TextSpan(
                                                  text: wishlistData.product!
                                                              .base_discounted_price!
                                                              .toStringAsFixed(
                                                                  0) ==
                                                          num.parse(wishlistData.product!.unit_price.toString())
                                                              .toStringAsFixed(
                                                                  0)
                                                      ? ""
                                                      : "Rs." +
                                                          num.parse(wishlistData
                                                                  .product!
                                                                  .unit_price
                                                                  .toString())
                                                              .toStringAsFixed(
                                                                  0),
                                                  style: const TextStyle(
                                                      fontSize:
                                                          SewaFontSize.s14,
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough))
                                            ])),
                                            const SizedBox(
                                              height: AppSize.s8,
                                            ),
                                            RatingBar.builder(
                                              wrapAlignment:
                                                  WrapAlignment.start,
                                              initialRating: double.parse(
                                                  wishlistData.product!.rating
                                                      .toString()),
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
                                              height: AppSize.s8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<AddToWishlistBloc, AddToWishlistState>(
                              listener: (context, state) {
                                if (state is AddToWishlistError) {
                                  ToastManager.sewaSnackBar(
                                      context, state.message.toString());
                                } else if (state is AddToWishlistLoaded) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ToastManager.sewaSnackBar(context,
                                      state.response.message.toString());
                                }
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AddToWishlistBloc>(context)
                                        .add(DeleteWishlistProduct(
                                            wishlistData.id!));
                                  },
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.all(AppMargin.m10),
                                        padding:
                                            const EdgeInsets.all(AppPadding.p5),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )),
                                );
                              },
                            )
                          ],
                        );
                      },
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  getWishlistData(context) {
    BlocProvider.of<WishlistBloc>(context).add(GetWishlist());
  }
}

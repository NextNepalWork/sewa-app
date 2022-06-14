import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/business_logic/bloc/buyNow/buy_now_bloc.dart';
import 'package:sewa_digital/business_logic/cubit/choice_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/color_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/counter_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/index_cubit.dart';
import 'package:sewa_digital/business_logic/cubit/stock_cubit.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/constant/value_manager.dart';
import 'package:sewa_digital/data/model/product_detail_response.dart';
import 'package:sewa_digital/data/model/variant_response.dart';
import 'package:sewa_digital/presentation/pages/gallery_page.dart';
import 'package:sewa_digital/presentation/screen/shop/shop_screen.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style1.dart';
import 'package:sewa_digital/presentation/widgets/choice_chips.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  const ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int currentIndex = 0;
  int variantIndex = 0;
  int variantIndex1 = 0;
  String? size;
  String? fabric;
  String? color;
  List choice = [];
  List choice1 = [];

  @override
  void initState() {
    AppSession.userId == null ? "" : checkWishList(context, widget.id);
    getCounter(context);
    getIndex(context);
    getColorIndex(context);

    getRelatedProduct(context, widget.id);
    getDetailedProduct(context, widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ProductDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 50,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: AppMargin.m15),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorManager.black
                                  : ColorManager.white),
                          child: Icon(
                            Icons.arrow_back,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                          )),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          AppSession.userId == null
                              ? Navigator.pushNamed(context, Routes.loginRoute)
                              : Navigator.pushNamed(context, Routes.cartRoute);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: AppMargin.m15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.black
                                    : ColorManager.white),
                            padding: const EdgeInsets.all(5),
                            child: Badge(
                              padding: const EdgeInsets.all(6),
                              badgeContent: BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  if (state is CartError) {
                                    return Text("0",
                                        style: getSemiBoldStyle(
                                            color: ColorManager.white));
                                  } else if (state is CartLoaded) {
                                    return Text(
                                      state.response.data!.length.toString(),
                                      style: getSemiBoldStyle(
                                          color: ColorManager.white),
                                    );
                                  } else {
                                    return Text("0",
                                        style: getSemiBoldStyle(
                                            color: ColorManager.white));
                                  }
                                },
                              ),
                              badgeColor: ColorManager.primaryBlue,
                              child: const Icon(
                                Icons.shopping_cart,
                              ),
                            )),
                      ),
                    ],
                    pinned: true,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? ColorManager.black
                            : Colors.white,
                    expandedHeight: size * .41,
                    flexibleSpace: FlexibleSpaceBar(
                      // title: productImages(state),

                      background: productImages(state),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(state.response.data!.length,
                              (index) {
                            var productDetail = state.response.data![index];
                            calculateVariantPrice(productDetail);

                            productDetail.colors!.isEmpty &&
                                    productDetail.choice_options!.isEmpty
                                ? null
                                : BlocProvider.of<VariantBloc>(context).add(
                                    GetVariantPrice(
                                        productDetail.id!,
                                        choice,
                                        productDetail.colors!.isEmpty
                                            ? ''
                                            : productDetail.colors![0]));
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        titleHeader(productDetail, context),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        productDetail.user!.shop_name!.isEmpty
                                            ? const SizedBox()
                                            : shopName(productDetail),

                                        const SizedBox(
                                          height: 8,
                                        ),
                                        productDetail.variant_product == 1
                                            ? productPrice(productDetail)
                                            : realProductPrice(productDetail),
                                        productDetail.discount! > 0
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: AppPadding.p10),
                                                child: Text(
                                                    productDetail
                                                                .discount_type ==
                                                            "amount"
                                                        ? "Rs."
                                                            "${productDetail.discount!.toStringAsFixed(0)} off"
                                                        : "${productDetail.discount}% off",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            color: ColorManager
                                                                .primaryBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                SewaFontSize
                                                                    .s14)),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        const Divider(
                                          height: 10,
                                          thickness: 1,
                                        ),

                                        productSpec(context, productDetail),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 3,
                                          thickness: 1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        productService(context, productDetail),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 3,
                                          thickness: 1,
                                        ),

                                        productBrand(context, productDetail),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 3,
                                          thickness: 1,
                                        ),
                                        productReview(context, productDetail),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 3,
                                          thickness: 1,
                                        ),
                                        productDetail.variant_product == 1 &&
                                                productDetail
                                                    .choice_options!.isNotEmpty
                                            ? variantSize(productDetail)
                                            : const SizedBox(),
                                        productDetail.variant_product == 1 &&
                                                productDetail.colors!.isNotEmpty
                                            ? variantColor(productDetail)
                                            : BlocConsumer<VariantBloc,
                                                VariantState>(
                                                listener: (context, state) {
                                                  if (state is VariantError) {
                                                    ToastManager.sewaSnackBar(
                                                        context,
                                                        state.message
                                                            .toString());
                                                  } else if (state
                                                      is VariantLoaded) {
                                                    context
                                                        .read<StockCubit>()
                                                        .checkStock(state
                                                            .response
                                                            .in_stock!);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return const SizedBox();
                                                },
                                              ),

                                        // const SizedBox(height: 5),

                                        LocaleText(
                                          AppStrings.quantity,
                                          style: getSemiBoldStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? ColorManager.white
                                                  : ColorManager.black,
                                              fontSize: AppSize.s14),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s14,
                                        ),
                                        productQuantity(context),
                                        const SizedBox(
                                          height: AppSize.s20,
                                        ),
                                        const Divider(
                                          height: 1,
                                          thickness: 1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        descriptionHeader(),
                                        productDetail.description == null
                                            ? const SizedBox()
                                            : productDescription(productDetail),

                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          height: 1,
                                          thickness: 1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        relatedProduct(),
                                        const SizedBox(
                                          height: 35,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          })),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton:
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoaded) {
              return sewaFooter(state.response.data![0]);
            } else {
              return const SizedBox();
            }
          },
        ));
  }

  sewaFooter(ProductDetailDataResponse productDetail) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.grey.withOpacity(.3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 1,
          ),
          GestureDetector(
            onTap: () {
              productDetail.user!.shop_id!.isEmpty
                  ? ToastManager.sewaSnackBar(
                      context, AppStrings.inHouseProduct)
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ShopScreen(
                          id: int.parse(productDetail.user!.shop_id!),
                          title: productDetail.user!.shop_name.toString())));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [Icon(Icons.store), Text("Store")],
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: ColorManager.grey,
                )
              ],
            ),
          ),
          buyNowButton(productDetail),
          addToCartButton(productDetail),
          const SizedBox(
            width: 1,
          ),
        ],
      ),
    );
  }

  productQuantity(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                }),
          ),
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(state.toString(),
                      style: getSemiBoldStyle(color: ColorManager.black)));
            },
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.read<CounterCubit>().increment();
                }),
          ),
        ],
      ),
    );
  }

  productDescription(ProductDetailDataResponse productDetail) {
    var data = productDetail.description!.replaceAll("&nbsp;", "");
    //return Text(data);
    return Html(
      data: data,
      style: {
        "span": Style(
            backgroundColor: Colors.transparent,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorManager.white
                : ColorManager.black,
            fontFamily: FontConstants.fontFamily),
        "p": Style(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorManager.white
              : ColorManager.black,
          fontFamily: FontConstants.fontFamily,
        ),
        "table": Style(

            //height: 502,

            backgroundColor: Colors.white,
            border: Border.all(color: Colors.grey)),
        "td": Style(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
          border: Border.all(color: Colors.grey),
          backgroundColor: Colors.transparent,
        ),
        "ul": Style(
            backgroundColor: Colors.transparent,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorManager.white
                : ColorManager.black,
            fontWeight: FontWeight.normal,
            textOverflow: TextOverflow.visible,
            fontFamily: FontConstants.fontFamily),
        "body": Style(
            backgroundColor: Colors.transparent,
            fontSize: FontSize.rem(0.978),
            wordSpacing: 2,
            textAlign: TextAlign.justify,
            lineHeight: LineHeight.number(1.2),
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorManager.white
                : ColorManager.black,
            fontWeight: FontWeight.normal,
            textOverflow: TextOverflow.visible,
            fontFamily: FontConstants.fontFamily),
      },
    );
  }

  descriptionHeader() {
    return LocaleText(
      AppStrings.productDescription,
      style: getSemiBoldStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorManager.white
              : ColorManager.black,
          fontSize: AppSize.s14),
    );
  }

  BlocConsumer<CartBloc, CartState> addToCartButton(
      ProductDetailDataResponse productDetail) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          ToastManager.sewaSnackBar(context, state.message.toString());
        } else if (state is AddToCartLoaded) {
          BlocProvider.of<CartBloc>(context).add(GetFromCart());
          ToastManager.sewaSnackBar(context, state.response.message.toString());
        }
      },
      builder: (context1, state) {
        return SizedBox(
          width: 120,
          child: BlocBuilder<StockCubit, StockState>(
            builder: (context2, stockState) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ColorManager.primaryBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: productDetail.variant_product == 0 &&
                          num.parse(productDetail.current_stock.toString()) <= 0
                      ? null
                      : productDetail.variant_product == 1 &&
                              stockState.inStock == false
                          ? null
                          : () {
                              String variationData = "null";

                              for (var item in choice1) {
                                variationData = variationData.toString() +
                                    "-" +
                                    (item['name'].toString().trim());
                              }

                              AppSession.userId == null
                                  ? Navigator.pushNamed(
                                      context, Routes.loginRoute)
                                  : BlocProvider.of<CartBloc>(context1).add(
                                      AddToCart(
                                          productId: productDetail.id,
                                          quantity: context
                                              .read<CounterCubit>()
                                              .state,
                                          variant: variationData == "null"
                                              ? ''
                                              : variationData
                                                  .trim()
                                                  .split("null-")
                                                  .last
                                                  .replaceAll(" ", ""),
                                          color: productDetail
                                                      .variant_product ==
                                                  0
                                              ? null
                                              : productDetail.variant_product ==
                                                          1 &&
                                                      productDetail
                                                          .colors!.isEmpty
                                                  ? null
                                                  : context
                                                      .read<ColorCubit>()
                                                      .state
                                                      .colorData));
                            },
                  child: LocaleText(state is CartLoading
                      ? AppStrings.pleaseWait
                      : productDetail.variant_product == 0 &&
                              num.parse(
                                      productDetail.current_stock.toString()) <=
                                  0
                          ? AppStrings.outOfStock
                          : productDetail.variant_product == 1 &&
                                  stockState.inStock == false
                              ? AppStrings.outOfStock
                              : AppStrings.addToCart));
            },
          ),
        );
      },
    );
  }

  BlocConsumer<BuyNowBloc, BuyNowState> buyNowButton(
      ProductDetailDataResponse productDetail) {
    return BlocConsumer<BuyNowBloc, BuyNowState>(
      listener: (context, state) {
        if (state is BuyNowError) {
          ToastManager.sewaSnackBar(context, state.message.toString());
        } else if (state is BuyNowLoaded) {
          Navigator.pushNamed(context, Routes.cartRoute);
          ToastManager.sewaSnackBar(context, state.response.message.toString());
        }
      },
      builder: (context1, state) {
        return SizedBox(
          width: 120,
          child: BlocBuilder<StockCubit, StockState>(
            builder: (context2, stockState) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ColorManager.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: productDetail.variant_product == 0 &&
                          num.parse(productDetail.current_stock.toString()) <= 0
                      ? null
                      : productDetail.variant_product == 1 &&
                              stockState.inStock == false
                          ? null
                          : () {
                              String variationData = "null";

                              for (var item in choice1) {
                                variationData = variationData.toString() +
                                    "-" +
                                    (item['name'].toString().trim());
                              }

                              AppSession.userId == null
                                  ? Navigator.pushNamed(
                                      context, Routes.loginRoute)
                                  : BlocProvider.of<BuyNowBloc>(context1).add(
                                      BuyNow(
                                          productId: productDetail.id,
                                          quantity: context
                                              .read<CounterCubit>()
                                              .state,
                                          variant: variationData == "null"
                                              ? ''
                                              : variationData
                                                  .trim()
                                                  .split("null-")
                                                  .last
                                                  .replaceAll(" ", ""),
                                          color: productDetail
                                                      .variant_product ==
                                                  0
                                              ? null
                                              : productDetail.variant_product ==
                                                          1 &&
                                                      productDetail
                                                          .colors!.isEmpty
                                                  ? null
                                                  : context
                                                      .read<ColorCubit>()
                                                      .state
                                                      .colorData));
                            },
                  child: LocaleText(state is BuyNowLoading
                      ? AppStrings.pleaseWait
                      : productDetail.variant_product == 0 &&
                              num.parse(
                                      productDetail.current_stock.toString()) <=
                                  0
                          ? AppStrings.outOfStock
                          : productDetail.variant_product == 1 &&
                                  stockState.inStock == false
                              ? AppStrings.outOfStock
                              : AppStrings.buyNow));
            },
          ),
        );
      },
    );
  }

  productService(
    BuildContext context,
    ProductDetailDataResponse productDetail,
  ) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Text(
                            "Service",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ),
                      const Divider(),
                      ExpansionTile(
                        expandedAlignment: Alignment.topLeft,
                        childrenPadding: const EdgeInsets.only(
                            left: AppPadding.p20 + AppPadding.p10,
                            bottom: AppPadding.p10),
                        collapsedTextColor: ColorManager.black,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text(
                          "- 7 Day Return",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, Routes.returnPolicyRoute);
                                  },
                                text: "Return Policy",
                                style: TextStyle(
                                  color: ColorManager.orange,
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                                text: "  apply",
                                style:
                                    getMediumStyle(color: ColorManager.black))
                          ]))
                        ],
                      )
                    ],
                  ));
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Service",
                style: getSemiBoldStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorManager.white
                        : ColorManager.black,
                    fontSize: AppSize.s14),
              ),
              smallText(context),
              smallText(context,
                  text: productDetail.warranty == 0
                      ? "- Warranty not available"
                      : productDetail.warranty_time.toString() ==
                              null.toString()
                          ? "- Warranty not available"
                          : "- " +
                              productDetail.warranty_time.toString() +
                              " warranty"),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 23,
            ),
          )
        ],
      ),
    );
  }

  smallText(BuildContext context, {String? text}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p5, top: AppPadding.p8),
      child: Text(
        text ?? "- 7 Day Return",
        style: getSemiBoldStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorManager.grey
                : ColorManager.grey,
            fontSize: AppSize.s12),
      ),
    );
  }

  productSpec(BuildContext context, ProductDetailDataResponse productDetail) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: Text(
                              "Specifications",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        const Divider(),
                        Html(
                          data: productDetail.specs.toString(),
                          style: {
                            "span": Style(
                                backgroundColor: Colors.transparent,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                                fontFamily: FontConstants.fontFamily),
                            "p": Style(
                                backgroundColor: Colors.transparent,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                                fontFamily: FontConstants.fontFamily),
                            "table": Style(
                                backgroundColor: Colors.white,
                                border: Border.all(color: Colors.white)),
                            "td": Style(
                              width: double.infinity,
                              backgroundColor: Colors.transparent,
                            ),
                            "ul": Style(
                                backgroundColor: Colors.transparent,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                                fontWeight: FontWeight.normal,
                                textOverflow: TextOverflow.visible,
                                fontFamily: FontConstants.fontFamily),
                            "body": Style(
                                backgroundColor: Colors.transparent,
                                fontSize: FontSize.rem(0.978),
                                wordSpacing: 3,
                                textAlign: TextAlign.justify,
                                lineHeight: LineHeight.number(1.2),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.black,
                                fontWeight: FontWeight.normal,
                                textOverflow: TextOverflow.visible,
                                fontFamily: FontConstants.fontFamily),
                          },
                        ),
                      ],
                    ),
                  ));
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Specifications",
            style: getSemiBoldStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorManager.white
                    : ColorManager.black,
                fontSize: AppSize.s14),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 23,
            ),
          )
        ],
      ),
    );
  }

  GestureDetector productBrand(
      BuildContext context, ProductDetailDataResponse productDetail) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: Text(
                              "Shop, Brand & Category",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          "Shop",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.network(ImageAssets.baseUrl +
                              productDetail.user!.avatar_original.toString()),
                          title: productDetail.user!.shop_id!.isEmpty
                              ? const Text(
                                  "In House Product",
                                )
                              : Text(productDetail.user!.shop_name.toString()),
                          trailing: TextButton(
                            onPressed: productDetail.user!.shop_id!.isEmpty
                                ? null
                                : () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => ShopScreen(
                                                id: int.parse(productDetail
                                                    .user!.shop_id!),
                                                title: productDetail
                                                    .user!.shop_name
                                                    .toString())));
                                  },
                            child: productDetail.user!.shop_id!.isEmpty
                                ? const SizedBox()
                                : Text(
                                    "Visit store",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.orange,
                                        fontSize: SewaFontSize.s12),
                                  ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          "Brand",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.topBrandProductRoute,
                                arguments: int.parse(
                                    productDetail.brand!.id.toString()));
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Image.network(ImageAssets.baseUrl +
                              productDetail.brand!.logo.toString()),
                          title: Text(
                            productDetail.brand!.name.toString(),
                          ),
                        ),
                        const Divider(),
                        Text(
                          "Category",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.network(ImageAssets.baseUrl +
                              productDetail.category!.banner.toString()),
                          title: Text(productDetail.category!.name.toString()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              );
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shop,Brand & Category",
            style: getSemiBoldStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorManager.white
                    : ColorManager.black,
                fontSize: AppSize.s14),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 23,
            ),
          )
        ],
      ),
    );
  }

  productReview(BuildContext context, ProductDetailDataResponse productDetail) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p10),
                    child: Text(AppStrings.reviews,
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  const Divider(),
                  productDetail.reviews!.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p100),
                          child: Text(
                            "No Reviews",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                              productDetail.reviews!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: ListTile(
                                      tileColor:
                                          ColorManager.grey.withOpacity(.1),
                                      minLeadingWidth: 10.0,
                                      dense: true,
                                      minVerticalPadding: 15.0,
                                      leading: const CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: RatingBar.builder(
                                        itemSize: 15.0,
                                        initialRating: double.parse(
                                            productDetail.reviews![index].rating
                                                .toString()),
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          " " +
                                              productDetail
                                                  .reviews![index].comment
                                                  .toString(),
                                          style: getMediumStyle(
                                              color: ColorManager.black),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                ],
              );
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: AppStrings.reviews,
                  style: getSemiBoldStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorManager.white
                          : ColorManager.black,
                      fontSize: AppSize.s14),
                  children: [
                TextSpan(
                    text: " (${productDetail.reviews!.length})",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: ColorManager.grey)),
              ])),
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 23,
            ),
          )
        ],
      ),
    );
  }

  realProductPrice(ProductDetailDataResponse productDetail) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: "Rs." + productDetail.home_discounted_price! + "    ",
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
            color: ColorManager.orange,
            fontSize: SewaFontSize.s18,
            fontWeight: FontWeight.bold),
      ),
      TextSpan(
          text: productDetail.discount! > 0.0
              ? "Rs" + productDetail.unit_price.toString()
              : "",
          style: const TextStyle(
              fontSize: SewaFontSize.s14,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough))
    ]));
  }

  productPrice(ProductDetailDataResponse productDetail) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<VariantBloc, VariantState>(builder: (context, state) {
          if (state is VariantLoaded) {
            return Text(
              "Rs." + state.response.price!.toStringAsFixed(0),
              style: getSemiBoldStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorManager.orange
                    : ColorManager.orange,
                fontSize: AppSize.s20,
              ).copyWith(fontWeight: FontWeight.bold),
            );
          } else {
            return Text(
              "Rs" + productDetail.unit_price.toString(),
              style: getSemiBoldStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorManager.orange
                    : ColorManager.orange,
                fontSize: AppSize.s20,
              ).copyWith(fontWeight: FontWeight.bold),
            );
          }
        }),
        const SizedBox(
          width: 10,
        ),
        Text(
            productDetail.discount! > 0.0
                ? "Rs" + productDetail.unit_price.toString()
                : "",
            style: const TextStyle(
                fontSize: SewaFontSize.s14,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough))
      ],
    );
  }

  shopName(ProductDetailDataResponse productDetail) {
    return Text(
      productDetail.user!.shop_name == null
          ? "N/A"
          : productDetail.user!.shop_name.toString(),
      style: getSemiBoldStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorManager.white
              : ColorManager.black,
          fontSize: AppSize.s14),
    );
  }

  titleHeader(ProductDetailDataResponse productDetail, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(productDetail.name.toString(),
              style: getSemiBoldStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorManager.white
                      : ColorManager.black,
                  fontSize: AppSize.s14)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<AddToWishlistBloc, AddToWishlistState>(
              listener: (context, state) {
                if (state is AddToWishlistError) {
                  ToastManager.sewaSnackBar(context, state.message.toString());
                } else if (state is AddToWishlistLoaded) {
                  ToastManager.sewaSnackBar(
                      context, state.response.message.toString());

                  BlocProvider.of<AddToWishlistBloc>(context)
                      .add(CheckWishlistProduct(productDetail.id!));
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                    backgroundColor: ColorManager.grey.withOpacity(.3),
                    heroTag: "tag2",
                    elevation: 0,
                    mini: true,
                    onPressed: () {
                      AppSession.userId == null
                          ? Navigator.pushNamed(context, Routes.loginRoute)
                          : BlocProvider.of<AddToWishlistBloc>(context)
                              .add(AddToWishlist(productDetail.id!));
                    },
                    child: Icon(
                      Icons.favorite,
                      color: state is CheckWishlistProductLoaded &&
                              state.response.is_in_wishlist == true
                          ? Colors.red
                          : Colors.white,
                      size: 18,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: FloatingActionButton(
                backgroundColor: ColorManager.grey.withOpacity(.3),
                heroTag: "tag1",
                elevation: 0,
                mini: true,
                onPressed: () {
                  Share.share(ImageAssets.baseUrl +
                      productDetail.photos![0] +
                      "\n" +
                      productDetail.name.toString() +
                      "\n" +
                      "Price: " +
                      "Rs." +
                      productDetail.unit_price.toString());
                },
                child: Icon(
                  Icons.share,
                  color: ColorManager.white,
                  size: 18,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  variantColor(ProductDetailDataResponse productDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Colors",
          style: getSemiBoldStyle(
              color: ColorManager.black, fontSize: AppSize.s14),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(productDetail.colors!.length, (index) {
            String colorData = productDetail.colors![index];
            BlocProvider.of<ColorCubit>(context)
                .switchIndex(0, productDetail.colors![0]);
            String color = colorData.replaceAll("#", "");
            color = "FF" + color.toString();
            return BlocConsumer<VariantBloc, VariantState>(
              listener: (context1, state1) {
                if (state1 is VariantError) {
                  ToastManager.sewaSnackBar(
                      context1, state1.message.toString());
                } else if (state1 is VariantLoaded) {
                  context
                      .read<StockCubit>()
                      .checkStock(state1.response.in_stock!);
                }
              },
              builder: (context1, state) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<ColorCubit>(context)
                        .switchIndex(index, colorData);

                    BlocProvider.of<VariantBloc>(context1).add(
                        GetVariantPrice(productDetail.id!, choice, colorData));
                  },
                  child: Stack(
                    children: [
                      BlocBuilder<ColorCubit, ColorState>(
                        builder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.only(
                                right: 6, top: 10, bottom: 10),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(int.parse(color, radix: 16))),
                            child: state.index == index
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            );
          }),
        )
      ],
    );
  }

  variantSize(
    ProductDetailDataResponse productDetail,
  ) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: AppPadding.p15),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productDetail.choice_options!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productDetail.choice_options![index].title.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              ChoiceChips(
                choice: choice,
                index: index,
                choiceOptions: productDetail.choice_options!,
                chipName: productDetail.choice_options![index],
                choiceChipsCallback: (variation) {
                  choice1 = variation;
                  context.read<VariantBloc>().add(GetVariantPrice(
                      productDetail.id!,
                      variation,
                      productDetail.colors!.isEmpty
                          ? ''
                          : context.read<ColorCubit>().state.colorData!));
                },
              ),
            ],
          );
        });
  }

  Widget productImages(ProductDetailLoaded state) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PhotoGallery(
                      photos: state.response.data![0].photos!,
                      index: currentIndex,
                    )));
          },
          child: PhotoViewGallery.builder(
            pageController: PageController(
              initialPage: 0,
            ),
            itemCount: state.response.data![0].photos!.length,
            builder: (context, index) {
              final urlImage = state.response.data![0].photos![index];
              return PhotoViewGalleryPageOptions(
                  initialScale: PhotoViewComputedScale.covered,
                  basePosition: Alignment.topCenter,
                  disableGestures: true,
                  imageProvider: NetworkImage(ImageAssets.baseUrl + urlImage),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4);
            },
            onPageChanged: (index) {
              BlocProvider.of<IndexCubit>(context).switchIndex(index);
              currentIndex = index;
            },
          ),
        ),
        BlocBuilder<IndexCubit, IndexState>(
          builder: (context, indexState) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: ColorManager.grey),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p10, vertical: AppPadding.p5),
                  child: Text(
                    "${indexState.index! + 1} /${state.response.data![0].photos!.length}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  relatedProduct() {
    return BlocBuilder<RelatedProductBloc, RelatedProductState>(
      builder: (context, state) {
        if (state is RelatedProductError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is RelatedProductLoaded) {
          return state.response.data!.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleText(AppStrings.relatedProduct,
                        style: Theme.of(context).textTheme.headline2),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        itemCount: state.response.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var products = state.response.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.detailProductRoute,
                                  arguments: products.id!);
                            },
                            child: CardStyle1(products: products),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  calculateVariantPrice(ProductDetailDataResponse productDetail) {
    if (productDetail.choice_options!.isEmpty) {
      choice.clear();
      choice = choice;
    } else {
      choice.clear();
      for (var item in productDetail.choice_options!) {
        choice.add(VariantDataResponse(item.options![0]).toMap());
        choice1 = choice;
      }
    }
  }

  getRelatedProduct(context, int id) {
    BlocProvider.of<RelatedProductBloc>(context).add(GetRelatedProducts(id));
  }

  getDetailedProduct(context, int id) {
    BlocProvider.of<ProductDetailBloc>(context).add(GetProductDetail(id));
  }

  checkWishList(context, int id) {
    BlocProvider.of<AddToWishlistBloc>(context).add(CheckWishlistProduct(id));
  }

  getCounter(context) {
    BlocProvider.of<CounterCubit>(context).emit(1);
  }

  getIndex(context) {
    BlocProvider.of<IndexCubit>(context).switchIndex(0);
  }

  getColorIndex(context) {
    BlocProvider.of<ColorCubit>(context).switchIndex(0, '');
  }

  getChoiceIndex(context) {
    BlocProvider.of<ChoiceCubit>(context).switchIndex(0, 0);
  }
}

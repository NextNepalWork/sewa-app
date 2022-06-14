import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/product_response.dart';

class CardStyle2 extends StatelessWidget {
  final ProductDataResponse product;
  const CardStyle2({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 0,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s8),
                        topRight: Radius.circular(AppSize.s8)),
                    child: product.featured_image.toString() ==
                            ImageAssets.backendPlaceHolder
                        ? Image.asset(ImageAssets.placeholder)
                        : Image.network(
                            ImageAssets.baseUrl +
                                product.featured_image.toString(),
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorManager.orange),
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  "No Image",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              SizedBox(
                width: 140,
                child: Text(product.name.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Rs." +
                      product.base_discounted_price!.toString() +
                      "    ",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: ColorManager.orange, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: product.discount! > 0.0
                        ? "Rs" + product.unit_price.toString()
                        : "",
                    style: const TextStyle(
                        fontSize: SewaFontSize.s14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough))
              ])),
              const SizedBox(
                height: AppSize.s8,
              ),
              RatingBar.builder(
                wrapAlignment: WrapAlignment.start,
                initialRating: double.parse(product.rating.toString()),
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
        product.discount != null && product.discount_type == "percent"
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                      right: AppMargin.m5 - 1, top: AppMargin.m5 - 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0)),
                      color: product.discount! > 0
                          ? Colors.red
                          : Colors.transparent),
                  child: Text(
                    product.discount! > 0
                        ? "-" + product.discount.toString() + "%"
                        : "",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: ColorManager.white),
                  ),
                ))
            : const SizedBox(),
      ],
    );
  }
}

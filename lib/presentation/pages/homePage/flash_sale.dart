import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/business_logic/bloc/flashSale/flash_sale_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/cardStyle/card_style1.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({Key? key}) : super(key: key);

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  @override
  void initState() {
    getFlashSale(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashSaleBloc, FlashSaleState>(
      builder: (context, state) {
        if (state is FlashSaleError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FlashSaleLoaded) {
          return state.response.data == null
              ? const SizedBox()
              : state.response.data!.products!.data!.isEmpty
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppMargin.m5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LocaleText(AppStrings.flashSale,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                    const SizedBox(
                                      width: AppSize.s10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: ColorManager.orange,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: CountdownTimer(
                                          endWidget: SizedBox(
                                            width: 185,
                                            child: Text(
                                              "The Current Time has expired",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                      color: ColorManager.white,
                                                      fontSize:
                                                          SewaFontSize.s12),
                                            ),
                                          ),
                                          endTime: int.parse(state
                                                  .response.data!.end_date
                                                  .toString()) *
                                              1000,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  color: ColorManager.white),
                                          onEnd: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.allFlashProductRoute,
                                        arguments: state.response.data);
                                  },
                                  child: LocaleText(
                                    AppStrings.seeMore,
                                    style: getSemiBoldStyle(
                                        color: ColorManager.primaryBlue
                                            .withOpacity(1),
                                        fontSize: SewaFontSize.s14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8)),
                          height: 240,
                          child: ListView.builder(
                            itemCount:
                                state.response.data!.products!.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var products =
                                  state.response.data!.products!.data![index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.detailProductRoute,
                                        arguments: products.id!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 4),
                                    child: CardStyle1(products: products),
                                  ));
                            },
                          ),
                        ),
                      ],
                    );
        } else {
          return LoadingEffect(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 160,
                    width: 180,
                    child: Card(
                      elevation: 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  color: Colors.white,
                                ),
                                width: 200,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  getFlashSale(context) {
    BlocProvider.of<FlashSaleBloc>(context).add(GetFlashSale());
  }
}

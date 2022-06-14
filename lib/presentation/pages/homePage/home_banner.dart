import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/banner/banner_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  void initState() {
    getBanner(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerError) {
          return Center(child: Text(state.message));
        }
        if (state is BannerLoaded) {
          return CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                initialPage: 0,
                height: 180,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {},
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s8)),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: double.maxFinite,
                        child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              child: Image.network(
                                ImageAssets.baseUrl +
                                    state.response.data![index].photo
                                        .toString(),
                                fit: BoxFit.fill,
                              ),
                            ))));
              },
              itemCount: state.response.data!.length);
        } else {
          return LoadingEffect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                color: ColorManager.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m5),
              height: 180,
              width: double.infinity,
            ),
          );
        }
      },
    );
  }

  getBanner(context) {
    BlocProvider.of<BannerBloc>(context).add(GetBanner());
  }
}

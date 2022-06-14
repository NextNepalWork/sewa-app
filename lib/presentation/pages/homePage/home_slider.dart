import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/slider/slider_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int currentIndex = 0;
  @override
  void initState() {
    getHomeSlider(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        if (state is SliderError) {
          return Center(child: Text(state.message));
        } else if (state is SliderLoaded) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    height: 180,
                    autoPlayInterval: const Duration(seconds: 5),
                    enlargeCenterPage: false,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10)),
                            width: double.maxFinite,
                            child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10)),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10),
                                  child: Image.network(
                                    ImageAssets.baseUrl +
                                        state.response.data![index].photo
                                            .toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ))));
                  },
                  itemCount: state.response.data!.length),
              SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.response.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            shape: BoxShape.circle,
                            color: currentIndex == index
                                ? ColorManager.orange
                                : ColorManager.black),
                      );
                    },
                  ))
            ],
          );
        } else {
          return LoadingEffect(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  color: Colors.white),
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m5),
              height: 180,
              width: double.infinity,
            ),
          );
        }
      },
    );
  }

  getHomeSlider(context) {
    BlocProvider.of<SliderBloc>(context).add(GetHomeSlider());
  }
}

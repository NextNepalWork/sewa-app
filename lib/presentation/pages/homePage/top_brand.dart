import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/topBrand/top_brand_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';
import 'package:sewa_digital/presentation/widgets/title_heading.dart';

class HomeTopBrand extends StatefulWidget {
  const HomeTopBrand({Key? key}) : super(key: key);

  @override
  State<HomeTopBrand> createState() => _HomeTopBrandState();
}

class _HomeTopBrandState extends State<HomeTopBrand> {
  @override
  void initState() {
    getTopBrand(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopBrandBloc, TopBrandState>(
      builder: (context, state) {
        if (state is TopBrandError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is TopBrandLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleHeading(
                onTap: () {
                  Navigator.pushNamed(context, Routes.allBrandRoute,
                      arguments: state.response.data!);
                },
                text1: AppStrings.brand,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.response.data!.length,
                  itemBuilder: (context, index) {
                    var topBrand = state.response.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.topBrandProductRoute,
                            arguments: topBrand.id!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorManager.black
                              : ColorManager.grey3.withOpacity(.2),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppMargin.m5),
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(topBrand.name.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.headline1),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  child: Image.network(
                                    ImageAssets.baseUrl +
                                        topBrand.logo.toString(),
                                    fit: BoxFit.contain,
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return LoadingEffect(
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        color: ColorManager.white),
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppMargin.m5),
                    width: 120,
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  getTopBrand(context) {
    BlocProvider.of<TopBrandBloc>(context).add(GetTopBrand());
  }
}

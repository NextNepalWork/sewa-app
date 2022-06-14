import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/categories/category_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';
import 'package:sewa_digital/presentation/widgets/title_heading.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  void initState() {
    getCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is CategoryLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              TitleHeading(
                onTap: () {
                  Navigator.pushNamed(context, Routes.allCategoryRoute,
                      arguments: state.response.data!);
                },
                text1: AppStrings.category,
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.response.data!.length > 10
                    ? 10
                    : state.response.data!.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  var categoryData = state.response.data![index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.categoryProductRoute,
                              arguments: categoryData);
                        },
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(ImageAssets.baseUrl +
                              categoryData.banner.toString()),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        categoryData.name!.split("&").first,
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  );
                },
              ),
            ],
          );
        } else {
          return LoadingEffect(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 3.0),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }

  getCategory(context) {
    BlocProvider.of<CategoryBloc>(context).add(GetCategory());
  }
}

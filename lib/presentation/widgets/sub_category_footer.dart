import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/subCategory/sub_category_bloc.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/repo/category_repo.dart';
import 'package:sewa_digital/presentation/widgets/loading_effect.dart';

class SubCategoryFooter extends StatelessWidget implements PreferredSizeWidget {
  final int categoryId;
  const SubCategoryFooter({Key? key, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubCategoryBloc(RealCategoryRepo())..add(GetSubCategory(categoryId)),
      child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
        builder: (context, state) {
          if (state is SubCategoryError) {
            return Center(child: Text(state.message.toString()));
          } else if (state is SubCategoryLoaded) {
            return state.response.data!.isEmpty
                ? const SizedBox()
                : Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p10, vertical: AppPadding.p10),
                      child: SizedBox(
                        height: 43,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(state.response.data!.length,
                                (index) {
                              var subCat = state.response.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.subCategoryProductRoute,
                                      arguments: subCat);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 2, top: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? ColorManager.white
                                              : ColorManager.grey
                                                  .withOpacity(.3),
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: AppPadding.p8,
                                            horizontal: AppPadding.p12),
                                        child: Text(
                                          subCat.name.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!,
                                        ),
                                      ),
                                    )),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  );
          } else {
            return LoadingEffect(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p10),
              child: SizedBox(
                height: 43,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 45,
                          width: 100,
                          margin: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 2, top: 2),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorManager.grey, width: 1),
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ));
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(60);
  }

  getSubCategory(
    context,
  ) {
    BlocProvider.of<SubCategoryBloc>(context).add(GetSubCategory(categoryId));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/constant/constants.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String title = "Category";
  int selectedIndex = 0;

  int id = 8;
  @override
  void initState() {
    getCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryError) {
                    return Center(child: Text(state.message));
                  } else if (state is CategoryLoaded) {
                    id = state.response.data![0].id!;
                    return Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p10),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.grey.withOpacity(.2),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            var categoryData = state.response.data![index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  title = categoryData.name.toString();
                                  id = state.response.data![index].id!;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s14),
                                      child: Image.network(
                                        ImageAssets.baseUrl +
                                            categoryData.banner.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(categoryData.name.toString(),
                                        textAlign: TextAlign.center,
                                        style: getRegularStyle(
                                                color: selectedIndex == index
                                                    ? ColorManager.orange
                                                    : Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                            .copyWith(
                                                fontWeight:
                                                    selectedIndex == index
                                                        ? FontWeight.bold
                                                        : FontWeight.normal)),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: AppSize.s14,
                            );
                          },
                          itemCount: state.response.data!.length),
                    );
                  } else {
                    return const Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator());
                  }
                },
              )),
          Expanded(
            flex: 5,
            child: SubCategory(
              id: id,
            ),
          ),
        ],
      ),
    );
  }

  getCategory(context) {
    BlocProvider.of<CategoryBloc>(context).add(GetCategory());
  }
}

class SubCategory extends StatefulWidget {
  final int id;
  const SubCategory({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    getSubCategory(context);
    return BlocBuilder<SubCategoryBloc, SubCategoryState>(
      builder: (context, state) {
        if (state is SubCategoryError) {
          return Center(child: Text(state.message));
        } else if (state is SubCategoryLoaded) {
          return ListView(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p15, top: 3, right: AppPadding.p5),
              child: ExpansionPanelList.radio(
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  animationDuration: const Duration(milliseconds: 50),
                  elevation: 0,
                  children: List.generate(state.response.data!.length, (index) {
                    var item = state.response.data![index];
                    return ExpansionPanelRadio(
                        backgroundColor: Colors.transparent,
                        value: Text(
                          item.name.toString(),
                        ),
                        headerBuilder: (context, isExpanded) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.subCategoryProductRoute,
                                    arguments: item);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPadding.p15),
                                child: Text(
                                  item.name.toString(),
                                  textAlign: TextAlign.start,
                                  style: getBoldStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : ColorManager.black,
                                  ),
                                ),
                              ));
                        },
                        body: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                item.subSubCategories!.data!.length,
                                (newIndex) {
                              var subItem =
                                  item.subSubCategories!.data![newIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Routes.childCategoryProductRoute,
                                          arguments: subItem);
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        subItem.name.toString(),
                                        textAlign: TextAlign.start,
                                        style: getSemiBoldStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : ColorManager.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  )
                                ],
                              );
                            })));
                  })),
            ),
          ]);
          // Text(subCategoryData.name.toString());

        } else {
          return const Align(
              alignment: Alignment.topCenter, child: LinearProgressIndicator());
        }
      },
    );
  }

  getSubCategory(
    context,
  ) {
    BlocProvider.of<SubCategoryBloc>(context).add(GetSubCategory(widget.id));
  }
}

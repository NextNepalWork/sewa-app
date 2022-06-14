import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/category_response.dart';

class AllCategoryPage extends StatelessWidget {
  final List<CategoryDataResponse> data;
  const AllCategoryPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.allCategory),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p5, vertical: AppPadding.p5),
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.3,
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0),
          itemBuilder: (context, index) {
            var categoryData = data[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.categoryProductRoute,
                    arguments: categoryData);
              },
              child: Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: Column(
                    //    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: AppSize.s10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(ImageAssets.baseUrl +
                              categoryData.banner.toString()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppSize.s12,
                            bottom: AppSize.s5,
                            right: AppSize.s5),
                        child: SizedBox(
                          width: 100,
                          child: Text(
                            categoryData.name.toString(),
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}

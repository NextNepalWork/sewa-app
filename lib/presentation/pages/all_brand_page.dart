import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/shop_response.dart';

class AllBrands extends StatefulWidget {
  final List<ShopDataResponse> data;
  const AllBrands({Key? key, required this.data}) : super(key: key);

  @override
  State<AllBrands> createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(AppStrings.allBrands),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.builder(
          itemCount: widget.data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
          itemBuilder: (context, index) {
            var brandData = widget.data[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.topBrandProductRoute,
                    arguments: brandData.id!);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    child: Image.network(
                      ImageAssets.baseUrl + brandData.logo.toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

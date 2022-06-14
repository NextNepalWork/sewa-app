import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sewa_digital/constant/constants.dart';

class PhotoGallery extends StatefulWidget {
  final List<String> photos;
  final int index;
  const PhotoGallery({Key? key, required this.photos, required this.index})
      : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.gallery),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: PageController(initialPage: widget.index),
            itemCount: widget.photos.length,
            builder: (context, index) {
              final urlImage = widget.photos[index];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(ImageAssets.baseUrl + urlImage),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4);
            },
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Image ${currentIndex + 1} /${widget.photos.length}",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

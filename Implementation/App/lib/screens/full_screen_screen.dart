import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;

  const FullScreenImage({Key? key, this.imageFile, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
              tag: "imageHero", child: PhotoView(imageProvider: buildImage())),
        ),
      ),
    );
  }

  ImageProvider buildImage() {
    if (imageFile != null && imageUrl != null) {
      throw Exception(
          "Both imageFile and imageUrl cannot be set at the same time");
    } else if (imageFile != null) {
      return Image.file(imageFile!).image;
    } else if (imageUrl != null) {
      return Image.network(imageUrl!).image;
    } else {
      throw Exception("No image provided. Check your input!");
    }
  }
}

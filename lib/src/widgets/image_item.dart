import 'package:flutter/material.dart';
import 'package:like_pinterest/src/models/picsum_image.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageItem extends StatelessWidget {
  final PicsumImage image;

  const ImageItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
                alignment: Alignment.center,
                height: 60,
                child: const CircularProgressIndicator()),
          ),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: image.downloadUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

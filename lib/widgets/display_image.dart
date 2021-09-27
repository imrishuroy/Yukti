import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:yukti/constants/constants.dart';

class DisplayImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  const DisplayImage({Key? key, required this.imageUrl, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('DisplayImages $imageUrl');
    return CachedNetworkImage(
      width: width ?? 1000.0,
      height: double.infinity,
      imageUrl: imageUrl ?? errorImage,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
            strokeWidth: 2.0, value: downloadProgress.progress),
      ),
      // errorWidget: (context, url, error) {
      //   return const NoImageAvailable();
      // },
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}

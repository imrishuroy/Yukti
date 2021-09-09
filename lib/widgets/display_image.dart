// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// const String _errorImage =
//     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjMD6Pl7n4lSFFphlDlRz7o4ULYlNrAC9KJN4sfz9mRDDgU_FzGrA-DNgLL8keHh90KJg&usqp=CAU';

// class DisplayImage extends StatelessWidget {
//   final String? imageUrl;
//   final double? width;
//   const DisplayImage({Key? key, required this.imageUrl, this.width})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       width: width ?? 1000.0,
//       height: double.infinity,
//       imageUrl: imageUrl ?? _errorImage,
//       //  fit: BoxFit.cover,
//       progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//         child: CircularProgressIndicator(
//             strokeWidth: 2.0, value: downloadProgress.progress),
//       ),
//       errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
//     );
//   }
// }

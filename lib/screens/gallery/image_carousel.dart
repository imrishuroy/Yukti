import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://raw.githubusercontent.com/imrishuroy/Images/main/carousel-1.jpg',
  'https://raw.githubusercontent.com/imrishuroy/Images/main/carousel-2.jpeg',
  'https://raw.githubusercontent.com/imrishuroy/Images/main/carousel-3.jpeg',
];

final List<Widget> imageSliders = imgList
    .map(
      (item) => SizedBox(
        // height: 400,
        width: 500,
        child: Container(
          // height: 400,
          width: 1600,
          //  margin: EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              // Radius.circular(20.0),
              Radius.circular(10.0),
            ),
            child: Image.network(item, fit: BoxFit.cover, width: 2000.0),
          ),
        ),
      ),
    )
    .toList();

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageCarouselState();
  }
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 3.0,
                  scrollPhysics: const ScrollPhysics(),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  // margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? const Color.fromRGBO(0, 0, 0, 0.9)
                        : const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}

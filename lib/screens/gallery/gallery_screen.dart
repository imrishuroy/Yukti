import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

import '/constants/constants.dart';
import '/models/gallery.dart';
import '/respositories/firebase/firebase_repositroy.dart';
import '/widgets/app_drawer.dart';

import 'image_carousel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    final _random = Random();

    // generate a random index based on the list length
// and use it to retrieve the element
    var quote = quotes[_random.nextInt(quotes.length)];

    // final AppDataBase database =
    //     Provider.of<AppDataBase>(context, listen: false);
    return Scaffold(
      drawer: const AppDrawer(
        photoUrl:
            'https://firebasestorage.googleapis.com/v0/b/yukti-ac0c0.appspot.com/o/user_image%2FpIPZ1bjCsZYA4dFBzIa2iw8WNwo1.jpg?alt=media&token=a4708c11-09a5-41c8-9290-887cbfc38514',
      ),
      // backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      //  backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.alignLeft,
              size: 27.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        // automaticallyImplyLeading: false,
        // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text(
          'Gallery',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 22.3,
            backgroundColor: Colors.deepOrange,
            child: CircleAvatar(
              radius: 19.5,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://raw.githubusercontent.com/imrishuroy/Rishu-Portfolio/master/assets/avtar.png'),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.message),
          //   onPressed: () {
          //     // Navigator.pushNamed(
          //     //   context,
          //     //   AttendanceScreen3.routeName,
          //     //   // NewAttendanceScreen.routeName,
          //     //   // arguments: database,
          //     // );
          //   },
          // ),
          SizedBox(width: 17.0),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 18.0),
          const ImageCarousel(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${quote['quote']}',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    '${quote['author']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 203, 0, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      letterSpacing: 1.1,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Gallery?>>(
              future: _firebaseRepo.getGalleryImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(color: Colors.white),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final gallery = snapshot.data?[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          '${gallery?.imageUrl}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.symmetric(
//     horizontal: 20.0,
//     vertical: 10.0,
//   ),
//   child: TextField(
//     decoration: InputDecoration(
//       fillColor: Colors.white24,
//       filled: true,
//       hintText: 'What are you looking for?',
//       suffixIcon: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: IconButton(
//           icon: Icon(
//             Icons.search,
//             color: Colors.green,
//             size: 40.0,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//     ),
//   ),
// ),
// //  SizedBox(height: 5.0),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       OneGalleryCard(
//         color: Color(0xffffa45b),
//         label: 'Campus',
//         icon: Icons.apartment,
//       ),
//       OneGalleryCard(
//         color: Color(0xff65d6ce),
//         label: 'Cantein',
//         icon: Icons.food_bank,
//       ),
//       OneGalleryCard(
//         color: Color(0xffb6eb7a),
//         label: 'Classes',
//         icon: Icons.group_sharp,
//       ),
//     ],
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       OneGalleryCard(
//         color: Color(0xffffb0cd),
//         label: 'Lab',
//       ),
//       OneGalleryCard(
//         color: Color(
//           0xffed6663,
//         ),
//         icon: Icons.workspaces_outline,
//         label: 'Workspaces',
//       ),
//       OneGalleryCard(
//         color: Color(0xff5edfff),
//         icon: Icons.more_vert,
//         label: 'More',
//       ),
//     ],
//   ),
// ),

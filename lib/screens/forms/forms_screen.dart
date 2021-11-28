import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/app_drawer.dart';
import '/models/google_form.dart';
import '/respositories/firebase/firebase_repositroy.dart';

import 'form_expansion_tile.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    return FutureBuilder<List<GoogleForm>>(
      future:
          _firebaseRepo.getGoogleForms(branch: 'CSE', sem: '5th', section: 'B'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final forms = snapshot.data;

        return Scaffold(
          drawer: const AppDrawer(
            photoUrl:
                'https://firebasestorage.googleapis.com/v0/b/yukti-ac0c0.appspot.com/o/user_image%2FpIPZ1bjCsZYA4dFBzIa2iw8WNwo1.jpg?alt=media&token=a4708c11-09a5-41c8-9290-887cbfc38514',
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
            centerTitle: true,
            title: const Text('Forms'),
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  FontAwesomeIcons.alignLeft,
                  size: 26.0,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: [
              CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: Text(
                  '${forms?.length ?? '0'}',
                  // '${snapshot.data.length ?? '0'}',

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 5.0),
              Expanded(
                child: FutureBuilder<List<GoogleForm>>(
                  future: _firebaseRepo.getGoogleForms(
                      branch: 'CSE', sem: '5th', section: 'B'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final _cardKey =
                            GlobalObjectKey<ExpansionTileCardState>(index);
                        final form = snapshot.data?[index];
                        return FormExpansionTile(
                          cardKey: _cardKey,
                          form: form,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.grey.shade900,
//           automaticallyImplyLeading: false,
//           title: Text('Forms'),
//           centerTitle: true,
//           bottom: TabBar(
//             indicatorColor: Color(0XFF00286E),
//             indicatorWeight: 3.0,
//             tabs: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.feed),
//                   const SizedBox(width: 10.0),
//                   const Text(
//                     'Submitted',
//                     style: TextStyle(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.feed),
//                   const SizedBox(width: 10.0),
//                   const Text(
//                     'UnSubmitted',
//                     style: TextStyle(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             SubmittedForm(),
//             Icon(Icons.directions_transit),
//           ],
//         ),
//       ),
//     );
//   }
// }

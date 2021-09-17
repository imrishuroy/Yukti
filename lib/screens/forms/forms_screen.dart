import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/widgets/app_drawer.dart';
import '/models/google_form.dart';
import '/respositories/firebase/firebase_repositroy.dart';

import 'form_expansion_tile.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Forms'),
        centerTitle: true,
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

import 'package:flutter/material.dart';
import 'package:yukti/models/google_form.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:yukti/respositories/firebase/firebase_repositroy.dart';
import 'form_expansion_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmittedForm extends StatelessWidget {
  const SubmittedForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    return Column(
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
    );
  }
}





// eg of expandion card 

//  Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: ExpansionTileCard(
//             key: cardB,
//             expandedTextColor: Colors.red,
//             leading: CircleAvatar(child: Text('B')),
//             title: Text('Tap me!'),
//             subtitle: Text('I expand, too!'),
//             children: <Widget>[
//               Divider(
//                 thickness: 1.0,
//                 height: 1.0,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 8.0,
//                   ),
//                   child: Text(
//                     """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

// Use me any time you think your app could benefit from being just a bit more Material.

// These buttons control the card above!""",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2!
//                         .copyWith(fontSize: 16),
//                   ),
//                 ),
//               ),
//               ButtonBar(
//                 alignment: MainAxisAlignment.spaceAround,
//                 buttonHeight: 52.0,
//                 buttonMinWidth: 90.0,
//                 children: <Widget>[
//                   TextButton(
//                     style: flatButtonStyle,
//                     onPressed: () {
//                       cardA.currentState?.expand();
//                     },
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.arrow_downward),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                         ),
//                         Text('Open'),
//                       ],
//                     ),
//                   ),
//                   TextButton(
//                     style: flatButtonStyle,
//                     onPressed: () {
//                       cardA.currentState?.collapse();
//                     },
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.arrow_upward),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                         ),
//                         Text('Close'),
//                       ],
//                     ),
//                   ),
//                   TextButton(
//                     style: flatButtonStyle,
//                     onPressed: () {
//                       cardA.currentState?.toggleExpansion();
//                     },
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.swap_vert),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.0),
//                         ),
//                         Text('Toggle'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),


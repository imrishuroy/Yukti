import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/display_image.dart';

import 'happenings_details.dart';

const List happenings = [
  {
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/yukti-ac0c0.appspot.com/o/1.jpeg?alt=media&token=93e8899e-4e95-467f-9708-9f490d1f452a',
    'title':
        'Student Webinar - Cisco Ideathon 2021 | Monday Sep 20th | 4:45 pm',
    'description':
        '''Dear Students, Below is the Open Webinar link for Students to join on Monday, September 20th at 4:45 pm. No prior registration needed.

It’s an important Webinar, hear Cisco’s leaders and experts on “How to Ace the Cisco Ideathon process”..''',
  },
  {
    'imageUrl':
        'https://developers.google.com/community/images/gdsc-solution-challenge/gdsc_2021_header_720.png',
    'title': 'Solution Challenge DSC OIST',
    'description':
        'The 2021 Solution Challenge mission is to solve for one or more of the United Nations 17 Sustainable Development Goals using Google technology.\nCreated by the United Nations in 2015 to be achieved by 2030, the 17 Sustainable Development Goals (SDGs) agreed upon by all 193 United Nations Member States aim to end poverty, ensure prosperity, and protect the planet.',
  },
  {
    'imageUrl':
        'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2020/08/PTI02-08-2020_000039B.jpg',
    'title': 'Offline mode from tomorrow.',
    'description':
        'Dear students Your classes are starting in offline mode from tomorrow. Kindly ensure you come with hard copy of Covid vaccine certificate and Consent form.',
  },
];

class HappeningsScreen extends StatelessWidget {
  const HappeningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Happenings'),
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
        actions: const [
          CircleAvatar(
            radius: 14.0,
            backgroundColor: Colors.white,
            child: Text(
              '3',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: ListView.builder(
        itemCount: happenings.length,
        itemBuilder: (context, index) {
          return OneHappeningCard(
            imageUrl: happenings[index]['imageUrl'],
            tilte: happenings[index]['title'],
            description: happenings[index]['description'],
          );
        },
      ),
    );
  }
}

class OneHappeningCard extends StatelessWidget {
  final String? imageUrl;
  final String? tilte;
  final String? description;

  const OneHappeningCard(
      {Key? key, this.imageUrl, this.tilte, this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 9.0,
        right: 9.0,
        top: 3.0,
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HappeningDetailScreen(
              imageUrl: imageUrl,
              title: tilte,
              description: description,
            ),
          ),
        ),
        child: Card(
          elevation: 8.0,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            leading: SizedBox(
              height: 100.0,
              width: 100.0,
              child: DisplayImage(imageUrl: imageUrl),
            ),
            title: Text(
              '$tilte',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: description!.length >= 30
                ? Text('${description?.substring(0, 30)}...')
                : Text('$description'),
          ),
        ),
      ),
    );
  }
}

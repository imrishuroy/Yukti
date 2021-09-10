import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'happenings_details.dart';

const List happenings = [
  {
    'imageUrl': 'https://i.ndtvimg.com/i/2018-01/holi_650x400_51516870691.jpg',
    'title': 'Wish you a happy and safe Holi !',
    'description':
        'May God gift you all the colours of life, colours of joy, colours of happiness, colours of friendship, colours of love and all other colours you want to paint your life in.\n\nHappy Holi.',
  },
  {
    'imageUrl':
        'https://developers.google.com/community/images/dsc-solution-challange/dsc_2021_header.png',
    'title': 'Solution Challenge DSC OIST',
    'description':
        'The 2021 Solution Challenge mission is to solve for one or more of the United Nations 17 Sustainable Development Goals using Google technology.\nCreated by the United Nations in 2015 to be achieved by 2030, the 17 Sustainable Development Goals (SDGs) agreed upon by all 193 United Nations Member States aim to end poverty, ensure prosperity, and protect the planet.',
  },
  {
    'imageUrl':
        'https://medicaldialogues.in/h-upload/2020/05/18/128964-online-classes.webp',
    'title': 'Online classes till 31 March',
    'description':
        'As the corona cases are increasing offline classes are terminated we are organizing online classes till 31 march.\nThe new timetable will you provided on your respective WhatsApp group. Make sure to contact your TG for any queries. Please be at home and take care.',
  },
];

class HappeningsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('Happenings'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              FontAwesomeIcons.alignLeft,
              size: 27.0,
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
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            leading: Container(
              height: 100.0,
              width: 100.0,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.fill,
              ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yukti/data/external_links_data.dart';
import 'package:yukti/services/database_service.dart';
import 'package:yukti/widgets/display_image.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: database.profileDataSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data?.size == 0) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 250.0,
                  color: Color.fromRGBO(0, 141, 82, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.image),
                      ),
                    ],
                  ),
                ),
                _buildDrawerContents(context),
              ],
            ),
          );
        } else {
          return Drawer(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data?.size,
              itemBuilder: (context, index) {
                final name = snapshot.data?.docs[index]['name'];
                final enrollNo = snapshot.data?.docs[index]['enrollNo'];
                final branch = snapshot.data?.docs[index]['branch'];
                final section = snapshot.data?.docs[index]['section'];
                final sem = snapshot.data?.docs[index]['sem'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromRGBO(0, 141, 82, 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 50.0),
                          DisplayImage(
                            database: database,
                          ),
                          SizedBox(height: 17.0),
                          Text(
                            '$name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            '$enrollNo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            '$branch $sem sem ($section)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    _buildDrawerContents(context),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }

  SizedBox _buildDrawerContents(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height < 750 ? 300 : 500.0,
      child: ListView.builder(
        itemCount: externalLink.length,
        itemBuilder: (context, index) {
          return Center(
            child: ListTile(
              leading: Icon(
                externalLink[index]['icon'],
                color: Color.fromRGBO(0, 141, 82, 1),
              ),
              title: Text(
                '${externalLink[index]['title']}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  externalLink[index]['navigateToScreen'] == true
                      ? Navigator.pushNamed(
                          context, externalLink[index]['link'])
                      : _launchInBrowser('${externalLink[index]['link']}');
                },
                icon: Icon(
                  Icons.open_in_new_rounded,
                  color: Color.fromRGBO(0, 141, 82, 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

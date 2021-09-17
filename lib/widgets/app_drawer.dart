import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yukti/constants/constants.dart';

// import 'user_profile_image.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _launchInBrowser(String url) async {
    try {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'});
    } catch (error) {
      print('Error laucnching url ${error.toString()}');
    }

    // if (await canLaunch(url)) {

    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<DataBase>(context, listen: false);
    // return StreamBuilder<QuerySnapshot>(
    //   stream: database.profileDataSnapshot,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }

    //     if (snapshot.data?.size == 0) {
    //       return

    //     }

    return Drawer(
        child: Container(
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            //  color: Color.fromRGBO(0, 141, 82, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 55.0),
                CircleAvatar(
                  radius: 53.3,
                  backgroundColor: Colors.deepOrange,
                  child: CircleAvatar(
                    radius: 50.5,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://raw.githubusercontent.com/imrishuroy/Rishu-Portfolio/master/assets/avtar.png'),
                  ),
                ),
                SizedBox(height: 17.0),
                // SizedBox(height: 20.0),
              ],
            ),
          ),
          _buildDrawerContents(context),
        ],
      ),
    )

        // ListView(
        //   padding: EdgeInsets.zero,
        //   children: [
        //     Container(
        //       color: Color.fromRGBO(0, 141, 82, 1),
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           SizedBox(height: 50.0),
        //           UserProfileImage(),
        //           SizedBox(height: 17.0),
        //           SizedBox(height: 20.0),
        //         ],
        //       ),
        //     ),
        //     _buildDrawerContents(context),
        //
        // Column(
        //   children: [
        //     for (int index = 0; index < externalLink.length; index++)
        //       Center(
        //         child: ListTile(
        //           leading: Icon(
        //             externalLink[index]['icon'],
        //             color: Color.fromRGBO(0, 141, 82, 1),
        //           ),
        //           title: Text(
        //             '${externalLink[index]['title']}',
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 16.0,
        //             ),
        //           ),
        //           trailing: IconButton(
        //             onPressed: () {
        //               externalLink[index]['navigateToScreen'] == true
        //                   ? Navigator.pushNamed(
        //                       context, externalLink[index]['link'])
        //                   : _launchInBrowser(
        //                       '${externalLink[index]['link']}');
        //             },
        //             icon: Icon(
        //               Icons.open_in_new_rounded,
        //               color: Color.fromRGBO(0, 141, 82, 1),
        //             ),
        //           ),
        //         ),
        //       ),
        //   ],
        // )
        //   ],
        // ),
        );
  }

  SizedBox _buildDrawerContents(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height < 750 ? 300 : 600.0,
      child: ListView.builder(
        itemCount: externalLink.length,
        itemBuilder: (context, index) {
          return Center(
            child: ListTile(
              leading: Icon(
                externalLink[index]['icon'],
                color: const Color.fromRGBO(0, 141, 82, 1),
              ),
              title: Text(
                '${externalLink[index]['title']}',
                style: const TextStyle(
                  color: Colors.white,
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
                icon: const Icon(
                  Icons.open_in_new_rounded,
                  color: Color.fromRGBO(0, 141, 82, 1),
                  //color: Color.fromRGBO(40, 200, 253, 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

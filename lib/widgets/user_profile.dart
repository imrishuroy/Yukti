import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yukti/services/database_service.dart';

class UserProfile extends StatelessWidget {
  final DataBase? database;

  UserProfile({Key? key, this.database}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database?.profileDataSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data?.size == 0) {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(0, 141, 82, 1), // background
                // onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddProfileScreen(database: database),
                //   ),
                // );
              },
              child: Text(
                'Add Your Profile',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          );
        }
        // QuerySnapshot? querySnapshot = snapshot.data;
        return ListView.builder(
          itemCount: snapshot.data?.size,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 27.0,
                vertical: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      _profileDomainCard(
                          snapshot: snapshot, index: index, key: 'branch'),
                      _profileDomainCard(
                          snapshot: snapshot, index: index, key: 'sem'),
                      _profileDomainCard(
                          snapshot: snapshot, index: index, key: 'section'),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  _profileLabelText(label: 'Name'),
                  SizedBox(height: 3.0),
                  Text(
                    '${snapshot.data?.docs[index]['name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  _profileLabelText(label: 'Enrollment No'),
                  SizedBox(height: 3.0),
                  Text(
                    '${snapshot.data?.docs[index]['enrollNo']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  _profileLabelText(label: "Father's Name"),
                  SizedBox(height: 3.0),
                  Text(
                    '${snapshot.data?.docs[index]['father_name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  _profileLabelText(label: 'Mother\'s Name'),
                  SizedBox(height: 3.0),
                  Text(
                    '${snapshot.data?.docs[index]['mother_name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  _profileLabelText(label: 'Mobile Number'),
                  SizedBox(height: 3.0),
                  Text(
                    '${snapshot.data?.docs[index]['mobile_no']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      // onPressed: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditProfileScreen(
                      //       database: database,
                      //     ),
                      //   ),
                      // ),
                      child: Text('Edit Your Profile'),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _profileLabelText({String? label}) {
    return Column(
      children: [
        Text(
          '$label',
          style: TextStyle(
            fontSize: 16.0,
            // color: Color.fromRGBO(255, 203, 0, 1),
            color: Color.fromRGBO(255, 203, 0, 1),
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.5),
      ],
    );
  }

  Widget _profileDomainCard({
    AsyncSnapshot<QuerySnapshot>? snapshot,
    int? index,
    String? key,
  }) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              '${snapshot?.data?.docs[index!]['$key']}',
              style: TextStyle(
                //color: Color.fromRGBO(255, 203, 0, 1),
                color: Color.fromRGBO(0, 141, 82, 1),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

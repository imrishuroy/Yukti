import 'package:flutter/material.dart';

import 'lectures_screen.dart';

enum Section { a, b }

class LectureSelection extends StatefulWidget {
  static const String routeName = '/lecture-selction';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => LectureSelection(),
    );
  }

  @override
  _LectureSelectionState createState() => _LectureSelectionState();
}

class _LectureSelectionState extends State<LectureSelection> {
  String branchValue = 'CSE';
  String semValue = '2nd';
  Section? _section = Section.a;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('Lectures'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 3.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Please Select Your Domain',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: branchValue,
                        iconSize: 24,
                        elevation: 16,
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            branchValue = newValue!;
                            //   print(branchValue);
                          });
                        },
                        items: <String>[
                          'CSE',
                          'IT',
                          'ECE',
                          'EE',
                          'CE',
                          'ME',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: semValue,
                        iconSize: 24,
                        elevation: 16,
                        style:
                            TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            semValue = newValue!;
                            //  print(semValue);
                          });
                        },
                        items: <String>['2nd', '4th', '6th', '8th']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 40.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      title: Text('Section-A'),
                      leading: Radio(
                        value: Section.a,
                        groupValue: _section,
                        onChanged: (Section? value) {
                          setState(() {
                            _section = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Section-B'),
                      leading: Radio(
                        value: Section.b,
                        groupValue: _section,
                        onChanged: (Section? value) {
                          setState(() {
                            _section = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LectureScreen(
                    branch: branchValue,
                    section: _section == Section.a ? 'A' : 'B',
                    sem: semValue,
                  ),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Check',
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'lectures_screen.dart';

enum Section { a, b }

class LectureSelection extends StatefulWidget {
  static const String routeName = '/lecture-selction';

  const LectureSelection({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => const LectureSelection(),
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
      backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Lectures'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 3.0,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Please Select Your Domain',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: branchValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.deepPurple),
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
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: semValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.deepPurple),
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
                    const SizedBox(height: 10.0),
                    ListTile(
                      title: const Text('Section-A'),
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
                      title: const Text('Section-B'),
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
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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

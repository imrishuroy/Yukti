import 'package:flutter/material.dart';

import 'add_assignment_screen.dart';

enum Section { a, b }

class AssignmentSelection extends StatefulWidget {
  static const String routeName = '/assignment-selection';

  const AssignmentSelection({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return const AssignmentSelection();
      },
    );
  }

  @override
  _AssignmentSelectionState createState() => _AssignmentSelectionState();
}

class _AssignmentSelectionState extends State<AssignmentSelection> {
  String branchValue = 'CSE';
  String semValue = '1st';
  Section? _section = Section.a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Assignment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Please Select Your Assignment',
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
                        items: <String>['1st', '3rd', '5th', '7th']
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          branchValue,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          semValue,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _section == Section.a ? 'A' : 'B',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAssignmentScreen(
                      section: _section == Section.a ? 'A' : 'B',
                      branch: branchValue,
                      sem: semValue,
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

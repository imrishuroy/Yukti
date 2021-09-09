import 'package:flutter/material.dart';

import 'add_lecture_screen.dart';

// import 'package:weekday_selector/weekday_selector.dart';

enum Section { a, b }

class LectureSelection extends StatefulWidget {
  static const String routeName = '/lecture-selection';

  const LectureSelection({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return const LectureSelection();
      },
    );
  }

  @override
  _LectureSelectionState createState() => _LectureSelectionState();
}

class _LectureSelectionState extends State<LectureSelection> {
  String _branchValue = 'CSE';
  String _dayValue = 'Monday';
  String _semValue = '1st';
  String dayOfWeek = 'Monday';
  Section? _section = Section.a;
  DateTime? selectedDate = DateTime.now();
  // String weekday = 'Monday';
  // final DateFormat formatter = DateFormat('dd/MM/yy');

  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate!, // Refer step 1
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  // We start with all days selected.
  // final values = List.filled(7, true);

  @override
  Widget build(BuildContext context) {
    //  final String? formattedDate = formatter.format(selectedDate!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Add Lectures'),
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
                        'Please Select Your Lecture',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: _dayValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepPurple,
                        ),
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dayValue = newValue!;
                            //   print(branchValue);
                          });
                        },
                        items: <String>[
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday',
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
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.topCenter,
                      child: DropdownButton<String>(
                        value: _branchValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepPurple,
                        ),
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _branchValue = newValue!;
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
                        value: _semValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.deepPurple,
                        ),
                        underline: Container(
                          height: 3,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _semValue = newValue!;
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
                    const SizedBox(height: 10.0),
                    // Container(
                    //   padding: EdgeInsets.only(left: 25.0),
                    //   alignment: Alignment.bottomLeft,
                    //   child: TextButton.icon(
                    //     onPressed: () => _selectDate(context),
                    //     icon: Icon(Icons.calendar_today),
                    //     label: Text(
                    //       'Select Date',
                    //       style: TextStyle(fontSize: 20.0),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text(
                        //     '${DateFormat.yMMMMEEEEd().format(selectedDate!)}'),
                        // Text('${DateFormat.yMd().format(selectedDate!)}'),
                        // Text('$formattedDate'),
                        Text(
                          '$_branchValue $_semValue sem (${_section == Section.a ? 'A' : 'B'})',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _dayValue,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                        // Text('${DateFormat.M().format(selectedDate!)}'),

                        // Text('${DateFormat.EEEE().format(selectedDate!)}')
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
                // print(branchValue);
                // print(semValue);
                // if (_section == Section.a) {
                //   print('A');
                // } else {
                //   print('B');
                // }
                // print(_section);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddLectureScreen(
                      branch: _branchValue,
                      section: _section == Section.a ? 'A' : 'B',
                      sem: _semValue,
                      // day: DateFormat.EEEE().format(selectedDate!),
                      day: _dayValue,
                      // date: formattedDate,
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
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

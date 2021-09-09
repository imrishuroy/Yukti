import 'package:flutter/material.dart';

import 'add_attendance_screen.dart';

class AttendanceSelection extends StatefulWidget {
  static const String routeName = '/attendance-selection';

  const AttendanceSelection({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return const AttendanceSelection();
      },
    );
  }

  @override
  _AttendanceSelectionState createState() => _AttendanceSelectionState();
}

class _AttendanceSelectionState extends State<AttendanceSelection> {
  String branchValue = 'CSE';
  String semValue = '1st';
  final _enrollNoController = TextEditingController();
  String? _enrollNo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    final form = _formKey.currentState!;

    FocusScope.of(context).unfocus();
    if (form.validate()) {
      form.save();
      print(_enrollNoController.text);
      print(_enrollNo);
    }
  }

  void clear() {
    _enrollNoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    _enrollNoController.text = '0105${branchValue.substring(0, 2)}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Select Attendance'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      SizedBox(height: 25.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          onChanged: (value) => _enrollNo = value,
                          controller: _enrollNoController,
                          key: ValueKey('enrollNo'),
                          onSaved: (value) =>
                              _enrollNo = value?.trim().toUpperCase(),
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              !(value!.length >= 12) ? 'Invalid Input' : null,
                          decoration: const InputDecoration(
                            labelText: 'Enrollment Number',
                            hintText: 'Enter enrollment number eg 0105CS191091',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      builder: (context) => AddAttendaneScreen(
                        branch: branchValue,
                        sem: semValue,
                        enrollNo: _enrollNoController.text,
                      ),
                    ),
                  );
                  // _submit(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      ),
    );
  }
}

import 'package:admin_yukti/models/lecture.dart';
import 'package:admin_yukti/repositories/lecture/lecture_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddLectureScreen extends StatefulWidget {
  final String branch;
  final String sem;
  final String section;
  final String day;

  const AddLectureScreen({
    Key? key,
    required this.branch,
    required this.sem,
    required this.section,
    required this.day,
  }) : super(key: key);

  @override
  _AddLectureScreenState createState() => _AddLectureScreenState();
}

class _AddLectureScreenState extends State<AddLectureScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _subCode;
  String? _subName;
  String? _profName;

  bool _isSubmiting = false;

  TimeOfDay? _startingTime = TimeOfDay.now();
  TimeOfDay? _endingTime = TimeOfDay.now();
  List selectedLecture = [];
  final _subCodeController = TextEditingController();
  final _subNameController = TextEditingController();
  final _profNameController = TextEditingController();

  Future<void> _selectStartingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _startingTime!,
    );
    if (pickedTime != null && pickedTime != _startingTime) {
      setState(() {
        _startingTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _endingTime!,
    );
    if (pickedTime != null && pickedTime != _endingTime) {
      setState(() {
        _endingTime = pickedTime;
      });
    }
  }

  void resetForm() async {
    _subNameController.clear();
    _subCodeController.clear();
    _profNameController.clear();
    _startingTime = TimeOfDay.now();
    _endingTime = TimeOfDay.now();
  }

  void _submit() async {
    try {
      FocusScope.of(context).unfocus();
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        final lectureRepo = context.read<LectureRepository>();
        setState(() {
          _isSubmiting = true;
        });

        final lecture = Lecture(
          lectureId: const Uuid().v4(),
          profName: _profName,
          subCode: _subCode,
          subName: _subName,
          time:
              '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
        );

        await lectureRepo.addLecture(
          branch: widget.branch,
          sem: widget.sem,
          section: widget.section,
          day: widget.day,
          lecture: lecture,
        );

        _formKey.currentState?.reset();
        _subCodeController.clear();
        _subNameController.clear();
        _subNameController.clear();
      }
      setState(() {
        _isSubmiting = false;
      });
    } catch (error) {
      print('Error adding lecture ${error.toString()}');
      setState(() {
        _isSubmiting = false;
      });
    }
  }

  @override
  void dispose() {
    _subCodeController.dispose();
    _subNameController.dispose();
    _subNameController.dispose();
    super.dispose();
  }

  // void _submit(BuildContext context) async {
  //   final DataBase database = Provider.of<DataBase>(context, listen: false);
  //   final form = _formKey.currentState!;
  //   // final database = Provider.of<DataBase>(context, listen: false);
  //   FocusScope.of(context).unfocus();
  //   if (form.validate()) {
  //     form.save();

  //     setState(() {
  //       _isSubmiting = true;
  //     });

  //     DocumentSnapshot doc = await database.lecturesDocument(
  //       branch: widget.branch,
  //       sem: widget.sem,
  //       section: widget.section,
  //     );
  //     Map<String, dynamic>? data = doc.data();
  //     // print(data);

  //     // already available data
  //     // print(data);
  //     //  print(doc.exists);
  //     // List lectureDay = data?['${widget.day}'];
  //     // print(lectureDay);

  //     if (doc.exists) {
  //       List lectureDay = data?['${widget.day}'];

  //       selectedLecture = lectureDay;
  //       //  print(lectureDay);
  //       selectedLecture.add(
  //         {
  //           //  'day': '${widget.day}',
  //           //   'date': '${widget.date}',
  //           'subName': _subName,
  //           'profName': _profName,
  //           'subCode': _subCode,
  //           'time':
  //               '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
  //         },
  //       );
  //       // print('Selected Lecture Day $selectedLecture');
  //     } else {
  //       selectedLecture.add(
  //         {
  //           //'day': '${widget.day}',
  //           // 'date': '${widget.date}',
  //           'subName': _subName,
  //           'profName': _profName,
  //           'subCode': _subCode,
  //           'time':
  //               '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
  //         },
  //       );
  //     }

  //     // if (doc.exists) {
  //     //   List allLectures = await doc['${widget.day}'];
  //     //   print('All Lectres $allLectures');
  //     //   selectedLecture = allLectures;
  //     //   // selectedLecture = await allLectures['${widget.day}'];
  //     //   selectedLecture.add(
  //     //     {
  //     //       'day': '${widget.day}',
  //     //       'date': '${widget.date}',
  //     //       'subName': _subName,
  //     //       'profName': _profName,
  //     //       'subCode': _subCode,
  //     //       'time':
  //     //           '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
  //     //     },
  //     //   );
  //     // } else {
  //     //   selectedLecture.add(
  //     //     {
  //     //       'day': '${widget.day}',
  //     //       'date': '${widget.date}',
  //     //       'subName': _subName,
  //     //       'profName': _profName,
  //     //       'subCode': _subCode,
  //     //       'time':
  //     //           '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
  //     //     },
  //     //   );
  //     // }
  //     // using database class by the help of provider class
  //     await database.updateLecturesData(
  //       branch: widget.branch,
  //       sem: widget.sem,
  //       section: widget.section,
  //       day: widget.day,
  //       //  date: widget.date,
  //       subCode: _subCode,
  //       subName: _subName,
  //       profName: _profName,
  //       lecture: selectedLecture,
  //     );
  //     resetForm();

  //     setState(() {
  //       _isSubmiting = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.green,
  //         content: Text(
  //           'Lecture Added',
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('Day ${widget.day}');
    print('Branch ${widget.branch}');
    print('Section ${widget.section}');
    print('Sem ${widget.sem}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text(
            '${widget.day} - ${widget.branch} - ${widget.sem} Sem (${widget.section})'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              onPressed: () => _selectStartingTime(context),
                              icon: const Icon(Icons.timer),
                              label: const Text(
                                'Start',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => _selectEndingTime(context),
                              icon: const Icon(Icons.timer),
                              label: const Text(
                                'End',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //SizedBox(width: 2.0),
                            Text(
                              '${_startingTime?.format(context)}',
                              style: const TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '${_endingTime?.format(context)}',
                              style: const TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            //SizedBox(width: 2.0),
                          ],
                        ),
                        const SizedBox(height: 10.0)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15.0,
                ),
                child: TextFormField(
                  controller: _subCodeController,
                  key: const ValueKey('subCode'),
                  onSaved: (value) => _subCode = value?.trim().toUpperCase(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Subject Code',
                    hintText: 'Enter subject code',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15.0,
                ),
                child: TextFormField(
                  controller: _subNameController,
                  key: const ValueKey('subName'),
                  onSaved: (value) => _subName = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.isNotEmpty) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Subject Name',
                    hintText: 'Enter subject name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15.0,
                ),
                child: TextFormField(
                  controller: _profNameController,
                  key: const ValueKey('profName'),
                  onSaved: (value) => _profName = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Prof Name',
                    hintText: 'Enter name of proffessor',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              if (_isSubmiting) const CircularProgressIndicator(),
              if (!_isSubmiting)
                ElevatedButton(
                  onPressed: _submit,
                  //  onPressed: () => _submit(context),
                  // onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text('Add Lecture'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// print(lectures
//     .doc('${widget.branch}')
//     .collection('${widget.sem}')
//     .doc('${widget.section}')
//     .get());
// print(widget.branch);
// print(widget.sem);
// print(widget.section);
// print(widget.date);
// print(widget.day);
// print(selectedTime(context));

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lms_admin/services/database_service.dart';
// import 'package:provider/provider.dart';

// class AddLectureScreen extends StatefulWidget {
//   final String? branch;
//   final String? sem;
//   final String? section;
//   final String? date;
//   final String? day;

//   const AddLectureScreen({
//     Key? key,
//     @required this.branch,
//     @required this.sem,
//     @required this.section,
//     @required this.date,
//     @required this.day,
//   }) : super(key: key);

//   @override
//   _AddLectureScreenState createState() => _AddLectureScreenState();
// }

// class _AddLectureScreenState extends State<AddLectureScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   CollectionReference lectures =
//       FirebaseFirestore.instance.collection('lecture');

//   String? _subCode;
//   String? _subName;
//   String? _profName;

//   bool _isSubmiting = false;

//   TimeOfDay? _startingTime = TimeOfDay.now();
//   TimeOfDay? _endingTime = TimeOfDay.now();
//   List selectedLecture = [];
//   TextEditingController _subCodeController = TextEditingController();
//   TextEditingController _subNameController = TextEditingController();
//   TextEditingController _profNameController = TextEditingController();

//   Future<void> _selectStartingTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _startingTime!,
//     );
//     if (pickedTime != null && pickedTime != _startingTime) {
//       setState(() {
//         _startingTime = pickedTime;
//       });
//     }
//   }

//   Future<void> _selectEndingTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _endingTime!,
//     );
//     if (pickedTime != null && pickedTime != _endingTime) {
//       setState(() {
//         _endingTime = pickedTime;
//       });
//     }
//   }

//   void resetForm() async {
//     _subNameController.clear();
//     _subCodeController.clear();
//     _profNameController.clear();
//     _startingTime = TimeOfDay.now();
//     _endingTime = TimeOfDay.now();
//   }

//   void _submit(BuildContext context) async {
//     final DataBase database = Provider.of<DataBase>(context, listen: false);
//     final form = _formKey.currentState!;
//     // final database = Provider.of<DataBase>(context, listen: false);
//     FocusScope.of(context).unfocus();
//     if (form.validate()) {
//       form.save();

//       setState(() {
//         _isSubmiting = true;
//       });

//       DocumentSnapshot doc = await database.document(
//         branch: widget.branch,
//         sem: widget.sem,
//         section: widget.section,
//       );
//       Map<String, dynamic>? data = doc.data();
//       // already available data
//       // print(data);
//       //  print(doc.exists);
//       // List lectureDay = data?['${widget.day}'];
//       // print(lectureDay);

//       if (doc.exists) {

//         List lectureDay = data?['${widget.day}'];

//         selectedLecture = lectureDay;
//         print(lectureDay);
//         selectedLecture.add(
//           {
//             'day': '${widget.day}',
//             'date': '${widget.date}',
//             'subName': _subName,
//             'profName': _profName,
//             'subCode': _subCode,
//             'time':
//                 '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
//           },
//         );
//         print('Selected Lecture Day $selectedLecture');
//       } else {
//         selectedLecture.add(
//           {
//             'day': '${widget.day}',
//             'date': '${widget.date}',
//             'subName': _subName,
//             'profName': _profName,
//             'subCode': _subCode,
//             'time':
//                 '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
//           },
//         );
//       }

//       // if (doc.exists) {
//       //   List allLectures = await doc['${widget.day}'];
//       //   print('All Lectres $allLectures');
//       //   selectedLecture = allLectures;
//       //   // selectedLecture = await allLectures['${widget.day}'];
//       //   selectedLecture.add(
//       //     {
//       //       'day': '${widget.day}',
//       //       'date': '${widget.date}',
//       //       'subName': _subName,
//       //       'profName': _profName,
//       //       'subCode': _subCode,
//       //       'time':
//       //           '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
//       //     },
//       //   );
//       // } else {
//       //   selectedLecture.add(
//       //     {
//       //       'day': '${widget.day}',
//       //       'date': '${widget.date}',
//       //       'subName': _subName,
//       //       'profName': _profName,
//       //       'subCode': _subCode,
//       //       'time':
//       //           '${_startingTime?.format(context)}-${_endingTime?.format(context)}',
//       //     },
//       //   );
//       // }
//       // using database class by the help of provider class
//       await database.updateData(
//         branch: widget.branch,
//         sem: widget.sem,
//         section: widget.section,
//         day: widget.day,
//         date: widget.date,
//         subCode: _subCode,
//         subName: _subName,
//         profName: _profName,
//         lecture: selectedLecture,
//       );
//       resetForm();

//       setState(() {
//         _isSubmiting = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.green,
//           content: Text(
//             'Lecture Added',
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(0, 141, 82, 1),
//         centerTitle: true,
//         title: Text('${widget.branch} - ${widget.sem} Sem (${widget.section})'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 20.0),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             TextButton.icon(
//                               onPressed: () => _selectStartingTime(context),
//                               icon: Icon(Icons.timer),
//                               label: Text(
//                                 'Start',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 22.0,
//                                 ),
//                               ),
//                             ),
//                             TextButton.icon(
//                               onPressed: () => _selectEndingTime(context),
//                               icon: Icon(Icons.timer),
//                               label: Text(
//                                 'End',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 22.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             //SizedBox(width: 2.0),
//                             Text(
//                               '${_startingTime?.format(context)}',
//                               style: TextStyle(
//                                 color: Colors.deepOrangeAccent,
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(width: 4.0),
//                             Text(
//                               '${_endingTime?.format(context)}',
//                               style: TextStyle(
//                                 color: Colors.deepOrangeAccent,
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             //SizedBox(width: 2.0),
//                           ],
//                         ),
//                         SizedBox(height: 10.0)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                   vertical: 15.0,
//                 ),
//                 child: TextFormField(
//                   controller: _subCodeController,
//                   key: ValueKey('subCode'),
//                   onSaved: (value) => _subCode = value?.trim().toUpperCase(),
//                   keyboardType: TextInputType.name,
//                   // controller: _emailController,
//                   validator: (value) =>
//                       !(value!.length >= 3) ? 'Invalid Input' : null,
//                   decoration: InputDecoration(
//                     //icon: Icon(Icons.mail),
//                     labelText: 'Subject Code',
//                     hintText: 'Enter subject code',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                   vertical: 15.0,
//                 ),
//                 child: TextFormField(
//                   controller: _subNameController,
//                   key: ValueKey('subName'),
//                   onSaved: (value) => _subName = value?.trim(),
//                   keyboardType: TextInputType.name,
//                   // controller: _emailController,
//                   validator: (value) =>
//                       !(value!.length >= 1) ? 'Invalid Input' : null,
//                   decoration: InputDecoration(
//                     //icon: Icon(Icons.mail),
//                     labelText: 'Subject Name',
//                     hintText: 'Enter subject name',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 25.0,
//                   vertical: 15.0,
//                 ),
//                 child: TextFormField(
//                   controller: _profNameController,
//                   key: ValueKey('profName'),
//                   onSaved: (value) => _profName = value?.trim(),
//                   keyboardType: TextInputType.name,
//                   // controller: _emailController,
//                   validator: (value) =>
//                       !(value!.length >= 3) ? 'Invalid Input' : null,
//                   decoration: InputDecoration(
//                     //icon: Icon(Icons.mail),
//                     labelText: 'Prof Name',
//                     hintText: 'Enter name of proffessor',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (_isSubmiting) CircularProgressIndicator(),
//               if (!_isSubmiting)
//                 ElevatedButton(
//                   onPressed: () => _submit(context),
//                   // onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30.0,
//                       vertical: 10.0,
//                     ),
//                     child: Text('Add Lecture'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // print(lectures
// //     .doc('${widget.branch}')
// //     .collection('${widget.sem}')
// //     .doc('${widget.section}')
// //     .get());
// // print(widget.branch);
// // print(widget.sem);
// // print(widget.section);
// // print(widget.date);
// // print(widget.day);
// // print(selectedTime(context));

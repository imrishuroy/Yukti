import 'package:flutter/material.dart';

class AddAttendaneScreen extends StatefulWidget {
  final String? branch;
  final String? sem;
  final String? enrollNo;
  const AddAttendaneScreen({
    Key? key,
    this.branch,
    this.sem,
    this.enrollNo,
  }) : super(key: key);
  @override
  _AddAttendaneScreenState createState() => _AddAttendaneScreenState();
}

class _AddAttendaneScreenState extends State<AddAttendaneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _subName;
  String? _updateOnDate;
  String? dowloadLink;
  List assignmentsList = [];
  String? _totalAttendance;

  bool _isSubmiting = false;

  List selectedLecture = [];
  final _subCodeController = TextEditingController();
  final _subNameController = TextEditingController();
  final _updateOnDateController = TextEditingController();
  final _totalAttendanceController = TextEditingController();

  void resetForm() async {
    _subNameController.clear();
    _subCodeController.clear();
    _updateOnDateController.clear();
    _totalAttendanceController.clear();
  }

  // void _submit(BuildContext context) async {

  //   final form = _formKey.currentState!;

  //   FocusScope.of(context).unfocus();
  //   if (form.validate()) {
  //     form.save();

  //     setState(() {
  //       _isSubmiting = true;
  //     });

  //     DocumentSnapshot doc = await database.attendanceDocument(
  //       branch: widget.branch,
  //       sem: widget.sem,
  //       enrollNo: widget.enrollNo,
  //     );
  //     Map<String, dynamic>? data = doc.data();
  //     print(data);

  //     await database.updateAttendance(
  //         branch: widget.branch,
  //         sem: widget.sem,
  //         enrollNo: widget.enrollNo,
  //         totalAttendance: int.tryParse(_totalAttendance!));
  //     setState(() {
  //       _isSubmiting = false;
  //     });
  //     //  print(data);

  //     // if (doc.exists) {
  //     //   List alreadyAddedAssignments = data?['assignments'];
  //     //   //   print(assignments);

  //     //   assignmentsList = alreadyAddedAssignments;

  //     //   // print(lectureDay);
  //     //   assignmentsList.add(
  //     //     {
  //     //       'assignmentName': _assignmentName,
  //     //       'subName': _subName,
  //     //       'subCode': _subCode,
  //     //       'link': _downloadLink,
  //     //     },
  //     //   );
  //     //   // print('Selected Lecture Day $selectedLecture');
  //     // } else {
  //     //   selectedLecture.add(
  //     //     {
  //     //       'assignmentName': _assignmentName,
  //     //       'subName': _subName,
  //     //       'subCode': _subCode,
  //     //       'link': _downloadLink,
  //     //     },
  //     //   );
  //     // }

  //     // using database class by the help of provider class
  //     // await database.updateAssignemtData(
  //     //   branch: widget.branch,
  //     //   sem: widget.sem,
  //     //  // section: widget.section,
  //     //   subCode: _subCode,
  //     //   subName: _subName,
  //     //   assignments: assignmentsList,
  //     // );
  //     // resetForm();

  //     // setState(() {
  //     //   _isSubmiting = false;
  //     // });
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(
  //     //     backgroundColor: Colors.green,
  //     //     content: Text(
  //     //       'Assignment Added',
  //     //       textAlign: TextAlign.center,
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.branch);
    print(widget.sem);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('${widget.branch} ${widget.sem}sem - ${widget.enrollNo}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15.0,
                ),
                child: TextFormField(
                  controller: _updateOnDateController,
                  key: const ValueKey('updateOnDate'),
                  onSaved: (value) => _updateOnDate = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Update On',
                    hintText: 'Enter todays date eg 21/03/21',
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
                  controller: _totalAttendanceController,
                  key: const ValueKey('totalAttendance'),
                  onSaved: (value) => _totalAttendance = value?.trim(),
                  keyboardType: TextInputType.number,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.isNotEmpty) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Todal Attendance',
                    hintText: 'Enter total attendance',
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
                  // onPressed: () => _submit(context),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text('Update Attendance'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

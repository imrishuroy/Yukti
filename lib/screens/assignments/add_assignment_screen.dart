import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAssignmentScreen extends StatefulWidget {
  static String routeName = '/add-assignment';
  final String? branch;
  final String? sem;
  final String? section;
  final String? day;

  const AddAssignmentScreen({
    Key? key,
    this.branch,
    this.sem,
    this.section,
    this.day,
  }) : super(key: key);

  @override
  _AddAssignmentScreenState createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  CollectionReference lectures =
      FirebaseFirestore.instance.collection('lecture');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _subCode;
  String? _subName;
  String? _assignmentName;
  String? dowloadLink;
  List assignmentsList = [];
  String? _downloadLink;

  bool _isSubmiting = false;

  List selectedLecture = [];
  final _subCodeController = TextEditingController();
  final _subNameController = TextEditingController();
  final _assignmentNameController = TextEditingController();
  final _downloadLinkNameController = TextEditingController();

  void resetForm() async {
    _subNameController.clear();
    _subCodeController.clear();
    _assignmentNameController.clear();
    _downloadLinkNameController.clear();
  }

  // void _submit(BuildContext context) async {

  //   final form = _formKey.currentState!;

  //   FocusScope.of(context).unfocus();
  //   if (form.validate()) {
  //     form.save();

  //     setState(() {
  //       _isSubmiting = true;
  //     });

  //     DocumentSnapshot doc = await database.assignmentsDocument(
  //       branch: widget.branch,
  //       sem: widget.sem,
  //       section: widget.section,
  //     );
  //     Map<String, dynamic>? data = doc.data();
  //     //  print(data);

  //     if (doc.exists) {
  //       List alreadyAddedAssignments = data?['assignments'];
  //       //   print(assignments);

  //       assignmentsList = alreadyAddedAssignments;

  //       // print(lectureDay);
  //       assignmentsList.add(
  //         {
  //           'assignmentName': _assignmentName,
  //           'subName': _subName,
  //           'subCode': _subCode,
  //           'link': _downloadLink,
  //         },
  //       );
  //       // print('Selected Lecture Day $selectedLecture');
  //     } else {
  //       selectedLecture.add(
  //         {
  //           'assignmentName': _assignmentName,
  //           'subName': _subName,
  //           'subCode': _subCode,
  //           'link': _downloadLink,
  //         },
  //       );
  //     }

  //     // using database class by the help of provider class
  //     await database.updateAssignemtData(
  //       branch: widget.branch,
  //       sem: widget.sem,
  //       section: widget.section,
  //       subCode: _subCode,
  //       subName: _subName,
  //       assignments: assignmentsList,
  //     );
  //     resetForm();

  //     setState(() {
  //       _isSubmiting = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.green,
  //         content: Text(
  //           'Assignment Added',
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // print(widget.branch);
    // print(widget.section);
    // print(widget.sem);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('${widget.branch} - ${widget.sem} Sem (${widget.section})'),
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
                      // !(value!.length >= 1) ? 'Invalid Input' : null,
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
                  controller: _assignmentNameController,
                  key: ValueKey('assignmentName'),
                  onSaved: (value) => _assignmentName = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Assignment Name',
                    hintText: 'Enter name of assignment',
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
                  controller: _downloadLinkNameController,
                  key: const ValueKey('downloadLink'),
                  onSaved: (value) => _downloadLink = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Download Link',
                    hintText: 'Enter download link',
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
                  // onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text('Add Assignment'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

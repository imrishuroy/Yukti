import 'package:admin_yukti/widgets/show_mesage.dart';

import '/models/assignment.dart';
import '/repositories/firestore/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

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

  // DateTime? _assignmentDate;
  String? _assignmentDate;

  void resetForm() async {
    _subNameController.clear();
    _subCodeController.clear();
    _assignmentNameController.clear();
    _downloadLinkNameController.clear();
    _assignmentDate = null;
  }

  Future<void> _selectAssignmentDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2021, 12, 31),
    );

    if (pickedDate != null) {
      print('Date Picked ${DateFormat.yMMMMEEEEd().format(pickedDate)}');

      setState(() {
        // _assignmentDate = pickedDate;
        _assignmentDate = DateFormat.yMMMMEEEEd().format(pickedDate);
      });
    }
  }

  void _submit(BuildContext context) async {
    final _firestoreRepo = context.read<FirestoreRepository>();

    final form = _formKey.currentState!;

    FocusScope.of(context).unfocus();
    if (form.validate()) {
      form.save();

      setState(() {
        _isSubmiting = true;
      });

      if (_assignmentDate == null) {
        ShowMessage.showErrorMessage(context,
            message: 'Please pick assignment date ');
      } else {
        if (widget.branch != null &&
            widget.sem != null &&
            widget.section != null &&
            _assignmentDate != null) {
          final id = const Uuid().v4();
          final assignment = Assignment(
            assignmentId: id,
            date: _assignmentDate,
            name: _assignmentName,
            subCode: _subCode,
            subName: _subName,
            link: _downloadLink,
          );

          await _firestoreRepo.addAssignments(
            branch: widget.branch!,
            sem: widget.sem!,
            section: widget.section!,
            assignment: assignment,
          );

          resetForm();
        } else {
          ShowMessage.showErrorMessage(context,
              message: 'Please fill all the details to continue ');
        }
      }

      setState(() {
        _isSubmiting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Assignment Added',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.branch);
    print(widget.section);
    print(widget.sem);
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
              TextButton.icon(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 19.0)),
                onPressed: _selectAssignmentDate,
                icon: const Icon(
                  Icons.calendar_today,
                  size: 19.0,
                ),
                label: const Text('Pick Date'),
              ),
              const SizedBox(height: 5.0),
              if (_assignmentDate != null)
                Text(
                  'Assignment Date - $_assignmentDate',
                  style: const TextStyle(fontSize: 17.0),
                ),
              const SizedBox(height: 10.0),
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
                  key: const ValueKey('assignmentName'),
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
                  onPressed: () => _submit(context),

                  // onPressed: () {},
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

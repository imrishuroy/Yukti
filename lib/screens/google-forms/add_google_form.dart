import 'package:admin_yukti/models/google_form.dart';
import 'package:admin_yukti/widgets/show_mesage.dart';
import '/repositories/firestore/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddGoogleForm extends StatefulWidget {
  static String routeName = '/add-form';
  final String? branch;
  final String? sem;
  final String? section;

  const AddGoogleForm({
    Key? key,
    this.branch,
    this.sem,
    this.section,
  }) : super(key: key);

  @override
  _AddGoogleFormState createState() => _AddGoogleFormState();
}

class _AddGoogleFormState extends State<AddGoogleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _formTitle;
  String? _formLink;

  bool _isSubmiting = false;

  final _titleController = TextEditingController();
  final _linkController = TextEditingController();

  void resetForm() async {
    _linkController.clear();
    _titleController.clear();
  }

  void _submit(BuildContext context) async {
    try {
      final _firestoreRepo = context.read<FirestoreRepository>();

      final form = _formKey.currentState!;

      FocusScope.of(context).unfocus();
      if (form.validate()) {
        form.save();

        setState(() {
          _isSubmiting = true;
        });

        if (widget.branch != null &&
            widget.sem != null &&
            widget.section != null) {
          final id = const Uuid().v4();

          final form = GoogleForm(
            id: id,
            title: _formTitle,
            link: _formLink,
          );

          await _firestoreRepo.addGoogleForm(
            branch: widget.branch!,
            sem: widget.sem!,
            section: widget.section!,
            form: form,
          );

          resetForm();
        } else {
          ShowMessage.showErrorMessage(context,
              message: 'Please fill all the details to continue ');
        }

        setState(() {
          _isSubmiting = false;
        });
        ShowMessage.showSuccussMessage(context, message: 'Form added');
      }
    } catch (error) {
      print('Error submitting google form ${error.toString()}}');
      setState(() {
        _isSubmiting = false;
      });
      ShowMessage.showErrorMessage(context,
          message: 'Someting went wrong, try again');
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
              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //       textStyle: const TextStyle(fontSize: 19.0)),
              //   onPressed: _selectAssignmentDate,
              //   icon: const Icon(
              //     Icons.calendar_today,
              //     size: 19.0,
              //   ),
              //   label: const Text('Pick Date'),
              // ),
              // const SizedBox(height: 5.0),
              // if (_assignmentDate != null)
              //   Text(
              //     'Assignment Date - $_assignmentDate',
              //     style: const TextStyle(fontSize: 17.0),
              //   ),
              // const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15.0,
                ),
                child: TextFormField(
                  controller: _titleController,
                  key: const ValueKey('form-title'),
                  onSaved: (value) => _formTitle = value?.trim().toUpperCase(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      !(value!.length >= 3) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Form Title',
                    hintText: 'Enter form title',
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
                  controller: _linkController,
                  key: const ValueKey('formDescription'),
                  onSaved: (value) => _formLink = value?.trim(),
                  keyboardType: TextInputType.name,
                  // controller: _emailController,
                  validator: (value) =>
                      // !(value!.length >= 1) ? 'Invalid Input' : null,
                      !(value!.isNotEmpty) ? 'Invalid Input' : null,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.mail),
                    labelText: 'Form Link',
                    hintText: 'Enter form link',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              if (_isSubmiting) const CircularProgressIndicator(),
              if (!_isSubmiting)
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text('Add Form'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/respositories/user/user_repository.dart';

enum Section { a, b }

class AddProfileScreen extends StatefulWidget {
  static String routeName = '/add-profile';

  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AddProfileScreen> {
  String documentId() => DateTime.now().toIso8601String();
  final _formKey = GlobalKey<FormState>();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('userImages');
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;

  Section? _section = Section.a;

  File? _image;
  final picker = ImagePicker();
  String? _name;
  String? _fatherName;
  String? _motherName;
  String? _mobileNo;
  String? _enrollNo;

  bool _isSubmiting = false;
  String branchValue = 'CSE';
  String semValue = '2nd';

  void _submit(BuildContext context) async {
    final userRepo = context.read<UserRepository>();
    final userId = context.read<AuthBloc>().state.user?.uid;
    final form = _formKey.currentState!;
    // final database = Provider.of<DataBase>(context, listen: false);
    FocusScope.of(context).unfocus();
    if (form.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Select a image for upload',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else {
        form.save();
        setState(() {
          _isSubmiting = true;
        });

        final firebaseStorage = FirebaseStorage.instance;
        // final reference =

        //     // adding new path
        //     FirebaseFirestore.instance.doc('users/$userId');
        // new data
        //  FirebaseFirestore.instance.doc('users/$uid/');
        final ref =
            firebaseStorage.ref().child('user_image').child('$userId.jpg');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();

        final appUser = AppUser(
          uid: userId,
          name: _name,
          enrollNo: _enrollNo,
          sem: semValue,
          fatherName: _fatherName,
          mobileNo: _mobileNo,
          motherName: _motherName,
          photUrl: imageUrl,
          section: _section == Section.a ? 'A' : 'B',
          branch: branchValue,
        );

        await userRepo
            .addUserProfile(user: appUser)
            .then((value) => Navigator.of(context).pop());
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      // for reducing the quality of image
      imageQuality: 20,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthServices>(context, listen: false);
    // final database = Provider.of<DataBase>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Your Profile'),
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(170.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: _image == null ? null : FileImage(_image!),
                child: _image == null
                    ? IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30.0,
                        ),
                        onPressed: () => _pickImage(),
                      )
                    : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 27.0,
                      color: Color.fromRGBO(255, 203, 0, 1),
                    ),
                    onPressed: _image != null ? () => _pickImage() : null,
                  ),
                  const SizedBox(width: 5.0)
                ],
              ),
            ],
          ),
        ),
      ),
      body: _isSubmiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                //  alignment: Alignment.topCenter,
                                child: DropdownButton<String>(
                                  value: branchValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(0, 141, 82, 1),
                                  ),
                                  underline: Container(
                                    height: 3,
                                    color: const Color.fromRGBO(255, 203, 0, 1),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      branchValue = newValue!;
                                      //   print(branchValue);
                                    });
                                  },
                                  items: <String>['CSE', 'IT', 'ECE', 'CIVIL']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                //   alignment: Alignment.topCenter,
                                child: DropdownButton<String>(
                                  value: semValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                    fontSize: 19.0,
                                    color: Color.fromRGBO(0, 141, 82, 1),
                                  ),
                                  underline: Container(
                                    height: 3,
                                    color: const Color.fromRGBO(255, 203, 0, 1),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        semValue = newValue!;
                                        //  print(semValue);
                                      },
                                    );
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('A'),
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
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('B'),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 15.0,
                      ),
                      child: TextFormField(
                        key: const ValueKey('name'),
                        onSaved: (value) => _name = value?.trim(),
                        keyboardType: TextInputType.name,
                        // controller: _emailController,
                        validator: (value) =>
                            !(value!.length >= 3) ? 'Invalid Input' : null,
                        decoration: const InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Your Name',
                          hintText: 'Enter your full name',
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
                        key: const ValueKey('enrollNo'),
                        onSaved: (value) =>
                            _enrollNo = value?.trim().toUpperCase(),
                        keyboardType: TextInputType.text,
                        // controller: _emailController,
                        validator: (value) =>
                            !(value!.length >= 3) ? 'Invalid Input' : null,
                        decoration: const InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Enrollment Number',
                          hintText: 'For eg- 0105CS191091',
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
                        key: const ValueKey('fathers-name'),
                        onSaved: (value) => _fatherName = value?.trim(),
                        keyboardType: TextInputType.name,
                        // controller: _emailController,
                        validator: (value) =>
                            !(value!.length >= 3) ? 'Invalid Input' : null,
                        decoration: const InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Father\'s Name',
                          hintText: 'Enter your father name.',
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
                        key: const ValueKey('mothers-name'),
                        onSaved: (value) => _motherName = value?.trim(),
                        keyboardType: TextInputType.name,
                        // controller: _emailController,
                        validator: (value) =>
                            !(value!.length >= 3) ? 'Invalid Input' : null,
                        decoration: const InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Mother\'s Name',
                          hintText: 'Enter your mother name.',
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
                        key: const ValueKey('phone-no'),
                        onSaved: (value) => _mobileNo = value?.trim(),
                        keyboardType: TextInputType.name,
                        // controller: _emailController,
                        validator: (value) =>
                            !(value!.length >= 10) ? 'Invalid Input' : null,
                        decoration: const InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Moblie No.',
                          hintText: 'Enter your mobile number.',
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
                          horizontal: 60, vertical: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () {
                          _submit(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

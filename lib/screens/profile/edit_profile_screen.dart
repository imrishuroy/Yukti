import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukti/respositories/user/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final usersRef = FirebaseFirestore.instance.collection('users');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  bool _isLoading = false;
  AppUser? user;
  bool _nameValid = true;
  bool _fatherNameValid = true;
  bool _motherNameValid = true;
  bool _mobileNoValid = true;
  final firebaseStorage = FirebaseStorage.instance;
  bool _updatingProfile = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? imageUrl;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
      maxHeight: 675,
      maxWidth: 960,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    setState(() {
      _isLoading = true;
    });
    // getting current user document
    final _userId = context.read<AuthBloc>().state.user?.uid;

    final userRepo = context.read<UserRepository>();

    AppUser? user = await userRepo.getUserById(userId: _userId);

    // print(user.photUrl); // hurray it works
    _nameController.text = user?.name ?? '';
    _fatherNameController.text = user?.fatherName ?? '';
    _motherNameController.text = user?.motherName ?? '';
    _mobileNoController.text = user?.mobileNo ?? '';

    imageUrl = user?.photUrl;

    setState(() {
      _isLoading = false;
    });
  }

  updateProfileData() async {
    final userId = context.read<AuthBloc>().state.user?.uid;
    setState(() {
      _nameController.text.trim().length < 3 || _nameController.text.isEmpty
          ? _nameValid = false
          : _nameValid = true;

      _fatherNameController.text.trim().length < 3 ||
              _fatherNameController.text.isEmpty
          ? _fatherNameValid = false
          : _fatherNameValid = true;

      _motherNameController.text.trim().length < 3 ||
              _motherNameController.text.isEmpty
          ? _motherNameValid = false
          : _motherNameValid = true;

      _mobileNoController.text.trim().length < 10 ||
              _mobileNoController.text.isEmpty
          ? _mobileNoValid = false
          : _mobileNoValid = true;
    });

    // uploading to firebase storage

    if (_image != null) {
      final ref =
          firebaseStorage.ref().child('user_image').child('$userId.jpg');
      await ref.putFile(_image!);
      imageUrl = await ref.getDownloadURL();
    }

    if (_nameValid && _fatherNameValid && _motherNameValid && _mobileNoValid) {
      setState(() {
        _updatingProfile = true;
      });
      usersRef.doc(userId).update({
        'name': _nameController.text,
        'father_name': _fatherNameController.text,
        'mother_name': _motherNameController.text,
        'mobile_no': _mobileNoController.text,
        'image_url': imageUrl,
      });
      setState(() {
        _updatingProfile = false;
      });
      SnackBar snackbar = const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Succussfully updated your profle',
          textAlign: TextAlign.center,
        ),
      );
      // _scaffoldKey.currentState!.showSnackBar(snackbar);

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.database.id);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17.0,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 53.0),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 60.0,
                            backgroundImage: (_image == null
                                ? NetworkImage(imageUrl!)
                                : FileImage(_image!)) as ImageProvider<Object>?,
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            icon: const Icon(
                              Icons.insert_photo,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            onPressed: getImage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                            TextField(
                              style: const TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              controller: _nameController,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                    width: 1.7,
                                  ),
                                ),
                                hintText: 'Update your name',
                                errorText:
                                    _nameValid ? null : 'Name is too short',
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              'Father\'s Name',
                              style: TextStyle(
                                color: Colors.orange,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _fatherNameController,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                    width: 1.7,
                                  ),
                                ),
                                hintText: 'Update your name',
                                errorText: _nameValid
                                    ? null
                                    : 'Father name is too short',
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              'Mother Name',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _motherNameController,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                    width: 1.7,
                                  ),
                                ),
                                hintText: 'Update your name',
                                errorText:
                                    _nameValid ? null : 'Name is too short',
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              'Mobile Number',
                              style: TextStyle(
                                color: Colors.orange,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _mobileNoController,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                    width: 1.7,
                                  ),
                                ),
                                hintText: 'Update your number',
                                errorText:
                                    _nameValid ? null : 'Name is too short',
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            if (_updatingProfile)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            if (!_updatingProfile)
                              Center(
                                child: ElevatedButton(
                                  onPressed: updateProfileData,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.0,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:talent_tree/utils/pallete.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  bool isMale = false;
  bool isFemale = false;
  String _mobNo = '';
  String _altMobNo = '';
  String _dob = '';
  String _state = '';
  String _district = '';
  String _city = '';
  String _height = '';
  String _expirience = '';

  File? _audioFile;
  File? _videoFile;
  File? _imageFile;

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _audioFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        label: Text("Email"),
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Gender",
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: isMale,
                            onChanged: (bool? value) {
                              setState(() {
                                isMale = value!;
                                isFemale = !value;
                              });
                            },
                          ),
                          const Text('Male'),
                          Checkbox(
                            value: isFemale,
                            onChanged: (bool? value) {
                              setState(() {
                                isFemale = value!;
                                isMale = !value;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("Email Address"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("Mobile Number"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile no';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _mobNo = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("Alternative No"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _altMobNo = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("DOB"),
                      hintText: "DD/MM/YYYY",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _dob = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("State"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _state = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("District"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _district = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("City"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _city = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("Height"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _height = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      label: Text("Experience"),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 10.0),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _expirience = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text("District"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onSaved: (value) {
                      _district = value!;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.audiotrack),
                    title: Text('Audio'),
                    subtitle: _audioFile == null
                        ? Text('No audio selected')
                        : Text(_audioFile!.path),
                    trailing: IconButton(
                      icon: Icon(Icons.file_upload),
                      onPressed: _pickAudio,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.video_library),
                    title: Text('Video'),
                    subtitle: _videoFile == null
                        ? Text('No video selected')
                        : Text(_videoFile!.path),
                    trailing: IconButton(
                      icon: Icon(Icons.file_upload),
                      onPressed: _pickVideo,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Image'),
                    subtitle: _imageFile == null
                        ? Text('No image selected')
                        : Text(_imageFile!.path),
                    trailing: IconButton(
                      icon: Icon(Icons.file_upload),
                      onPressed: _pickImage,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 25,vertical: 10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Do something with _name and _email
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

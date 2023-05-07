import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:talent_tree/pages/login_screen.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullname = '';
  String _email = '';
  bool isMale = false;
  bool isFemale = false;
  String _mobNo = '';
  String _altMobNo = '';
  String _dob = '';
  String _state = '';
  String _district = '';
  String _city = '';
  String _currentCity = '';
  String _height = '';
  String _expirience = '';

  File? _audioFile;
  File? _videoFile;
  File? _imageFile;
  File? _documentFile;

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

  Future<void> _pickDocs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _documentFile = File(result.files.single.path!);
      });
    }
  }

  void register(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');
      if (token == null) {
        // Handle case where user is not authenticated
        // Show login screen
        showSnackBar(context, 'Logged Out!');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        return;
      }

      const String url = '${Constants.baseURL}register';
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      };

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['fullName'] = _fullname;
      request.fields['gender'] = isMale ? 'male' : 'female';
      request.fields['email'] = _email;
      request.fields['mobile'] = _mobNo;
      request.fields['mobileAlt'] = _altMobNo;
      request.fields['dob'] = _dob;
      request.fields['state'] = _state;
      request.fields['district'] = _district;
      request.fields['city'] = _city;
      request.fields['currentCity'] = _currentCity;
      request.fields['height'] = _height;
      request.fields['experience'] = _expirience;

      // if (_audioFile != null) {
      //   final audioStream =
      //       http.ByteStream(Stream.castFrom(_audioFile!.openRead()));
      //   final audioLength = await _audioFile!.length();
      //   final audioMultipartFile = http.MultipartFile(
      //       'audio', audioStream, audioLength,
      //       filename: path.basename(_audioFile!.path));
      //   request.files.add(audioMultipartFile);
      // }

      // if (_videoFile != null) {
      //   final videoStream =
      //       http.ByteStream(Stream.castFrom(_videoFile!.openRead()));
      //   final videoLength = await _videoFile!.length();
      //   final videoMultipartFile = http.MultipartFile(
      //       'video', videoStream, videoLength,
      //       filename: path.basename(_videoFile!.path));
      //   request.files.add(videoMultipartFile);
      // }

      // if (_imageFile != null) {
      //   final imageStream =
      //       http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
      //   final imageLength = await _imageFile!.length();
      //   final imageMultipartFile = http.MultipartFile(
      //       'image', imageStream, imageLength,
      //       filename: path.basename(_imageFile!.path));
      //   request.files.add(imageMultipartFile);
      // }

      // if (_documentFile != null) {
      //   final documentStream =
      //       http.ByteStream(Stream.castFrom(_documentFile!.openRead()));
      //   final documentLength = await _documentFile!.length();
      //   final documentMultipartFile = http.MultipartFile(
      //       'docs', documentStream, documentLength,
      //       filename: path.basename(_documentFile!.path));
      //   request.files.add(documentMultipartFile);
      // }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful registration
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('registered', true);
        showSnackBar(context, 'Registered Successfully!');
        Navigator.of(context).pop();
      } else {
        // Handle unsuccessful registration
        showSnackBar(context, 'Failed to register');
      }
    } catch (error) {
      // Handle error
      showSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Registration"),
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
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        label: Text("Full Name*"),
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fullname = value!;
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
                          "Gender*",
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("Email Address*"),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("Mobile Number*"),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("DOB*"),
                      hintText: "DD/MM/YYYY",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter dob';
                      }
                      return null;
                    },
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("State*"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("District*"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your district';
                      }
                      return null;
                    },
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("City*"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("Current City*"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current city';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _currentCity = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      label: Text("Height*"),
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
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
                  ListTile(
                    leading: const Icon(Icons.audiotrack),
                    title: const Text('Audio'),
                    subtitle: _audioFile == null
                        ? const Text('No audio selected')
                        : Text(_audioFile!.path),
                    trailing: IconButton(
                      icon: const Icon(Icons.file_upload),
                      onPressed: _pickAudio,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_library),
                    title: const Text('Video'),
                    subtitle: _videoFile == null
                        ? const Text('No video selected')
                        : Text(_videoFile!.path),
                    trailing: IconButton(
                      icon: const Icon(Icons.file_upload),
                      onPressed: _pickVideo,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Image'),
                    subtitle: _imageFile == null
                        ? const Text('No image selected')
                        : Text(_imageFile!.path),
                    trailing: IconButton(
                      icon: const Icon(Icons.file_upload),
                      onPressed: _pickImage,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: Text('File & Docs'),
                    subtitle: _imageFile == null
                        ? const Text('No documents selected')
                        : Text(_imageFile!.path),
                    trailing: IconButton(
                      icon: const Icon(Icons.file_upload),
                      onPressed: _pickDocs,
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
                          const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Do something with _name and _email
                        register(context);
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

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_tree/models/user.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:talent_tree/services/auth_services.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late User user;
  final AuthService authSerivce = AuthService();

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    fetchData();
  }

  Future<void> fetchData() async {
    try {} catch (e) {
      print('Failed to fetch category image');
    }
  }

  Future getImage() async {
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

  Future<void> saveChanges() async {
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('x-auth-token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token!
    };
    // Prepare the data to send in the request body
    Map<String, String> data = {
      'name': newName,
    };

    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Constants.baseURL}update-profile'),
    );
    request.headers.addAll(headers);
    // Add the image file to the request
    if (_imageFile != null) {
      request.files.add(
        http.MultipartFile(
          'image',
          _imageFile!.readAsBytes().asStream(),
          _imageFile!.lengthSync(),
          filename: _imageFile!.path.split('/').last,
        ),
      );
    }

    // Add the data as fields to the request
    request.fields.addAll(data);

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Request successful
      showSnackBar(context, "Profile Updated Successfully");
      authSerivce.getUserData(context);
      Navigator.pop(context);
    } else {
      // Request failed
      print('Failed to save changes. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    ImageProvider<Object>? imageProvider;

    if (_imageFile != null) {
      // Display the selected image
      imageProvider = FileImage(_imageFile!);
    } else if (user.profileImage.isNotEmpty) {
      // Display the user's profile image from network
      imageProvider =
          NetworkImage('${Constants.baseURL}files/${user.profileImage}');
    } else {
      // Display a default local image
      imageProvider = AssetImage('assets/images/logo.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: getImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: imageProvider,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: getImage,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: _emailController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: saveChanges,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_tree/pages/login_screen.dart';
import 'package:talent_tree/pages/splash_screen.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();

  List<String> states = [
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Ladakh",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];
  List<String> cities = [
    "Abohar",
    "Agartala",
    "Agra",
    "Ahmedabad",
    "Ahmednagar",
    "Aizawl",
    "Ajmer",
    "Akola",
    "Alappuzha",
    "Aligarh",
    "Allahabad",
    "Alwar",
    "Ambala",
    "Ambarnath",
    "Amravati",
    "Amritsar",
    "Anand",
    "Anantapur",
    "Anantnag",
    "Arrah",
    "Asansol",
    "Aurangabad",
    "Avadi",
    "Bally",
    "Bangalore",
    "Baranagar",
    "Barasat",
    "Bardhaman",
    "Bareilly",
    "Bathinda",
    "Belgaum",
    "Bellary",
    "Berhampore",
    "Bettiah",
    "Bhagalpur",
    "Bhalswa Jahangir Pur",
    "Bharatpur",
    "Bhatpara",
    "Bhavnagar",
    "Bhilai",
    "Bhilwara",
    "Bhimavaram",
    "Bhind",
    "Bhiwandi",
    "Bhiwani",
    "Bhopal",
    "Bhubaneswar",
    "Bhusawal",
    "Bidar",
    "Bidhannagar",
    "Bihar Sharif",
    "Bijapur",
    "Bikaner",
    "Bilaspur",
    "Bokaro",
    "Bongaigaon",
    "Bulandshahr",
    "Burhanpur",
    "Buxar",
    "Chandigarh",
    "Chandrapur",
    "Chapra",
    "Chennai",
    "Chinsurah",
    "Chittoor",
    "Coimbatore",
    "Cooch Behar",
    "Cuttack",
    "Danapur",
    "Darbhanga",
    "Darjiling",
    "Davanagere",
    "Dehradun",
    "Dehri",
    "Delhi",
    "Deoghar",
    "Dewas",
    "Dhanbad",
    "Dharamshala",
    "Dhule",
    "Dibrugarh",
    "Dimapur",
    "Dindigul",
    "Durg",
    "Durgapur",
    "Eluru",
    "Erode",
    "Etawah",
    "Faizabad",
    "Faridabad",
    "Faridkot",
    "Farrukhabad",
    "Fatehpur",
    "Firozabad",
    "Gandhidham",
    "Gandhinagar",
    "Gangapur City",
    "Gangavathi",
    "Gangtok",
    "Gaya",
    "Ghaziabad",
    "Giridih",
    "Godhra",
    "Gorakhpur",
    "Gulbarga",
    "Guna",
    "Guntakal",
    "Guntur",
    "Gurgaon",
    "Guwahati",
    "Gwalior",
    "Hajipur",
    "Haldia",
    "Haldwani",
    "Hapur",
    "Hardoi",
    "Haridwar",
    "Hazaribagh",
    "Hindupur",
    "Hisar",
    "Hospet",
    "Howrah",
    "Hubli-Dharwad",
    "Hugli-Chinsurah",
    "Hyderabad",
    "Ichalkaranji",
    "Imphal",
    "Indore",
    "Jabalpur",
    "Jaipur",
    "Jalandhar",
    "Jalgaon",
    "Jalna",
    "Jamalpur",
    "Jammu",
    "Jamnagar",
    "Jamshedpur",
    "Jaunpur",
    "Jehanabad",
    "Jhansi",
    "Jhunjhunu",
    "Jodhpur",
    "Junagadh",
    "Kadapa",
    "Kadiri",
    "Kagaznagar",
    "Kakinada",
    "Kalol",
    "Kalyan-Dombivli",
    "Kamarhati",
    "Kanhangad",
    "Kanpur",
    "Kapra",
    "Karaikudi",
    "Karawal Nagar",
    "Karimnagar",
    "Karnal",
    "Karur",
    "Karwar",
    "Kasaragod",
    "Kashipur",
    "Katihar",
    "Katni",
    "Kavali",
    "Khammam",
    "Khandwa",
    "Khanna",
    "Kharagpur",
    "Khora, Ghaziabad",
    "Kochi",
    "Kolhapur",
    "Kolkata",
    "Kollam",
    "Korba",
    "Kota",
    "Kothagudem",
    "Kottayam",
    "Kovilpatti",
    "Kozhikode",
    "Krishnanagar",
    "Kulti",
    "Kumbakonam",
    "Kurnool",
    "Lalitpur",
    "Latur",
    "Loni",
    "Lucknow",
    "Ludhiana",
    "Machilipatnam",
    "Madanapalle",
    "Madurai",
    "Mahbubnagar",
    "Mahesana",
    "Malappuram",
    "Malegaon",
    "Malerkotla",
    "Malkajgiri",
    "Mandi",
    "Mandsaur",
    "Mangalore",
    "Mango",
    "Mathura",
    "Mau",
    "Meerut",
    "Mehsana",
    "Miryalaguda",
    "Mirzapur",
    "Mira-Bhayandar",
    "Moradabad",
    "Morbi",
    "Morena",
    "Motihari",
    "Mumbai",
    "Munger",
    "Muzaffarnagar",
    "Muzaffarpur",
    "Mysore",
    "Nabadwip",
    "Nadiad",
    "Nagaon",
    "Nagapattinam",
    "Nagercoil",
    "Nagpur",
    "Naihati",
    "Nalgonda",
    "Nanded",
    "Nandyal",
    "Nangloi Jat",
    "Narasaraopet",
    "Nashik",
    "Navi Mumbai",
    "Nellore",
    "New Delhi",
    "Nizamabad",
    "Noida",
    "North Barrackpore",
    "North Dumdum",
    "Ongole",
    "Orai",
    "Ozhukarai",
    "Pali",
    "Pallavaram",
    "Panchkula",
    "Panihati",
    "Panipat",
    "Panvel",
    "Parbhani",
    "Patiala",
    "Patna",
    "Phagwara",
    "Pimpri-Chinchwad",
    "Pondicherry",
    "Port Blair",
    "Proddatur",
    "Pudukkottai",
    "Pune",
    "Purnia",
    "Purulia",
    "Raebareli",
    "Raichur",
    "Raiganj",
    "Raigarh",
    "Raipur",
    "Rajahmundry",
    "Rajapalayam",
    "Rajendranagar",
    "Rajkot",
    "Rajpur Sonarpur",
    "Ramagundam",
    "Rampur",
    "Rampur Hat",
    "Ranaghat",
    "Ranchi",
    "Ranip",
    "Ranipet",
    "Ratlam",
    "Raurkela",
    "Rewa",
    "Rohtak",
    "Roorkee",
    "Rourkela",
    "Rudrapur",
    "Sagar",
    "Saharanpur",
    "Salem",
    "Sambalpur",
    "Sambhal",
    "Sangli",
    "Sangrur",
    "Satara",
    "Satna",
    "Secunderabad",
    "Serampore",
    "Shahjahanpur",
    "Shimla",
    "Shimoga",
    "Shivamogga",
    "Shivpuri",
    "Sikar",
    "Silchar",
    "Siliguri",
    "Singrauli",
    "Sirsa",
    "Sirsi",
    "Sitapur",
    "Siwan",
    "Solapur",
    "Sonipat",
    "South Dumdum",
    "Sri Ganganagar",
    "Srikakulam",
    "Srinagar",
    "Sultan Pur Majra",
    "Sultanpur",
    "Surat",
    "Surendranagar Dudhrej",
    "Suryapet",
    "Tadepalligudem",
    "Tadipatri",
    "Tenali",
    "Tezpur",
    "Thane",
    "Thanjavur",
    "Theni Allinagaram",
    "Thiruvananthapuram",
    "Thoothukudi",
    "Thrissur",
    "Tinsukia",
    "Tiruchchirappalli",
    "Tiruchirappalli",
    "Tirunelveli",
    "Tirupati",
    "Tiruppur",
    "Tiruvannamalai",
    "Tiruvottiyur",
    "Titagarh",
    "Tohana",
    "Tonk",
    "Tumkur",
    "Udaipur",
    "Udgir",
    "Udupi",
    "Ujjain",
    "Ulhasnagar",
    "Unnao",
    "Uttarpara Kotrung",
    "Vadodara",
    "Valsad",
    "Varanasi",
    "Vasai-Virar",
    "Vellore",
    "Veraval",
    "Vidisha",
    "Vijayawada",
    "Vijayanagaram",
    "Visakhapatnam",
    "Vizianagaram",
    "Warangal",
    "Wardha",
    "Yamunanagar",
    "Yavatmal",
    "Yelahanka",
    "Zirakpur"
  ];

  String _fullname = '';
  String _email = '';
  bool isMale = false;
  bool isFemale = false;
  String _mobNo = '';
  String _altMobNo = '';
  String _dob = '';
  String? _state;
  String? _city = '';
  String? _currentCity = '';
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
      request.fields['state'] = _state!;
      request.fields['city'] = _city!;
      request.fields['currentCity'] = _currentCity!;
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SplashScreen()),
          (route) => false,
        );
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
                  TextField(
                    // Editing controller of this TextField
                    decoration: const InputDecoration(
                      icon:
                          Icon(Icons.calendar_today), // Icon of the text field
                      labelText: "Enter DOB*", // Label text of the field
                    ),
                    readOnly:
                        true, // Set it to true, so the user cannot edit the text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          _dob = formattedDate;
                        });
                      }
                    },
                    controller: TextEditingController(
                        text: _dob), // Set the text to _dob
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    // value: _state,
                    hint: Text('Select a state*'),
                    onChanged: (value) {
                      setState(() {
                        _state = value!;
                        _city = null; // Reset the selected city
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                    items: states.map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    // value: _city,
                    hint: Text('Select a city*'),
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                    items: cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    // value: _city,
                    hint: Text('Select Current city*'),
                    onChanged: (value) {
                      setState(() {
                        _currentCity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select current city';
                      }
                      return null;
                    },
                    items: cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
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
                    title: const Text('File & Docs'),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_tree/services/auth_services.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  final String password;
  final String outlet;

  const OTPScreen({
    Key? key,
    required this.mobile,
    required this.password,
    required this.outlet,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String otp;
  late List<TextEditingController> _otpControllers;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(
      6,
      (_) => TextEditingController(),
    );

    sendSMS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => _buildOtpBox(_otpControllers[index], index),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_validateInput()) {
                _verifyOtp();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please enter the complete OTP.'),
                  ),
                );
              }
            },
            child: const Text('Verify OTP'),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: sendSMS,
            child: const Text('Resend OTP'),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(TextEditingController controller, int index) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: TextFormField(
        controller: controller,
        autofocus: index == 0,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }

  String _generateRandomOtp() {
    return (100000 + DateTime.now().millisecond % 900000).toString();
  }

  bool _validateInput() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _verifyOtp() {
    String enteredOtp = _otpControllers.fold('', (value, controller) => value + controller.text);

    if (otp == enteredOtp) {
      print(widget.mobile);
      if (widget.outlet == 'login') {
        authService.siginUser(context: context, mobile: widget.mobile, password: widget.password);
      } else if (widget.outlet == 'register') {
        authService.signUpUser(context: context, mobile: widget.mobile, password: widget.password, name: '');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content:  Text('Invalid OTP. Please try again.'),
        ),
      );
    }
  }

  void sendSMS() async {
    try {
      otp = _generateRandomOtp();
      await _sendOtpViaSMS(otp, widget.mobile);
    } catch (error) {
      print('Error sending OTP: $error');
      // Handle the error (e.g., show an error message)
    }
  }

  Future<void> _sendOtpViaSMS(String otp, String mobile) async {
    String senderId = 'TLNTRE';
    String templateId = '1207168569170029235';
    String username = 'talenttree';
    String apiKey = 'F97A2-4FC00';
    String uri = 'http://www.alots.in/sms-panel/api/http/index.php';

    String msg = 'Please use $otp as OTP to log on to Talenttree.';

    // Prepare the data for the GET request
    Map<String, String> data = {
      'username': username,
      'apikey': apiKey,
      'apirequest': 'Text',
      'sender': senderId,
      'route': 'TRANS',
      'format': 'JSON',
      'message': msg,
      'mobile': mobile,
      'TemplateID': templateId,
    };

    // Build the URL with the data
    Uri url = Uri.parse('$uri?' + Uri(queryParameters: data).query);

    // Use http package to make the GET request
    http.Response response = await http.get(url);
    Map<String, dynamic> responseData = jsonDecode(response.body);

    print('Response: ${responseData}');

    if(responseData != null && responseData['status']=="success"){
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content:  Text('Otp Sent To Your Mobile No'),
        ),
      );
    }
  }
}

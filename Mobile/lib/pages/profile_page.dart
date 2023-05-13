import 'package:flutter/material.dart';
import 'package:talent_tree/pages/login_screen.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:talent_tree/services/auth_services.dart';
import 'package:talent_tree/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/web.jpeg'),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ListTile(
                leading: Icon(Icons.video_collection),
                title: Text(
                  "My Courses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.subscriptions),
                title: Text(
                  "My Subscriptions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.payment),
                title: Text(
                  "My Payments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade900),
                ),
                onPressed: () {
                  showSnackBar(context, 'Logged Out Successfully!');
                  authService.signOut(context);
                },
                label: const Text("Logout",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ],
          )
        ],
      ),
    );
  }
}

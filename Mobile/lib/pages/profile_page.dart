import 'package:flutter/material.dart';
import 'package:talent_tree/pages/edit_profile.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:talent_tree/services/auth_services.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _showAboutUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AboutUsModalContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profileImage != ""
                      ? NetworkImage(
                          '${Constants.baseURL}files/${user.profileImage}')
                      : AssetImage('assets/images/logo.png')
                          as ImageProvider<Object>,
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ListTile(
                    leading: Icon(Icons.video_collection),
                    title: Text(
                      "My Courses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  const ListTile(
                    leading: Icon(Icons.subscriptions),
                    title: Text(
                      "My Subscriptions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    leading: const Icon(Icons.payment),
                    title: const Text(
                      "My Payments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.edit),
                    title: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    onTap: () {
                      _showAboutUsModal(context);
                    },
                    leading: const Icon(Icons.info),
                    title: const Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 34, 147, 212)),
                      ),
                      onPressed: () {
                        showSnackBar(context, 'Logged Out Successfully!');
                        AuthService().signOut(context);
                      },
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutUsModalContent extends StatelessWidget {
  const AboutUsModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Row(
              children: const [
                SizedBox(width: 10),
                Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Talent Tree is an innovative application that aims to revolutionize the casting process in the entertainment industry by connecting casting directors and actors directly. Our platform provides a streamlined and user-friendly experience for both casting directors and actors, making the process of casting for productions faster and more efficient.\n\nFor actors, Talent Tree offers a unique opportunity to showcase their talent and get noticed by casting directors. Our platform allows actors to easily upload their audition tapes, headshots, resumes, and other relevant information. This ensures that their profile is always up-to-date and accessible to casting directors who are looking for new talent.\n\nFor casting directors, Talent Tree provides a centralized database of actors that can be easily searched and filtered based on specific criteria such as age range, gender, location, and skill set. This saves valuable time and resources, and ensures that casting directors can find the best actors for their productions quickly and efficiently.\n\nOne of the most significant advantages of Talent Tree is that it enables casting directors to view audition tapes of actors remotely, which is especially beneficial in today's climate where virtual casting has become the norm. This allows casting directors to cast actors from anywhere in the world, without having to physically meet them in person.\n\nAt Talent Tree, we pride ourselves on our commitment to promoting diversity and inclusivity in the entertainment industry. We believe that everyone deserves a chance to showcase their talent, regardless of their background or identity. With Talent Tree, we aim to create a level playing field for actors of all backgrounds and provide them with an equal opportunity to succeed.\n\nOverall, Talent Tree is a game-changer for the entertainment industry, providing a much-needed solution for actors and casting directors alike. Whether you're an aspiring actor looking to jumpstart your career or a casting director searching for the perfect talent, Talent Tree is the platform for you.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

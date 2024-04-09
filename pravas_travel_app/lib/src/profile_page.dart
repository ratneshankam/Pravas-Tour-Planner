import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/src/home_page.dart';
import 'package:travel_app/src/register.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Username";
  String email = "username@gmail.com";
  String profilePictureUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGf_8UZ3xLijdkOtv3qWnUpyknARbKMrcVJA&usqp=CAU";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      // appBar: AppBar(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: Icon(
                      Icons.home,
                      size: 26,
                    )),
              ],
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              width: 350,
              child: Column(
                children: [
                  const Text('User Profile'),
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profilePictureUrl),
                  ),
                  const SizedBox(height: 20),
                  Text('Name: $name'),
                  Text('Email: $email'),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(93, 73, 190, 1),
                        borderRadius: BorderRadius.circular(50)),
                    width: 270,
                    height: 52,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50.0), // Change the border radius as needed
                          ),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(
                          Color(0xff6D31ED),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: Text(
                        "Log out",
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Add more user information widgets here
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios, color: Colors.grey, size: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: Icon(Icons.password, color: Colors.grey, size: 24),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: size.height * 0.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgtheme.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 95,
              backgroundColor: const Color.fromARGB(255, 118, 208, 121),
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage("assets/avatar.jpg.webp"),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vladimir Putin',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8,),
                Icon(Icons.edit_outlined, color: Colors.grey,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

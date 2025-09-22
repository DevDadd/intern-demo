import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/profile.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          // Content on top
          Positioned.fill(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF6F767E),
                        size: 24,
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          'Thông Tin Tài Khoản',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFFEFEFEF),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          "assets/icons/password.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 188,
                    height: 188,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 90,
                      backgroundImage: AssetImage("assets/avatar.jpg.webp"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

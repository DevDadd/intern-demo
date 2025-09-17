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
        leading: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 24),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: Icon(Icons.password, color: Colors.grey, size: 24),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.height * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bgtheme.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    CircleAvatar(
                      radius: 95,
                      backgroundColor: const Color(0xFF1AAF74),
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage("assets/avatar.jpg.webp"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vladimir Putin',
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit_outlined, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "064C818609",
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1AAF74),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Đang hoạt động",
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF1AAF74),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
            Container(
              width: size.width * 0.95,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  infoRow("Tên chủ TK", "Vladimir Vladimirovich Putin"),
                  infoRow("Giới tính", "Nam"),
                  infoRow("Ngày sinh", "07-10-1952"),
                  infoRow("Số CMND/CCCD/HC", "120133456038"),
                  infoRow("Ngày cấp", "04-04-2016"),
                  infoRow(
                    "Nơi cấp",
                    "Cục Cảnh sát Quản lý Hành chính về Trật tự Xã hội",
                  ),
                  infoRow(
                    "Địa chỉ liên hệ",
                    "Số 13 Lò Đúc, Phường Thanh Xuân Bắc, Quận Thanh Xuân",
                  ),
                  infoRow("Tỉnh/Thành phố", "Hà Nội"),
                  infoRow("Điện thoại di động", "0969387963"),
                  infoRow("Email", "putin@gmail.com"),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value, {bool showDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: Color(0xFF6F767E),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (showDivider)
          const Divider(color: Colors.grey, thickness: 0.3, height: 16),
      ],
    );
  }
}

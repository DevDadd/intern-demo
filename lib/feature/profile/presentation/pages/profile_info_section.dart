import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_widget.dart';

class ProfileInfoSection extends StatelessWidget {
  final User user;

  const ProfileInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = kToolbarHeight;
    final safeAreaTop = statusBarHeight + appBarHeight;

    final items = [
      {"title": "Tên chủ TK", "value": user.name},
      {"title": "Giới tính", "value": user.sex},
      {"title": "Ngày sinh", "value": user.dob},
      {"title": "Số CMND/CCCD/HC", "value": user.idCard},
      {"title": "Ngày cấp", "value": user.date},
      {"title": "Nơi cấp", "value": user.placeID},
      {"title": "Địa chỉ liên hệ", "value": user.contactAdress},
      {"title": "Tỉnh/Thành phố", "value": user.city},
      {"title": "Điện thoại di động", "value": user.phone},
      {"title": "Email", "value": user.email},
    ];

    return Container(
      margin: EdgeInsets.only(top: safeAreaTop + 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1A1D1F),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ProfileWidget(
                  title: item["title"]!,
                  value: item["value"]!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icons/pen.png",
                      color: const Color(0xFF1AAF74),
                    ),
                    const SizedBox(width: 11.2),
                    Text(
                      "Thay đổi thông tin",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1AAF74),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

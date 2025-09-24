import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final String name;
  final String idCard;
  final String avatarPath;

  ProfileHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.name,
    required this.idCard,
    required this.avatarPath,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double sizeFactor =
        1 - (shrinkOffset / (maxHeight - minHeight)).clamp(0.0, 1.0);
    final double avatarSize = 180 * sizeFactor + 60;
    final double nameFontSize = 16 + (24 - 16) * sizeFactor;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/bgtheme.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // AppBar content
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
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
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/icons/password.png",
                    height: 24,
                    width: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Avatar
            Center(
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 4),
                  image: DecorationImage(
                    image: AssetImage(avatarPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name + edit icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset("assets/icons/pen.png"),
              ],
            ),
            const SizedBox(height: 8.5),
            // ID + status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  idCard,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1AAF74),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Đang hoạt động",
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF1AAF74),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ProfileHeaderDelegate oldDelegate) {
    return name != oldDelegate.name ||
        idCard != oldDelegate.idCard ||
        avatarPath != oldDelegate.avatarPath ||
        maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

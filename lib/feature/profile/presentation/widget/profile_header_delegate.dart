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
    double sizeFactor = 1 - shrinkOffset / (maxHeight - minHeight);
    sizeFactor = sizeFactor.clamp(0.0, 1.0);

    double avatarSize = 120 * sizeFactor + 40;
    double nameFontSize = 16 + (24 - 16) * sizeFactor;

    return Container(
      height: maxExtent,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: const DecorationImage(
          image: AssetImage("assets/profile.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 4),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage(avatarPath),
                    ),
                  ),
                  const SizedBox(height: 12),

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

                  const SizedBox(height: 8),

                  // ID + trạng thái
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

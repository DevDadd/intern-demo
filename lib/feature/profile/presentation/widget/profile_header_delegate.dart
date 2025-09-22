import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final User user;

  ProfileHeaderDelegate({required this.expandedHeight, required this.user});

  @override
  double get minExtent => kToolbarHeight + 16;
  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    final avatarSize = 120 - (80 * progress); // 120 -> 40
    final avatarTop = (expandedHeight / 2 - 60) * (1 - progress) + 8;
    final avatarLeft = 16 * progress;

    final infoLeft = avatarLeft + avatarSize + 12;
    final infoTop = avatarTop + 20 * progress;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset("assets/profile.png", fit: BoxFit.cover),
        // Avatar
        Positioned(
          top: avatarTop,
          left: avatarLeft,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 4),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: AssetImage("assets/avatar.jpg.webp"),
            ),
          ),
        ),
        // Info
        Positioned(
          top: infoTop,
          left: infoLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 24 - 8 * progress,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    user.idCard,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1AAF74),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Đang hoạt động",
                    style: GoogleFonts.manrope(
                      color: Color(0xFF1AAF74),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant ProfileHeaderDelegate oldDelegate) {
    return oldDelegate.user != user ||
        oldDelegate.expandedHeight != expandedHeight;
  }
}

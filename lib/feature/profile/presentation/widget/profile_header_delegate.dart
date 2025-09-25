import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final String name;
  final String avatarPath;

  ProfileHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.name,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;

    double factor = 1 - (shrinkOffset / (maxHeight - minHeight));
    factor = factor.clamp(0.0, 1.0);

    double avatarSize = 120 * factor + 80;

    double avatarLeft =
        (screenWidth / 2 - avatarSize / 2) * factor + 16 * (1 - factor);

    double avatarTopExpanded = topPadding + 100;
    double avatarTopCollapsed = topPadding + (minHeight - avatarSize) / 2;
    double avatarTop =
        avatarTopExpanded * factor + avatarTopCollapsed * (1 - factor);

    double infoWidth = 200; 
    double infoLeftExpanded = (screenWidth - infoWidth) / 2;
    double infoLeftCollapsed = avatarLeft + avatarSize + 20;
    double infoLeft =
        infoLeftExpanded * factor + infoLeftCollapsed * (1 - factor);

    double infoTopExpanded = avatarTop + avatarSize + 8;
    double infoTopCollapsed = avatarTop + (avatarSize - 70) / 2;
    double infoTop = infoTopExpanded * factor + infoTopCollapsed * (1 - factor);

    double nameFontSize = 24 + (24 - 24) * factor;

    CrossAxisAlignment infoAlignment = factor > 0.5
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111315),
            image: const DecorationImage(
              image: AssetImage("assets/bgtheme.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF6F767E),
                      size: 24,
                    ),
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
          ),
        ),

        Positioned(
          left: avatarLeft,
          top: avatarTop,
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

        Positioned(
          left: infoLeft,
          top: infoTop,
          child: Column(
            crossAxisAlignment: infoAlignment,
            children: [
              Text(
                name,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: nameFontSize,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "0C99231321",
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
    );
  }

  @override
  bool shouldRebuild(covariant ProfileHeaderDelegate oldDelegate) {
    return name != oldDelegate.name ||
        avatarPath != oldDelegate.avatarPath ||
        maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

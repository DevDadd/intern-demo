import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:interndemo/core/router/go_router.dart';

class TestAnimation extends StatefulWidget {
  const TestAnimation({super.key});

  @override
  State<TestAnimation> createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().addUser(User(
          name: "Vladimir Putin",
          sex: "Nam",
          dob: "07-10-1952",
          idCard: "120133456038",
          date: "04-04-2013",
          placeID: "Cục Cảnh sát Quản lý Hành chính về Trật tự Xã hội",
          contactAdress: "Số 13 Lò Đúc, Phường Thanh Xuân Bắc, Quận Thanh Xuân",
          city: "Hà Nội",
          phone: "0969387963",
          email: "putin@gmail.com",
        ));
    context.read<UserCubit>().getUser();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) return const SizedBox();

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: Image.asset(
                      "assets/icons/password.png",
                      height: 17.5,
                      width: 21.5,
                      color: const Color(0xFF6F767E),
                    ),
                  ),
                ],
                title: Text(
                  "Thông Tin Tài Khoản",
                  style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _ProfileHeaderDelegate(
                  user: user,
                  maxHeight: size.height * 0.4,
                  minHeight: 120,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Container(
                  width: size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1D1F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ProfileWidget(title: "Tên chủ TK", value: user.name),
                      ProfileWidget(title: "Giới tính", value: user.sex),
                      ProfileWidget(title: "Ngày sinh", value: user.dob),
                      ProfileWidget(title: "Số CMND/CCCD/HC", value: user.idCard),
                      ProfileWidget(title: "Ngày cấp", value: user.date),
                      ProfileWidget(title: "Nơi cấp", value: user.placeID),
                      ProfileWidget(title: "Địa chỉ liên hệ", value: user.contactAdress),
                      ProfileWidget(title: "Tỉnh/Thành phố", value: user.city),
                      ProfileWidget(title: "Điện thoại di động", value: user.phone),
                      ProfileWidget(title: "Email", value: user.email),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/pen.png",
                            color: const Color(0xFF1AAF74),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              context.push(AppRouteConstant.editProfilePage, extra: user);
                            },
                            child: Text(
                              "Thay đổi thông tin",
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF1AAF74),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Delegate co giãn header
class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final User user;
  final double maxHeight;
  final double minHeight;

  _ProfileHeaderDelegate({
    required this.user,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (1 - shrinkOffset / (maxHeight - minHeight)).clamp(0.0, 1.0);

    // Avatar co dãn
    final avatarSize = 95 * t + 40 * (1 - t);
    final fontSize = 24 * t + 16 * (1 - t);

    // Vị trí avatar
    final avatarLeft = (MediaQuery.of(context).size.width / 2 - avatarSize / 2) * t + 20 * (1 - t);
    final avatarTop = 40 * t + 20 * (1 - t);

    // Vị trí text
    final textLeft = (MediaQuery.of(context).size.width / 2 - 50) * t + (avatarLeft + avatarSize + 10) * (1 - t);
    final textTop = avatarTop + avatarSize / 2 - fontSize / 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        Positioned.fill(
          child: Image.asset(
            "assets/profile.png",
            fit: BoxFit.cover,
          ),
        ),
        // Avatar
        Positioned(
          left: avatarLeft,
          top: avatarTop,
          child: CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: const Color(0xFF1AAF74),
            child: CircleAvatar(
              radius: avatarSize / 2 - 5,
              backgroundImage: const AssetImage("assets/avatar.jpg.webp"),
            ),
          ),
        ),
        // Text
        Positioned(
          left: textLeft,
          top: textTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(user.idCard, style: GoogleFonts.manrope(color: Colors.white, fontSize: 14)),
                  const SizedBox(width: 5),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1AAF74)),
                  ),
                  const SizedBox(width: 5),
                  const Text("Đang hoạt động", style: TextStyle(color: Color(0xFF1AAF74), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _ProfileHeaderDelegate oldDelegate) {
    return oldDelegate.user != user || oldDelegate.maxHeight != maxHeight || oldDelegate.minHeight != minHeight;
  }
}

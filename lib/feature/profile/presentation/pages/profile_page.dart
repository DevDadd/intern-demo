import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_header_delegate.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();
  final _maxHeight = 100.0;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_updatePositon);
    context.read<UserCubit>().addUser(
      User(
        name: "Vladimir Putin",
        sex: "Nam",
        dob: "04-14-1992",
        idCard: "992391381",
        date: "02-02-2000",
        placeID: "Moscow",
        contactAdress: "Số 1 Phố Hàng Trống",
        city: "Hanoi",
        phone: "099931321",
        email: "putin@gmail.com",
      ),
    );
    context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        if (user == null) return const SizedBox();

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

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: Stack(
            children: [
              // Image.asset(
              //   "assets/profile.png",
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // ),
              Column(
                children: [
                  SafeArea(
                    bottom: false,
                    child: Container(
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
                                color: const Color(0xFFEFEFEF),
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
                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPersistentHeader(
                          delegate: ProfileHeaderDelegate(
                            maxHeight: 350,
                            minHeight: 150,
                            name: user.name,
                            idCard: user.idCard,
                            avatarPath: "assets/avatar.jpg.webp",
                          ),
                          pinned: true,
                        ),
                        // Dùng SliverPadding + SliverList để scroll mượt
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          sliver: SliverList.builder(
                            itemCount: items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // Bọc tất cả item trong 1 container
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFF1A1D1F),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
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
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 30),
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
                                                    color:
                                                        const Color(0xFF1AAF74),
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
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _updatePositon() async {
  //   final offset = _scrollController.offset;
  //   if (offset > _maxHeight) {
  //     await _scrollController.animateTo(
  //       _maxHeight,
  //       duration: const Duration(milliseconds: 200),
  //       curve: Curves.easeOut,
  //     );
  //   }
  //   if (_scrollController.offset > _maxHeight) {
  //     _scrollController.jumpTo(_maxHeight);
  //   }
  // }
}

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
  @override
  void initState() {
    super.initState();
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

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: Stack(
            children: [
              Image.asset(
                "assets/profile.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Column(
                children: [
                  SafeArea(
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
                      slivers: [
                        SliverPersistentHeader(
                          delegate: ProfileHeaderDelegate(
                            maxHeight: 350,
                            minHeight: 200,
                            name: user.name,
                            idCard: user.idCard,
                            avatarPath: "assets/avatar.jpg.webp",
                          ),
                          pinned: true,
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF1A1D1F),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ProfileWidget(
                                      title: "Tên chủ TK",
                                      value: user.name,
                                    ),
                                    ProfileWidget(
                                      title: "Giới tính",
                                      value: user.sex,
                                    ),
                                    ProfileWidget(
                                      title: "Ngày sinh",
                                      value: user.dob,
                                    ),
                                    ProfileWidget(
                                      title: "Số CMND/CCCD/HC",
                                      value: user.idCard,
                                    ),
                                    ProfileWidget(
                                      title: "Ngày cấp",
                                      value: user.date,
                                    ),
                                    ProfileWidget(
                                      title: "Nơi cấp",
                                      value: user.placeID,
                                    ),
                                    ProfileWidget(
                                      title: "Địa chỉ liên hệ",
                                      value: user.contactAdress,
                                    ),
                                    ProfileWidget(
                                      title: "Tỉnh/Thành phố",
                                      value: user.city,
                                    ),
                                    ProfileWidget(
                                      title: "Điện thoại di động",
                                      value: user.phone,
                                    ),
                                    ProfileWidget(
                                      title: "Email",
                                      value: user.email,
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/icons/pen.png",
                                              color: const Color(
                                                0xFF1AAF74,
                                              ),
                                            ),
                                            const SizedBox(width: 11.2),
                                            Text(
                                              "Thay đổi thông tin",
                                              style: GoogleFonts.manrope(
                                                fontWeight:
                                                    FontWeight.w700,
                                                color: const Color(
                                                  0xFF1AAF74,
                                                ),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
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
}

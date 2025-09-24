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
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ProfileHeaderDelegate(
                  maxHeight: 410,
                  minHeight: 200,
                  name: user.name,
                  avatarPath: "assets/avatar.jpg.webp",
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF1A1D1F),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12, // padding vừa phải
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // chỉ chiếm đúng nội dung
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileWidget(title: "Tên chủ TK", value: user.name),
                          ProfileWidget(title: "Giới tính", value: user.sex),
                          ProfileWidget(title: "Ngày sinh", value: user.dob),
                          ProfileWidget(
                            title: "Số CMND/CCCD/HC",
                            value: user.idCard,
                          ),
                          ProfileWidget(title: "Ngày cấp", value: user.date),
                          ProfileWidget(title: "Nơi cấp", value: user.placeID),
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
                          ProfileWidget(title: "Email", value: user.email),
                          const SizedBox(height: 12),
                          Center(
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
                          const SizedBox(height: 8), // giữ chút padding dưới
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

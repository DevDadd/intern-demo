import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/core/router/go_router.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
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
    context.read<UserCubit>().addUser(User(name: "Vladimir Putin", sex: "Nam", dob: "07-10-1952", idCard: "120133456038", date: "04-04-2013", placeID: "Cục Cảnh sát Quản lý Hành chính về Trật tự Xã hội", contactAdress: "Số 13 Lò Đúc, Phường Thanh Xuân Bắc, Quận Thanh Xuân", city: "Hà Nội", phone: "0969387963", email: "putin@gmail.com"));
    context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 24),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: Image.asset(
              "assets/icons/password.png",
              height: 17.5,
              width: 21.5,
              color: Color(0xFF6F767E),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                            backgroundImage: AssetImage(
                              "assets/avatar.jpg.webp",
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vladimir Putin",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/icons/pen.png",
                              height: 14.58,
                              width: 17.92,
                            ),
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
                      ProfileWidget(
                        title: "Tên chủ TK",
                        value: state.user!.name,
                      ),
                      ProfileWidget(title: "Giới tính", value: state.user!.sex),
                      ProfileWidget(title: "Ngày sinh", value: state.user!.dob),
                      ProfileWidget(
                        title: "Số CMND/CCCD/HC",
                        value: state.user!.idCard,
                      ),
                      ProfileWidget(title: "Ngày cấp", value: state.user!.date),
                      ProfileWidget(
                        title: "Nơi cấp",
                        value:
                            state.user!.placeID,
                      ),
                      ProfileWidget(
                        title: "Địa chỉ liên hệ",
                        value:
                           state.user!.contactAdress,
                      ),
                      ProfileWidget(title: "Tỉnh/Thành phố", value: state.user!.city),
                      ProfileWidget(
                        title: "Điện thoại di động",
                        value: state.user!.phone,
                      ),
                      ProfileWidget(title: "Email", value: state.user!.email),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/pen.png",
                            color: Color(0xFF1AAF74),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              context.push(AppRouteConstant.editProfilePage,extra: state.user);
                            },
                            child: Text(
                              "Thay đổi thông tin",
                              style: GoogleFonts.manrope(
                                color: Color(0xFF1AAF74),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}

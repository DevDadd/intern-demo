import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:interndemo/feature/profile/presentation/pages/profile_info_section.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_header_delegate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();

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
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                expandedHeight: 0,
                collapsedHeight: kToolbarHeight,
                backgroundColor: const Color(0xFF111315),
                leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
                title: Text(
                  "Thông Tin Tài Khoản",
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/password.png"),
                  ),
                ],
              ),

              SliverToBoxAdapter(child: SizedBox(height: 20)),

              SliverPersistentHeader(
                delegate: ProfileHeaderDelegate(
                  maxHeight: 350,
                  minHeight: 150,
                  name: user.name,
                  idCard: user.idCard,
                  avatarPath: "assets/avatar.jpg.webp",
                ),
                pinned: false,
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverToBoxAdapter(
                  child: ProfileInfoSection(user: user),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

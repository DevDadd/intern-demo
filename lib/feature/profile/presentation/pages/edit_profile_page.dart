import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interndemo/core/router/go_router.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:interndemo/feature/profile/presentation/widget/edit_widget.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.idCard,
    required this.date,
    required this.place,
    required this.address,
    required this.city,
    required this.phone,
    required this.gmail,
  });

  final String idCard;
  final String date;
  final String place;
  final String address;
  final String city;
  final String phone;
  final String gmail;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _idController;
  late TextEditingController _dateController;
  late TextEditingController _placeController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.idCard);
    _dateController = TextEditingController(text: widget.date);
    _placeController = TextEditingController(text: widget.place);
    _addressController = TextEditingController(text: widget.address);
    _cityController = TextEditingController(text: widget.city);
    _phoneController = TextEditingController(text: widget.phone);
    _emailController = TextEditingController(text: widget.gmail);

    // Listener để rebuild khi text thay đổi
    _idController.addListener(() => setState(() {}));
    _dateController.addListener(() => setState(() {}));
    _placeController.addListener(() => setState(() {}));
    _addressController.addListener(() => setState(() {}));
    _cityController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _idController.dispose();
    _dateController.dispose();
    _placeController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 24),
        ),
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
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Column(
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
                              'Vladimir Putin',
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
                        title: "Tên Chủ TK",
                        value: "Vladimir Vladimirovich Putin",
                      ),
                      ProfileWidget(title: "Giới tính", value: "Nam"),
                      ProfileWidget(title: "Ngày sinh", value: "07-10-1952"),
                      CustomBox(
                        controller: _idController,
                        label: "Số CMND/CCCD",
                        suffix: SvgPicture.asset("assets/icons/delete.svg"),
                        onSuffixTap: () {
                          _idController.clear();
                        },
                      ),
                      const SizedBox(height: 5),
                      CustomBox(
                        controller: _dateController,
                        label: "Ngày Cấp",
                        suffix: SvgPicture.asset("assets/icons/calender.svg"),
                      ),
                      const SizedBox(height: 5),
                      CustomBox(
                        controller: _placeController,
                        label: "Nơi Cấp",
                        suffix: SvgPicture.asset("assets/icons/delete.svg"),
                        onSuffixTap: () {
                          _placeController.clear();
                        },
                      ),
                      const SizedBox(height: 10),
                      if (_idController.text != widget.idCard ||
                          _dateController.text != widget.date ||
                          _addressController.text != widget.address)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Bạn cần cung cấp ảnh để xác thực thông tin CMND/CCCD vừa thay đổi.",
                                style: GoogleFonts.manrope(
                                  color: Color(0xFFFF9F41),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 36,
                                  width: 77,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFF1AAF74).withAlpha(10),
                                  ),
                                ),
                                SvgPicture.asset("assets/icons/camera.svg"),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

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
                      CustomBox(
                        controller: _addressController,
                        label: "Địa chỉ liên hệ",
                        suffix: SvgPicture.asset("assets/icons/delete.svg"),
                        onSuffixTap: () {
                          _addressController.clear();
                        },
                      ),
                      const SizedBox(height: 5),
                      CustomBox(
                        controller: _cityController,
                        label: "Thành Phố",
                        suffix: SvgPicture.asset("assets/icons/delete.svg"),
                        onSuffixTap: () {
                          _cityController.clear();
                        },
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Điện thoại di động",
                            style: GoogleFonts.manrope(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF272B30),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "+84",
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  color: Colors.white24,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nhập số điện thoại",
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          CustomBox(
                            controller: _emailController,
                            label: "Email",
                            suffix: SvgPicture.asset("assets/icons/delete.svg"),
                            onSuffixTap: () {
                              _emailController.clear();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.pop(); // cancel
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.manrope(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1AAF74),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.read<UserCubit>().updateUser(
                        User(
                          name: state.user!.name,
                          sex: state.user!.sex,
                          dob: state.user!.dob,
                          idCard: _idController.text,
                          date: _dateController.text,
                          placeID: _placeController.text,
                          contactAdress: _addressController.text,
                          city: _cityController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                        ),
                      );
                      context.pop();
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.manrope(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

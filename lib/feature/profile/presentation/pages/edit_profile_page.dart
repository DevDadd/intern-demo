import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {
  late final TextEditingController _idController;
  late final TextEditingController _dateController;
  late final TextEditingController _placeController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  DateTime datetime = DateTime.now();

  late final AnimationController _avatarAnimationController;
  late final AnimationController _infoAnimationController;
  late final Animation<double> _avatarScaleAnimation;
  late final Animation<double> _infoOpacityAnimation;

  late final ScrollController _scrollController;
  double _scrollOffset = 0.0;
  bool _isScrolled = false;

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

    _scrollController = ScrollController()..addListener(_onScroll);

    _avatarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _infoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _avatarScaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _avatarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _infoOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _infoAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    setState(() {
      _scrollOffset = _scrollController.offset;
      const threshold = 180.0;
      final shouldBeScrolled = _scrollOffset > threshold;

      if (shouldBeScrolled != _isScrolled) {
        _isScrolled = shouldBeScrolled;
        if (_isScrolled) {
          _avatarAnimationController.forward();
          _infoAnimationController.forward();
        } else {
          _avatarAnimationController.reverse();
          _infoAnimationController.reverse();
        }
      }
    });
  }

  void _showCupertinoDatePicker() {
    try {
      final parts = _dateController.text.split('-');
      if (parts.length == 3) {
        final d = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final y = int.tryParse(parts[2]);
        if (d != null && m != null && y != null) {
          datetime = DateTime(y, m, d);
        }
      }
    } catch (_) {}

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 350,
        color: Colors.black87,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 22,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  brightness: Brightness.dark,
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  backgroundColor: Colors.black87,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: datetime,
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime newDate) {
                    datetime = newDate;
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _dateController.text =
                    "${datetime.day.toString().padLeft(2, '0')}-${datetime.month.toString().padLeft(2, '0')}-${datetime.year}";
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _avatarAnimationController.dispose();
    _infoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isScrolled
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 24,
                ),
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
      body: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isScrolled
                ? Container(
                    key: const ValueKey('stickyHeader'),
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedBuilder(
                          animation: _avatarScaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _avatarScaleAnimation.value,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xFF1AAF74),
                                child: const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(
                                    "assets/avatar.jpg.webp",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _infoOpacityAnimation,
                            builder: (context, child) {
                              final stickyOpacity =
                                  1.0 - _infoOpacityAnimation.value;
                              return Opacity(
                                opacity: stickyOpacity.clamp(0.0, 1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vladimir Putin',
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "064C818609",
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: 12,
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
                                        const SizedBox(width: 4),
                                        Text(
                                          "Đang hoạt động",
                                          style: GoogleFonts.manrope(
                                            color: const Color(0xFF1AAF74),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
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
                  )
                : const SizedBox.shrink(),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  final user = state.user;
                  if (user == null) {
                    return SizedBox(
                      height: size.height * 0.7,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  return Column(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 100),
                            if (!_isScrolled)
                              AnimatedBuilder(
                                animation: _avatarScaleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _avatarScaleAnimation.value,
                                    child: CircleAvatar(
                                      radius: 95,
                                      backgroundColor: const Color(0xFF1AAF74),
                                      child: const CircleAvatar(
                                        radius: 90,
                                        backgroundImage: AssetImage(
                                          "assets/avatar.jpg.webp",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 20),
                            if (!_isScrolled)
                              AnimatedBuilder(
                                animation: _infoOpacityAnimation,
                                builder: (context, child) {
                                  final centerOpacity = _infoOpacityAnimation
                                      .value
                                      .clamp(0.0, 1.0);
                                  return Opacity(
                                    opacity: centerOpacity,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.name ?? 'Unknown',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.idCard ?? "064C818609",
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
                                      ],
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
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
                              value: user.name ?? '',
                            ),
                            ProfileWidget(
                              title: "Giới tính",
                              value: user.sex ?? '',
                            ),
                            ProfileWidget(
                              title: "Ngày sinh",
                              value: user.dob ?? '',
                            ),
                            const SizedBox(height: 8),
                            CustomBox(
                              controller: _idController,
                              label: "Số CMND/CCCD",
                              suffix: SvgPicture.asset(
                                "assets/icons/delete.svg",
                              ),
                              onSuffixTap: () {
                                _idController.clear();
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomBox(
                              controller: _dateController,
                              label: "Ngày Cấp",
                              suffix: SvgPicture.asset(
                                "assets/icons/calender.svg",
                              ),
                              onSuffixTap: () {
                                _showCupertinoDatePicker();
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomBox(
                              controller: _placeController,
                              label: "Nơi Cấp",
                              suffix: SvgPicture.asset(
                                "assets/icons/delete.svg",
                              ),
                              onSuffixTap: () {
                                _placeController.clear();
                              },
                            ),
                            const SizedBox(height: 10),
                            if (_idController.text != widget.idCard ||
                                _dateController.text != widget.date ||
                                _placeController.text != widget.place)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Bạn cần cung cấp ảnh để xác thực thông tin CMND/CCCD vừa thay đổi.",
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFFFF9F41),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 36,
                                        width: 77,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: const Color(
                                            0xFF1AAF74,
                                          ).withAlpha(10),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/camera.svg",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

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
                              suffix: SvgPicture.asset(
                                "assets/icons/delete.svg",
                              ),
                              onSuffixTap: () {
                                _addressController.clear();
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomBox(
                              controller: _cityController,
                              label: "Thành Phố",
                              suffix: SvgPicture.asset(
                                "assets/icons/delete.svg",
                              ),
                              onSuffixTap: () {
                                _cityController.clear();
                              },
                            ),
                            const SizedBox(height: 8),
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
                                const SizedBox(height: 8),
                                CustomBox(
                                  controller: _emailController,
                                  label: "Email",
                                  suffix: SvgPicture.asset(
                                    "assets/icons/delete.svg",
                                  ),
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
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final user = state.user;
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
                      onPressed: user == null
                          ? null
                          : () {
                              final updated = User(
                                name: user.name ?? '',
                                sex: user.sex ?? '',
                                dob: user.dob ?? '',
                                idCard: _idController.text,
                                date: _dateController.text,
                                placeID: _placeController.text,
                                contactAdress: _addressController.text,
                                city: _cityController.text,
                                phone: _phoneController.text,
                                email: _emailController.text,
                              );

                              context.read<UserCubit>().updateUser(updated);

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
      ),
    );
  }
}

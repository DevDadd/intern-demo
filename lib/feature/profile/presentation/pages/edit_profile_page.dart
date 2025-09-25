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
import 'package:interndemo/feature/profile/presentation/widget/profile_header_delegate.dart';
import 'package:interndemo/feature/profile/presentation/widget/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  final String idCard;
  final String date;
  final String place;
  final String address;
  final String city;
  final String phone;
  final String gmail;

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

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController idCardController;
  late TextEditingController dateController;
  late TextEditingController placeController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController phoneController;
  late TextEditingController gmailController;

  @override
  void initState() {
    super.initState();
    idCardController = TextEditingController(text: widget.idCard);
    dateController = TextEditingController(text: widget.date);
    placeController = TextEditingController(text: widget.place);
    addressController = TextEditingController(text: widget.address);
    cityController = TextEditingController(text: widget.city);
    phoneController = TextEditingController(text: widget.phone);
    gmailController = TextEditingController(text: widget.gmail);

    idCardController.addListener(_onFieldChanged);
    dateController.addListener(_onFieldChanged);
    placeController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {}); 
  }

  @override
  void dispose() {
    idCardController.removeListener(_onFieldChanged);
    dateController.removeListener(_onFieldChanged);
    placeController.removeListener(_onFieldChanged);

    idCardController.dispose();
    dateController.dispose();
    placeController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneController.dispose();
    gmailController.dispose();
    super.dispose();
  }

  void _showCupertinoDatePicker(BuildContext context) {
    DateTime selectedDate;

    if (dateController.text.isNotEmpty) {
      try {
        final parts = dateController.text.split('-');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          selectedDate = DateTime(year, month, day);
        } else {
          selectedDate = DateTime.now();
        }
      } catch (e) {
        selectedDate = DateTime.now();
      }
    } else {
      selectedDate = DateTime.now();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1D1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return SizedBox(
              height: 350,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            "assets/icons/delete.svg",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                        brightness: Brightness.dark,
                      ),
                      child: CupertinoDatePicker(
                        initialDateTime: selectedDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          setStateModal(() => selectedDate = newDate);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          dateController.text =
                              "${selectedDate.day.toString().padLeft(2, '0')}-"
                              "${selectedDate.month.toString().padLeft(2, '0')}-"
                              "${selectedDate.year}";
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1AAF74),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        if (user == null) return const SizedBox();

        final hasChanged =
            idCardController.text != widget.idCard ||
            dateController.text != widget.date ||
            placeController.text != widget.place;

        return Scaffold(
          backgroundColor: const Color(0xFF111315),
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: ProfileHeaderDelegate(
                  maxHeight: 450,
                  minHeight: 210,
                  name: user.name,
                  avatarPath: "assets/avatar.jpg.webp",
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      // ====== First Box: ID Info ======
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF1A1D1F),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              ProfileWidget(
                                title: "Tên chủ TK",
                                value: "Vladimir Vladimirovich Putin",
                              ),
                              ProfileWidget(
                                title: "Giới Tính",
                                value: state.user!.sex,
                              ),
                              ProfileWidget(
                                title: "Ngày Sinh",
                                value: state.user!.dob,
                              ),
                              CustomBox(
                                controller: idCardController,
                                label: "Số CMND/CCCD/HC",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => idCardController.clear(),
                              ),
                              const SizedBox(height: 12),
                              CustomBox(
                                controller: dateController,
                                label: "Ngày cấp",
                                suffix: GestureDetector(
                                  onTap: () =>
                                      _showCupertinoDatePicker(context),
                                  child: SvgPicture.asset(
                                    "assets/icons/calender.svg",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              CustomBox(
                                controller: placeController,
                                label: "Nơi cấp",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => placeController.clear(),
                              ),
                              // Hiện cảnh báo nếu thay đổi
                              if (hasChanged) ...[
                                const SizedBox(height: 12),
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
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ====== Second Box: Contact Info ======
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF1A1D1F),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              CustomBox(
                                controller: addressController,
                                label: "Địa chỉ liên hệ",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => addressController.clear(),
                                minLines: 1,
                              ),
                              const SizedBox(height: 12),
                              CustomBox(
                                controller: cityController,
                                label: "Tỉnh/Thành phố",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => cityController.clear(),
                              ),
                              const SizedBox(height: 12),
                              CustomBox(
                                controller: phoneController,
                                label: "Điện thoại di động",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => phoneController.clear(),
                              ),
                              const SizedBox(height: 12),
                              CustomBox(
                                controller: gmailController,
                                label: "Email",
                                suffix: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                ),
                                onSuffixTap: () => gmailController.clear(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 34),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(170, 48),
                              backgroundColor: const Color(0xFF111315),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Huỷ",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(170, 48),
                              backgroundColor: const Color(0xFF1AAF74),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              context.read<UserCubit>().updateUser(
                                User(
                                  name: user.name ?? "",
                                  sex: user.sex ?? "",
                                  dob: user.dob ?? " ",
                                  idCard: idCardController.text,
                                  date: dateController.text,
                                  placeID: placeController.text,
                                  contactAdress: addressController.text,
                                  city: cityController.text,
                                  phone: phoneController.text,
                                  email: gmailController.text,
                                ),
                              );
                              context.pop();
                            },
                            child: Text(
                              "Lưu thông tin",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
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

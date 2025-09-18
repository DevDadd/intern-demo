import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interndemo/core/di/di.dart';
import 'package:interndemo/feature/profile/cubit/user_cubit.dart';
import 'package:interndemo/feature/profile/presentation/pages/profile_page.dart';

class ProfilePageProvider extends StatelessWidget {
  const ProfilePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = getIt.get();
    return BlocProvider.value(value: userCubit, child: ProfilePage());
  }
}

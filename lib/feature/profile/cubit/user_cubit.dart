import 'package:bloc/bloc.dart';
import 'package:interndemo/feature/profile/cubit/user_state.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
  void addUser(User user) {
    emit(state.copyWith(user: user));
  }
}

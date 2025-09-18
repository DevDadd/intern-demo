import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:interndemo/feature/profile/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_state.g.dart';

@CopyWith()
@JsonSerializable()
class UserState extends Equatable {
  const UserState({this.user});
  final User? user;
  @override
  List<Object?> get props => [user];
}

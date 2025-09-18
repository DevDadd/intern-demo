import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String sex;
  final String dob;
  final String idCard;
  final String date;
  final String placeID;
  final String contactAdress;
  final String city;
  final String phone;
  final String email;

  User({
    required this.name,
    required this.sex,
    required this.dob,
    required this.idCard,
    required this.date,
    required this.placeID,
    required this.contactAdress,
    required this.city,
    required this.phone,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

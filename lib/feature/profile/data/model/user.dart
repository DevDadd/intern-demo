import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
class User {
  String? name;
  String? sex;
  String? dob;
  String? idCard;
  String? date;
  String? placeID;
  String? contactAdress;
  String? city;
  String? phone;
  String? email;
  User({
    this.name,
    this.sex,
    this.dob,
    this.idCard,
    this.date,
    this.placeID,
    this.contactAdress,
    this.city,
    this.phone,
    this.email,
  });
}

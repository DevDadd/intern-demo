// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  User name(String? name);

  User sex(String? sex);

  User dob(String? dob);

  User idCard(String? idCard);

  User date(String? date);

  User placeID(String? placeID);

  User contactAdress(String? contactAdress);

  User city(String? city);

  User phone(String? phone);

  User email(String? email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `User(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ```
  User call({
    String? name,
    String? sex,
    String? dob,
    String? idCard,
    String? date,
    String? placeID,
    String? contactAdress,
    String? city,
    String? phone,
    String? email,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUser.copyWith(...)` or call `instanceOfUser.copyWith.fieldName(value)` for a single field.
class _$UserCWProxyImpl implements _$UserCWProxy {
  const _$UserCWProxyImpl(this._value);

  final User _value;

  @override
  User name(String? name) => call(name: name);

  @override
  User sex(String? sex) => call(sex: sex);

  @override
  User dob(String? dob) => call(dob: dob);

  @override
  User idCard(String? idCard) => call(idCard: idCard);

  @override
  User date(String? date) => call(date: date);

  @override
  User placeID(String? placeID) => call(placeID: placeID);

  @override
  User contactAdress(String? contactAdress) =>
      call(contactAdress: contactAdress);

  @override
  User city(String? city) => call(city: city);

  @override
  User phone(String? phone) => call(phone: phone);

  @override
  User email(String? email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `User(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ```
  User call({
    Object? name = const $CopyWithPlaceholder(),
    Object? sex = const $CopyWithPlaceholder(),
    Object? dob = const $CopyWithPlaceholder(),
    Object? idCard = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? placeID = const $CopyWithPlaceholder(),
    Object? contactAdress = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return User(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      sex: sex == const $CopyWithPlaceholder()
          ? _value.sex
          // ignore: cast_nullable_to_non_nullable
          : sex as String?,
      dob: dob == const $CopyWithPlaceholder()
          ? _value.dob
          // ignore: cast_nullable_to_non_nullable
          : dob as String?,
      idCard: idCard == const $CopyWithPlaceholder()
          ? _value.idCard
          // ignore: cast_nullable_to_non_nullable
          : idCard as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
      placeID: placeID == const $CopyWithPlaceholder()
          ? _value.placeID
          // ignore: cast_nullable_to_non_nullable
          : placeID as String?,
      contactAdress: contactAdress == const $CopyWithPlaceholder()
          ? _value.contactAdress
          // ignore: cast_nullable_to_non_nullable
          : contactAdress as String?,
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
    );
  }
}

extension $UserCopyWith on User {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUser.copyWith(...)` or `instanceOfUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  name: json['name'] as String?,
  sex: json['sex'] as String?,
  dob: json['dob'] as String?,
  idCard: json['idCard'] as String?,
  date: json['date'] as String?,
  placeID: json['placeID'] as String?,
  contactAdress: json['contactAdress'] as String?,
  city: json['city'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'sex': instance.sex,
  'dob': instance.dob,
  'idCard': instance.idCard,
  'date': instance.date,
  'placeID': instance.placeID,
  'contactAdress': instance.contactAdress,
  'city': instance.city,
  'phone': instance.phone,
  'email': instance.email,
};

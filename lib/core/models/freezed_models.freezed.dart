// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String? get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({String? fullName, String? email, String? phone});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? fullName, String? email, String? phone});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$_User(
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  _$_User({this.fullName, this.email, this.phone});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final String? phone;

  @override
  String toString() {
    return 'User(fullName: $fullName, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, email, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {final String? fullName,
      final String? email,
      final String? phone}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String? get fullName;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}

ScannedItem _$ScannedItemFromJson(Map<String, dynamic> json) {
  return _ScannedItem.fromJson(json);
}

/// @nodoc
mixin _$ScannedItem {
  String? get gtin => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get scanTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScannedItemCopyWith<ScannedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannedItemCopyWith<$Res> {
  factory $ScannedItemCopyWith(
          ScannedItem value, $Res Function(ScannedItem) then) =
      _$ScannedItemCopyWithImpl<$Res, ScannedItem>;
  @useResult
  $Res call({String? gtin, String? description, DateTime? scanTime});
}

/// @nodoc
class _$ScannedItemCopyWithImpl<$Res, $Val extends ScannedItem>
    implements $ScannedItemCopyWith<$Res> {
  _$ScannedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gtin = freezed,
    Object? description = freezed,
    Object? scanTime = freezed,
  }) {
    return _then(_value.copyWith(
      gtin: freezed == gtin
          ? _value.gtin
          : gtin // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      scanTime: freezed == scanTime
          ? _value.scanTime
          : scanTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScannedItemCopyWith<$Res>
    implements $ScannedItemCopyWith<$Res> {
  factory _$$_ScannedItemCopyWith(
          _$_ScannedItem value, $Res Function(_$_ScannedItem) then) =
      __$$_ScannedItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? gtin, String? description, DateTime? scanTime});
}

/// @nodoc
class __$$_ScannedItemCopyWithImpl<$Res>
    extends _$ScannedItemCopyWithImpl<$Res, _$_ScannedItem>
    implements _$$_ScannedItemCopyWith<$Res> {
  __$$_ScannedItemCopyWithImpl(
      _$_ScannedItem _value, $Res Function(_$_ScannedItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gtin = freezed,
    Object? description = freezed,
    Object? scanTime = freezed,
  }) {
    return _then(_$_ScannedItem(
      gtin: freezed == gtin
          ? _value.gtin
          : gtin // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      scanTime: freezed == scanTime
          ? _value.scanTime
          : scanTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScannedItem implements _ScannedItem {
  _$_ScannedItem({this.gtin, this.description, this.scanTime});

  factory _$_ScannedItem.fromJson(Map<String, dynamic> json) =>
      _$$_ScannedItemFromJson(json);

  @override
  final String? gtin;
  @override
  final String? description;
  @override
  final DateTime? scanTime;

  @override
  String toString() {
    return 'ScannedItem(gtin: $gtin, description: $description, scanTime: $scanTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScannedItem &&
            (identical(other.gtin, gtin) || other.gtin == gtin) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scanTime, scanTime) ||
                other.scanTime == scanTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gtin, description, scanTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScannedItemCopyWith<_$_ScannedItem> get copyWith =>
      __$$_ScannedItemCopyWithImpl<_$_ScannedItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScannedItemToJson(
      this,
    );
  }
}

abstract class _ScannedItem implements ScannedItem {
  factory _ScannedItem(
      {final String? gtin,
      final String? description,
      final DateTime? scanTime}) = _$_ScannedItem;

  factory _ScannedItem.fromJson(Map<String, dynamic> json) =
      _$_ScannedItem.fromJson;

  @override
  String? get gtin;
  @override
  String? get description;
  @override
  DateTime? get scanTime;
  @override
  @JsonKey(ignore: true)
  _$$_ScannedItemCopyWith<_$_ScannedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
    };

_$_ScannedItem _$$_ScannedItemFromJson(Map<String, dynamic> json) =>
    _$_ScannedItem(
      gtin: json['gtin'] as String?,
      description: json['description'] as String?,
      scanTime: json['scanTime'] == null
          ? null
          : DateTime.parse(json['scanTime'] as String),
    );

Map<String, dynamic> _$$_ScannedItemToJson(_$_ScannedItem instance) =>
    <String, dynamic>{
      'gtin': instance.gtin,
      'description': instance.description,
      'scanTime': instance.scanTime?.toIso8601String(),
    };

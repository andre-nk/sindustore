// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      pin: json['pin'] as String,
      role: $enumDecode(_$RolesEnumMap, json['role']),
    );

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'pin': instance.pin,
      'role': _$RolesEnumMap[instance.role],
    };

const _$RolesEnumMap = {
  Roles.owner: 'owner',
  Roles.admin: 'admin',
  Roles.worker: 'worker',
};

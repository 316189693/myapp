// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..user_name = json['user_name'] as String
  ..first_name = json['first_name'] as String
  ..last_name = json['last_name'] as String
  ..email = json['email'] as String
  ..token = json['token'] as String
  ..user_id = json['user_id'] as num;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_name': instance.user_name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'token': instance.token,
      'user_id': instance.user_id,
    };

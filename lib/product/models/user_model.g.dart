// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      snapchat: json['snapchat'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      point: json['point'] as int?,
      seenUsers: (json['seenUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photos.fromJson(e as Map<String, dynamic>))
          .toList(),
      friendRequests: (json['friendRequests'] as List<dynamic>?)
          ?.map((e) => FriendRequests.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'gender': instance.gender,
      'snapchat': instance.snapchat,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'point': instance.point,
      'seenUsers': instance.seenUsers,
      'photos': instance.photos,
      'friendRequests': instance.friendRequests,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'token': instance.token,
    };

Photos _$PhotosFromJson(Map<String, dynamic> json) => Photos(
      photo: json['photo'] as String?,
      publicId: json['publicId'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'photo': instance.photo,
      'publicId': instance.publicId,
      '_id': instance.id,
    };

FriendRequests _$FriendRequestsFromJson(Map<String, dynamic> json) =>
    FriendRequests(
      id: json['_id'] as String?,
      sentType: json['sentType'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      snapchat: json['snapchat'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendRequestsToJson(FriendRequests instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sentType': instance.sentType,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'snapchat': instance.snapchat,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'photos': instance.photos,
    };

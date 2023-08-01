import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  String? password;
  int? age;
  String? gender;
  String? snapchat;
  String? instagram;
  String? twitter;
  int? point;
  List<String>? seenUsers;
  List<Photos>? photos;
  List<FriendRequests>? friendRequests;
  String? createdAt;
  String? updatedAt;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.age,
    this.gender,
    this.snapchat,
    this.instagram,
    this.twitter,
    this.point,
    this.seenUsers,
    this.photos,
    this.friendRequests,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}

@JsonSerializable()
class Photos {
  String? photo;
  String? publicId;
  @JsonKey(name: '_id')
  String? id;

  Photos({this.photo, this.publicId, this.id});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return _$PhotosFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PhotosToJson(this);
  }
}

@JsonSerializable()
class FriendRequests {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  int? age;
  String? gender;
  String? snapchat;
  String? instagram;
  String? twitter;
  List<Photos>? photos;

  FriendRequests({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.snapchat,
    this.instagram,
    this.twitter,
    this.photos,
  });

  factory FriendRequests.fromJson(Map<String, dynamic> json) {
    return _$FriendRequestsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FriendRequestsToJson(this);
  }
}

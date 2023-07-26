class UserModel {
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
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
    gender = json['gender'];
    snapchat = json['snapchat'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    point = json['point'];
    seenUsers = json['seenUsers'].cast<String>();
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['friendRequests'] != null) {
      friendRequests = <FriendRequests>[];
      json['friendRequests'].forEach((v) {
        friendRequests!.add(FriendRequests.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['age'] = age;
    data['gender'] = gender;
    data['snapchat'] = snapchat;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['point'] = point;
    data['seenUsers'] = seenUsers;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (friendRequests != null) {
      data['friendRequests'] = friendRequests!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Photos {
  String? photo;
  String? publicId;
  String? id;

  Photos({this.photo, this.publicId, this.id});

  Photos.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    publicId = json['publicId'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photo;
    data['publicId'] = publicId;
    data['_id'] = id;
    return data;
  }
}

class FriendRequests {
  String? id;
  String? name;
  int? age;
  String? gender;
  String? snapchat;
  String? instagram;
  String? twitter;
  List<Photos>? photos;

  FriendRequests(
      {this.id,
      this.name,
      this.age,
      this.gender,
      this.snapchat,
      this.instagram,
      this.twitter,
      this.photos});

  FriendRequests.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    snapchat = json['snapchat'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    data['snapchat'] = snapchat;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

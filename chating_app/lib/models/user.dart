class UserModel {
  late String id;
  late String name;
  late String email;
  late String about;
  late String image;
  late bool isOnline;
  late String createdAt;
  late String lastActive;
  late String pushToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.isOnline,
    required this.createdAt,
    required this.lastActive,
    required this.pushToken,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? '';
    name = json["name"] ?? '';
    email = json["email"] ?? '';
    about = json["about"] ?? '';
    image = json["image"] ?? '';
    isOnline = json["isOnline"] ?? '';
    createdAt = json["createdAt"] ?? '';
    lastActive = json["lastActive"] ?? '';
    pushToken = json["pushToken"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["about"] = about;
    data["image"] = image;
    data["isOnline"] = isOnline;
    data["createdAt"] = createdAt;
    data["lastActive"] = lastActive;
    data["pushToken"] = pushToken;
    return data;
  }
}

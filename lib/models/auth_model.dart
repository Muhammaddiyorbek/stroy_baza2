class AuthModel {
  final String phoneNumber;
  final String? accessToken;
  final String? refreshToken;
  final int? userId;
  final UserModel? user;

  AuthModel({
    required this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      phoneNumber: json['phone_number'] ?? '',
      accessToken: json['access'],
      refreshToken: json['refresh'],
      userId: json['id'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class UserModel {
  final int id;
  final String username;
  final String phoneNumber;
  final String? firstName;
  final String? lastName;

  UserModel({
    required this.id,
    required this.username,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
  });

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName'.trim();
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
class UserModel {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? token;
  final String? password;
  final String? otp;

  const UserModel({
    this.userId,
    this.otp,
    this.password,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
  });

  static UserModel empty = const UserModel(
      userId: '',
      firstName: '',
      lastName: '',
      email: '',
      token: '',
      password: '',
      otp: '');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      password: json['password'] ?? '',
      otp: json['otp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'otp': otp,
      'token': token,
      'password': password,
    };
  }
}

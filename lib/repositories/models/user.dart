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
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      token: json['token'],
      password: json['password'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'otp': otp,
      'token': token,
      'password': password,
    };
  }
}

class Auth {
  final String token;
  final Map<String, dynamic> user;

  Auth({required this.token, required this.user});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['token'],
      user: Map<String, dynamic>.from(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user,
    };
  }
}

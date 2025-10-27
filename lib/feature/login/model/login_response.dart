class LoginResponse {
  String? token;
  String? message;
  dynamic data;
  String? username;
  String? email;
  bool? success;

  LoginResponse({
    this.token,
    this.message,
    this.data,
    this.username,
    this.email,
    this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    // token bisa berada di root atau di dalam data
    final tokenFromRoot = json['token']?.toString();
    final data = json['data'];
    final tokenFromData = (data is Map) ? data['token']?.toString() : null;
    final message =
        json['message']?.toString() ??
        (data is Map ? data['message']?.toString() : null);
    final success = json['success'];

    return LoginResponse(
      token: tokenFromRoot ?? tokenFromData,
      message: message,
      data: data,
      success: success,
      username: json['username']?.toString(),
      email: json['email']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      'message': message,
      'data': data,
      'success': success,
    };
  }
}

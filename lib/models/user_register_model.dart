class UserRegisterModel {
  String? username;
  String? email;
  String? password;

  UserRegisterModel();

  String toJson() {
    String jsonData = '{';
    jsonData += '"username": "$username",';
    jsonData += '"email": "$email",';
    jsonData += '"password": "$password"';
    jsonData += '}';

    return jsonData;
  }

  UserRegisterModel.fromJson(Map<String, dynamic> map) {
    username = map['username'] as String;
    email = map['email'] as String;
    password = map['password'] as String;
  }
}

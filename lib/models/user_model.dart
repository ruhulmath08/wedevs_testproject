class UserModel {
  String? token;
  String? userEmail;
  String? userNiceName;
  String? userDisplayName;

  UserModel();

  String toJson() {
    String jsonData = '{';
    jsonData += '"token": "$token"';
    jsonData += '"user_email": "$userEmail"';
    jsonData += '"user_nicename": "$userNiceName"';
    jsonData += '"user_display_name": "$userDisplayName"';
    jsonData += '}';

    return jsonData;
  }

  UserModel.fromJson(Map<String, dynamic> map) {
    token = map['token'] as String;
    userEmail = map['user_email'] as String;
    userNiceName = map['user_nicename'] as String;
    userDisplayName = map['user_display_name'] as String;
  }
}

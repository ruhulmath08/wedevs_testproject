import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:wedevs_testproject/networks/app_exception.dart';

//here we will creates some common method for API call
class HttpHelper {
  Future<Response> postParamsData({
    required String url,
    required String username,
    required String password,
  }) async {
    final Uri uri = Uri.parse(url);
    final response = await post(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'username': username, 'password': password},
      encoding: Encoding.getByName('utf-8'),
    );
    return response;
  }

  Future<Response?> postData({required String url, required Map<String, String> header, required String body}) async {
    Response? responseJson;
    try {
      final Uri _url = Uri.parse(url);
      responseJson = await post(_url, headers: header, body: body);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }
}

//ToDo: for production ready application we will create our own message based on response code
// Response? _returnResponse(Response response) {
//   switch (response.statusCode) {
//     case 200:
//       return response;
//     case 400:
//       try {
//         final Map<dynamic, dynamic> responseJson = json.decode(response.body) as Map<dynamic, dynamic>;
//         final data = responseJson['message'];
//         //throw BadRequestException("Technical error. Please contact with your support team");
//         throw BadRequestException(data.toString());
//       } catch (e) {
//         log('', error: e.toString());
//       }
//       break;
//     case 412:
//       return response;
//     case 401:
//       //TokenHandler.refreshToken();
//       final Map<dynamic, dynamic> responseJson = json.decode(response.body) as Map;
//       final data = responseJson['message'];
//       //throw UnauthorisedException("Unauthorised do this task");
//       throw UnauthorisedException(data.toString());
//     case 403:
//       final Map<dynamic, dynamic> responseJson = json.decode(response.body) as Map;
//       final data = responseJson['message'];
//       //throw UnauthorisedException("Unauthorised do this task");
//       throw UnauthorisedException(data.toString());
//     case 500:
//       throw InternalServerException('Internal Server error');
//     default:
//       final Map<dynamic, dynamic> responseJson = json.decode(response.body) as Map;
//       throw FetchDataException('Server side error. Please contact with your support team');
//   }
// }

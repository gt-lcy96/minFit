import 'package:get/get.dart';
import 'package:min_fitness/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    // token = AppConstants.TOKEN;
    token = sharedPreferences.getString(AppConstant.TOKEN) ?? "";
    _mainHeaders = {
      'Content-type': 'application/json;  charset=UTF-8',
      'Authorization': 'Token $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json;  charset=UTF-8',
      // 'Authorization': 'Token $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers??_mainHeaders);
      return response;
    } catch (e) {
      print('Exception in getData: ${e}');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}

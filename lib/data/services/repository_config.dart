import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

const String baseUrl = "https://newsapi.org";
const String apiKey = "a2c549711e4f4e529a0f1d882d505e1a";
final String startDate = DateFormat("yyyy-MM-dd").format(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day-1));
final String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

class APIRequest {
  final String url;

  APIRequest({required this.url});

  Dio _dio() {
    return Dio(BaseOptions(
        headers: {'Content-Type': 'application/json'}));
  }

  void get(
      {Function()? beforeSend,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) {
    _dio().get(url).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}

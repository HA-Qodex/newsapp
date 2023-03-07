import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

const String baseUrl = "https://newsapi.org";
const String apiKey = "a2c549711e4f4e529a0f1d882d505e1a";
final String startDate = DateFormat("yyyy-MM-dd").format(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day-1));
final String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

Dio dio() {
  return Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {'Content-Type': 'application/json'}));
}
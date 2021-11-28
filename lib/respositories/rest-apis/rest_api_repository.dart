import 'package:dio/dio.dart';
import 'package:yukti/constants/constants.dart';
import 'package:yukti/models/attendance.dart';
import 'package:yukti/respositories/rest-apis/base_rest_api_repo.dart';

class RestAPIsRepository extends BaseRestAPIsRepositoy {
  final _dio = Dio();

  Future<Attendance?> getAttendnace({required String? enrollmentNo}) async {
    try {
      final response = await _dio.get(Urls.toc);
      if (response.statusCode == 200) {
        final data = response.data;
        print('Data $data');
        print('Data ${data.runtimeType}');
      }
    } catch (error) {
      print('Error getting attendace');
    }
  }
}

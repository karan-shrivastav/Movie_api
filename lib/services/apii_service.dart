import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://api.themoviedb.org/3/';
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZDRmZDU0YWU4OTM1YzZmYTBjODc5OTczZGRlNWU1ZiIsIm5iZiI6MTcyNjU3OTAwNi4yNjUyMSwic3ViIjoiNjZlOTgwNmQ4MmZmODczZjdkMWViYjJlIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.8Rq7fX_OOaXBfPbj-x039NTyFUNoHC8wqmcknYeQsDI';

  Future<http.Response> apiCall(
    String endPoint,
  ) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('$baseUrl$endPoint');
    var response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}

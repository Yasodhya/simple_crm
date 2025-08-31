/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class MockApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users'; // Example

  Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Customer(
        id: json['id'], // optional if you want to use API IDs
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        company: json['company'] != null ? json['company']['name'] : '',
      )).toList();
    } else {
      throw Exception('Failed to fetch customers from API');
    }
  }
}*/

import 'dart:convert';

import 'package:http/http.dart' as http;

class EventRepository {
  EventRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _baseUrl = 'http://localhost:8080/api';

  Future<void> createEvent(
      {required String duration,
      required String date,
      required String time}) async {
    final uri = Uri.parse('$_baseUrl/Event/create');
    final body = jsonEncode({
      'duration': duration,
      'time': time,
      'date': date,
      'participants': [1], // TODO: integrate real participant ids
    });
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: body,
    );
    if (response.statusCode != 200) throw Exception('Failed to create event');
  }
}

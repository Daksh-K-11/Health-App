import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shriwin/const.dart';

class History extends StatefulWidget {
  const History({super.key, required this.userId});

  final int userId;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      // Fetch history data from the backend
      final response = await http.get(Uri.parse('$api/disease/'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        setState(() {
          _history = responseData.map((data) {
            return {
              'id': data['id'],
              'disease': (jsonDecode(data['disease']) as List<dynamic>)
                  .join(', '), // Parse diseases
              'date': data['date'],
            };
          }).toList();
        });
      } else {
        // Handle error
        setState(() {
          _history = [];
        });
      }
    } catch (e) {
      // Handle exceptions
      setState(() {
        _history = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _history.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _history.length,
            itemBuilder: (context, index) {
              final item = _history[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prediction #${item['id']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Diseases: ${item['disease']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date: ${item['date']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shriwin/const.dart';

class HospitalDetailPage extends StatefulWidget {
  final int hospitalId;

  const HospitalDetailPage({super.key, required this.hospitalId});

  @override
  HospitalDetailPageState createState() => HospitalDetailPageState();
}

class HospitalDetailPageState extends State<HospitalDetailPage> {
  Map<String, dynamic>? hospitalDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHospitalDetails();
  }

  Future<void> fetchHospitalDetails() async {
    final response = await http.get(Uri.parse('$api/hospitals/${widget.hospitalId}/'));

    if (response.statusCode == 200) {
      setState(() {
        hospitalDetails = json.decode(response.body);
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hospitalDetails == null) {
      return const Scaffold(
        body: Center(child: Text('Failed to load hospital details')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(hospitalDetails!['name'],
        style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                hospitalDetails!['image'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              hospitalDetails!['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${hospitalDetails!['address']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.call),
                const SizedBox(width: 5),
                Text(
                  '${hospitalDetails!['contact_number']}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${hospitalDetails!['specialties']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to call the hospital using the contact number
              },
              child: const Text('Call Hospital'),
            ),
          ],
        ),
      ),
    );
  }
}

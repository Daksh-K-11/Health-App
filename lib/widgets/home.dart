import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shriwin/const.dart';
import 'package:shriwin/pages/hospital_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> hospitals = [];
  List<dynamic> filteredHospitals = [];
  TextEditingController searchController = TextEditingController();
  String? selectedSpecialty;
  List<String> specialties = ['All'];

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final response = await http.get(Uri.parse('$api/hospitals/'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> hospitalList = json.decode(response.body);
      print(response.body);
      setState(() {
        hospitals = hospitalList;
        filteredHospitals = hospitalList;
        // Add specialties to the filter dropdown
        specialties.addAll(hospitalList
            .map((hospital) => hospital['specialties'].toString())
            .toSet());
      });
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  void filterHospitals() {
    List<dynamic> tempList = hospitals;

    // Filter by search query
    if (searchController.text.isNotEmpty) {
      tempList = tempList
          .where((hospital) => hospital['name']
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    // Filter by specialty
    // if (selectedSpecialty != null && selectedSpecialty != 'All') {
    //   tempList = tempList
    //       .where((hospital) => hospital['specialties'] == selectedSpecialty)
    //       .toList();
    // }

    // setState(() {
    //   filteredHospitals = tempList;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    filterHospitals();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search hospitals...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // DropdownButton<String>(
              //   value: selectedSpecialty,
              //   hint: const Text('Filter by specialty'),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedSpecialty = newValue;
              //       filterHospitals();
              //     });
              //   },
              //   items:
              //       specialties.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredHospitals.length,
            itemBuilder: (context, index) {
              final hospital = filteredHospitals[index];
              return Card(
                color: Colors.blueGrey[100],
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            HospitalDetailPage(hospitalId: hospital['id']))),
                    leading: Image.network(
                      hospital['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(hospital['name']),
                    subtitle: Text(hospital['specialties']),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded)),
              );
            },
          ),
        ),
      ],
    );
  }
}

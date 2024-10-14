// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:shriwin/const.dart';

// class CheckUp extends StatefulWidget {
//   const CheckUp({super.key, required this.id});

//   final int id;

//   @override
//   State<CheckUp> createState() => _CheckUpState();
// }

// class _CheckUpState extends State<CheckUp> {
//   File? _selectedImage;
//   String _prediction = '';
//   final ImagePicker _picker = ImagePicker();
//   String _selectedType = 'Skin'; // Default selection

//   // Dropdown options for predictions
//   final List<String> _predictionTypes = ['Skin', 'Eye'];

//   // Function to pick an image from the gallery
//   Future<void> _pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to capture an image with the camera
//   Future<void> _captureImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to send the image to the backend and get the prediction
//   Future<void> _predict() async {
//     if (_selectedImage == null) return;

//     // Determine the correct API endpoint based on the selected type
//     final String endpoint = _selectedType == 'Skin' ? '1' : '2';
//     final url = Uri.parse('$api/predict/$endpoint/');

//     var request = http.MultipartRequest('POST', url);
//     request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));

//     // Add the user ID to the request body
//     request.fields['user'] = widget.id.toString();

//     final response = await request.send();
//     final resString = await response.stream.bytesToString();

//     if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(resString);
//       final topPredictions = decodedResponse['top_3_predictions'] as List<dynamic>;

//       // Format the predictions to display
//       setState(() {
//         _prediction = topPredictions.join(', ');
//       });
//     } else {
//       setState(() {
//         _prediction = 'Error in prediction';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Dropdown to select between Skin and Eye
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Select Type: ',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 10),
//               DropdownButton<String>(
//                 value: _selectedType,
//                 items: _predictionTypes.map((String type) {
//                   return DropdownMenuItem<String>(
//                     value: type,
//                     child: Text(type),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedType = newValue!;
//                   });
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           if (_selectedImage == null) ...[
//             Container(
//               decoration: BoxDecoration(border: Border.all()),
//               width: double.infinity,
//               height: 400,
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: const Center(
//                 child: Text(
//                   'Select or Capture an Image',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: _pickImageFromGallery,
//                   icon: const Icon(Icons.photo),
//                   label: const Text('Gallery'),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: _captureImage,
//                   icon: const Icon(Icons.camera),
//                   label: const Text('Camera'),
//                 ),
//               ],
//             ),
//           ] else ...[
//             Image.file(
//               _selectedImage!,
//               width: double.infinity,
//               height: 400,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _predict,
//               child: const Text('Predict'),
//             ),
//           ],
//           const SizedBox(height: 25.0),
//           if (_prediction.isNotEmpty)
//             Text(
//               'Predictions: $_prediction',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//         ],
//       ),
//     );
//   }
// }












import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shriwin/const.dart';
import 'package:shriwin/pages/symptom_check.dart';


class CheckUp extends StatefulWidget {
  const CheckUp({super.key, required this.id});

  final int id;

  @override
  State<CheckUp> createState() => _CheckUpState();
}

class _CheckUpState extends State<CheckUp> {
  File? _selectedImage;
  String _prediction = '';
  final ImagePicker _picker = ImagePicker();
  String _selectedType = 'Skin'; // Default selection
  List<String> _predictedDiseases = []; // Store the predicted diseases

  // Dropdown options for predictions
  final List<String> _predictionTypes = ['Skin', 'Eye'];

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to capture an image with the camera
  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to send the image to the backend and get the prediction
  Future<void> _predict() async {
    if (_selectedImage == null) return;

    // Determine the correct API endpoint based on the selected type
    final String endpoint = _selectedType == 'Skin' ? '1' : '2';
    final url = Uri.parse('$api/predict/$endpoint/');

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));

    // Add the user ID to the request body
    request.fields['user'] = widget.id.toString();

    final response = await request.send();
    final resString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(resString);
      final topPredictions = decodedResponse['top_3_predictions'] as List<dynamic>;

      // Format the predictions to display
      setState(() {
        _predictedDiseases = List<String>.from(topPredictions); // Store predictions
        _prediction = _predictedDiseases.join(', ');
      });
    } else {
      setState(() {
        _prediction = 'Error in prediction';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Dropdown to select between Skin and Eye
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select Type: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedType,
                items: _predictionTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_selectedImage == null) ...[
            Container(
              decoration: BoxDecoration(border: Border.all()),
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Center(
                child: Text(
                  'Select or Capture an Image',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: _captureImage,
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                ),
              ],
            ),
          ] else ...[
            Image.file(
              _selectedImage!,
              width: double.infinity,
              height: 400,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _predict,
              child: const Text('Predict'),
            ),
          ],
          const SizedBox(height: 25.0),
          if (_prediction.isNotEmpty) ...[
            // Text(
            //   'Predictions: $_prediction',
            //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SymptomCheck(
                      diseases: _predictedDiseases,
                    ),
                  ),
                );
              },
              child: const Text('Proceed to Symptom Check'),
            ),
          ],
        ],
      ),
    );
  }
}

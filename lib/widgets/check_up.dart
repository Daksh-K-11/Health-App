import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shriwin/const.dart';

class CheckUp extends StatefulWidget {
  const CheckUp({super.key});

  @override
  State<CheckUp> createState() => _CheckUpState();
}

class _CheckUpState extends State<CheckUp> {
  File? _selectedImage;
  String _prediction = '';
  final ImagePicker _picker = ImagePicker();

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

    // Replace with your backend URL
    final url = Uri.parse('$api/predict/1/');

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
    
    final response = await request.send();
    final resString = await response.stream.bytesToString();
    
    if (response.statusCode == 200) {
      setState(() {
        _prediction = jsonDecode(resString)['predictions'];
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
            if (_prediction.isNotEmpty)
              Text(
                'Prediction: $_prediction',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
    );
  }
}

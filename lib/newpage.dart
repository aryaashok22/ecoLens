import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _resultMessage = 'Upload or Capture an image to get results.';
  String _plasticComposition = '';
  String _plasticType = '';

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return; // Handle cancellation
      setState(() {
        _image = image;
        _processImage();
      });
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return; // Handle cancellation
      setState(() {
        _image = image;
        _processImage();
      });
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
  }

  void _processImage() {
    setState(() {
      _resultMessage = 'Recyclable'; // Example result
      _plasticComposition = 'Polyethylene Terephthalate (PET)';
      _plasticType = 'Plastic Bottle';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture or Upload Image'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Capture and Upload Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _captureImage,
                  icon: const Icon(Icons.camera_alt,
                      size: 40, color: Colors.green),
                  tooltip: 'Capture Image',
                ),
                IconButton(
                  onPressed: _uploadImage,
                  icon: const Icon(Icons.upload, size: 40, color: Colors.green),
                  tooltip: 'Upload Image',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Placeholder or Display Image
            _image == null
                ? const Icon(Icons.image, size: 150, color: Colors.grey)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_image!.path),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(height: 20),

            // Results Section
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result: $_resultMessage',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _resultMessage == 'Recyclable'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Plastic Composition: $_plasticComposition',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Plastic Type: $_plasticType',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

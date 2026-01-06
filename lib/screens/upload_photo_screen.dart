import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/photo_provider.dart';
import '../utils/image_helper.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  XFile? _image;
  Uint8List? _imageBytes;
  final TextEditingController _captionController = TextEditingController();

  Future<void> _pick(ImageSource source) async {
    final file = await ImageHelper.pickImage(source);
    if (file == null || !mounted) return;

    final bytes = await file.readAsBytes();

    setState(() {
      _image = file;
      _imageBytes = bytes;
    });
  }

  Future<void> _upload() async {
    if (_imageBytes == null) return;

    final imageUrl = await context
        .read<PhotoProvider>()
        .uploadPhoto(_imageBytes!, _captionController.text);

    if (!mounted) return;

    if (imageUrl != null) {
      Navigator.pop(context, true); // ⬅️ balik ke Photos
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Photo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey[300],
              child: _imageBytes != null
                  ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                  : const Icon(Icons.add_a_photo, size: 60),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
                TextButton.icon(
                  onPressed: () => _pick(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
              ],
            ),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 20),
            Consumer<PhotoProvider>(
              builder: (_, provider, __) {
                if (provider.isUploading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: _imageBytes != null ? _upload : null,
                  child: const Text('Upload'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

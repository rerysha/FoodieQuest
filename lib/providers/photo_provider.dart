import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/food_photo.dart';
import '../services/image_service.dart';

class PhotoProvider with ChangeNotifier {
  final ImageService _service = ImageService();

  List<FoodPhoto> _photos = [];
  List<FoodPhoto> get photos => _photos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  Future<void> fetchPhotos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _photos = await _service.getPhotos();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ⬅️ RETURN IMAGE URL
  Future<String?> uploadPhoto(Uint8List bytes, String caption) async {
    _isUploading = true;
    notifyListeners();

    try {
      final imageUrl = await _service.uploadImageBytes(bytes);
      if (imageUrl == null) return null;

      await _service.savePhotoData(imageUrl, caption);
      await fetchPhotos();
      return imageUrl;
    } catch (e) {
      debugPrint('❌ Upload error: $e');
      return null;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import '../models/food_photo.dart';

class ImageService {
  final SupabaseClient _client = SupabaseService.client;

  // =========================
  // UPLOAD IMAGE (WEB & ANDROID)
  // =========================
  Future<String?> uploadImageBytes(Uint8List bytes) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _client.storage.from('food-photos').uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );

      return _client.storage.from('food-photos').getPublicUrl(fileName);
    } catch (e) {
      debugPrint('❌ Upload error: $e');
      return null;
    }
  }

  // =========================
  // SAVE METADATA
  // =========================
  Future<void> savePhotoData(String imageUrl, String caption) async {
    await _client.from('food_photos').insert({
      'image_url': imageUrl,
      'caption': caption,
    });
  }

  // =========================
  // FETCH PHOTOS
  // =========================
  Future<List<FoodPhoto>> getPhotos() async {
    final response = await _client
        .from('food_photos')
        .select()
        .order('created_at', ascending: false);

    final List data = response as List;
    return data.map((e) => FoodPhoto.fromJson(e)).toList();
  }
}

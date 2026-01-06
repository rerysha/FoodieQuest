import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';
import 'supabase_service.dart';

class RecipeApi {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<Recipe>> getRecipes() async {
    try {
      print('🔄 Fetching recipes...');

      final response = await _client
          .from('recipes')
          .select()
          .order('created_at', ascending: false);

      print('✅ Got ${response.length} recipes');

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error fetching recipes: $e');
      rethrow;
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      print('🔍 Searching recipes: $query');

      final response = await _client
          .from('recipes')
          .select()
          .ilike('title', '%$query%')
          .order('created_at', ascending: false);

      print('✅ Found ${response.length} recipes');

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error searching recipes: $e');
      rethrow;
    }
  }
}
// ```

// ### 5. **Debug: Cek file mana yang masih punya timeout**

// Buka file-file ini dan pastikan **TIDAK ADA** `.timeout(const Duration(milliseconds: 50))`:

// - ✅ `lib/services/recipe_api.dart`
// - ✅ `lib/services/image_service.dart`
// - ❓ `lib/providers/recipe_provider.dart`
// - ❓ `lib/providers/photo_provider.dart`

// ### 6. **Restart Flutter Dev Tools**

// Kadang cache Flutter masih menyimpan kode lama:

// 1. **Stop** aplikasi sepenuhnya (tekan Stop di IDE)
// 2. **Tutup** emulator/device
// 3. **Buka lagi** dan run

// ---

// ## 🎯 Yang Harus Terjadi:

// Setelah fix, console harus menunjukkan:
// ```
// ✅ Supabase OK: 1 recipes found
// 🔄 Fetching recipes...
// ✅ Got 3 recipes
// ```

// **BUKAN:**
// ```
// ❌ TimeoutException after 0:00:00.050000

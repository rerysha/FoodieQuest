import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_api.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeApi _api = RecipeApi();

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  final Set<int> _favoriteIds = {};
  Set<int> get favoriteIds => _favoriteIds;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _api.getRecipes();
      _error = null;
    } catch (e) {
      _error = 'Gagal memuat resep: $e';
      debugPrint("❌ Error fetching recipes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchRecipes(String query) async {
    if (query.isEmpty) {
      await fetchRecipes();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _api.searchRecipes(query);
      _error = null;
    } catch (e) {
      _error = 'Gagal mencari resep: $e';
      debugPrint("❌ Error searching recipes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(int recipeId) {
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
    } else {
      _favoriteIds.add(recipeId);
    }
    notifyListeners(); // ⚠️ PENTING: Tanpa ini UI tidak akan update!
  }

  bool isFavorite(int recipeId) {
    return _favoriteIds.contains(recipeId);
  }

  List<Recipe> get favoriteRecipes {
    return _recipes.where((r) => _favoriteIds.contains(r.id)).toList();
  }

  // Tambahan: Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Tambahan: Get recipe by ID
  Recipe? getRecipeById(int id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}

class Recipe {
  final int id;
  final String title;
  final String description;
  final String ingredients;
  final String instructions;
  final String imageUrl;
  final double rating;
  final DateTime? createdAt;

  Recipe({
    required this.id,
    required this.title,
    this.description = '', // Bisa kosong, default ''
    required this.ingredients,
    required this.instructions,
    this.imageUrl = '', // Bisa kosong, default ''
    this.rating = 0.0,
    this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Untitled Recipe',
      description: json['description'] as String? ?? '',
      ingredients: json['ingredients'] as String? ?? 'No ingredients',
      instructions: json['instructions'] as String? ??
          'No instructions', // ⚠️ PERBAIKI TYPO!
      imageUrl: json['image_url'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'image_url': imageUrl,
      'rating': rating,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // 🎯 Helper: Parse ingredients string menjadi List untuk UI
  List<String> get ingredientsList {
    if (ingredients.isEmpty) return ['No ingredients listed'];

    // Split by newline atau comma
    List<String> items;
    if (ingredients.contains('\n')) {
      items = ingredients.split('\n');
    } else if (ingredients.contains(',')) {
      items = ingredients.split(',');
    } else {
      items = [ingredients];
    }

    return items.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  // 🎯 Helper: Parse instructions string menjadi List untuk UI
  List<String> get instructionsList {
    if (instructions.isEmpty) return ['No instructions provided'];

    // Split by newline
    List<String> items;
    if (instructions.contains('\n')) {
      items = instructions.split('\n');
    } else if (instructions.contains('.')) {
      // Fallback: split by sentence
      items = instructions.split(RegExp(r'\.\s+'));
    } else {
      items = [instructions];
    }

    return items.map((e) => e.trim()).where((e) => e.isNotEmpty).map((e) {
      // Remove numbering if exists (e.g., "1. Mix" -> "Mix")
      final match = RegExp(r'^\d+\.\s*').firstMatch(e);
      if (match != null) {
        return e.substring(match.end);
      }
      return e;
    }).toList();
  }

  // 🎯 Helper: Check if recipe has valid image
  bool get hasImage => imageUrl.isNotEmpty && imageUrl.startsWith('http');

  // 🎯 Helper: Format rating text
  String get ratingText {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4.0) return 'Very Good';
    if (rating >= 3.5) return 'Good';
    if (rating >= 3.0) return 'Average';
    return 'Below Average';
  }

  // 🎯 Helper: Get rating stars (for UI)
  int get fullStars => rating.floor();
  bool get hasHalfStar => (rating - fullStars) >= 0.5;
  int get emptyStars => 5 - fullStars - (hasHalfStar ? 1 : 0);
}

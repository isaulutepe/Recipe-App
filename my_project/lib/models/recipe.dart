//Json to dart yapmak için
class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty;
  final String cuisine;
  final String image;
  final double rating;
  final List<String> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.image,
    required this.rating,
    required this.mealType,
  });
  //Normal constructor'dan farklı olarak nesnenin oluşturulma sürecini kontrol etmemize ve dönüştürme işlemlerini yapmamıza imkân tanır.
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      name: json["name"],
      ingredients: List<String>.from(json["ingredients"]),
      instructions: List<String>.from(json["instructions"]),
      prepTimeMinutes: json["prepTimeMinutes"],
      cookTimeMinutes: json["cookTimeMinutes"],
      servings: json["servings"],
      difficulty: json["difficulty"],
      cuisine: json["cuisine"],
      image: json["image"],
      rating: (json["rating"] as num).toDouble(),
      mealType: List<String>.from(json["mealType"]),
    );
  }
}

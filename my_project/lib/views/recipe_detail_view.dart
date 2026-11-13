import 'package:flutter/material.dart';
import 'package:my_project/services/favorite_service%20.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Recipe Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: Image.network(
                            recipe.image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 220,
                                color: Colors.grey,
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 40),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Consumer<FavoriteService>(
                            builder: (context, favoriteService, child) {
                              final isFavorite = favoriteService.isFavorite(
                                recipe,
                              );

                              return Material(
                                color: Colors.white.withOpacity(0.85),
                                shape: const CircleBorder(),
                                child: IconButton(
                                  // ✅ İkon tıklaması InkWell'e sızmasın
                                  onPressed: () {
                                    if (isFavorite) {
                                      favoriteService.removeFavorite(recipe);
                                    } else {
                                      favoriteService.addFavorite(recipe);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : Colors.black,
                                    size: 26,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Name
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Cuisine and Difficulty
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildTag(Icons.restaurant, recipe.cuisine),
                      _buildTag(Icons.signal_cellular_alt, recipe.difficulty),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Recipe Information
                  const Text(
                    "Recipe Information",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildInfoItem(
                        Icons.timer_outlined,
                        "Preparation",
                        "${recipe.prepTimeMinutes} min",
                      ),
                      _buildInfoItem(
                        Icons.local_fire_department_outlined,
                        "Cooking",
                        "${recipe.cookTimeMinutes} min",
                      ),
                      _buildInfoItem(
                        Icons.star_outline,
                        "Rating",
                        recipe.rating.toString(),
                      ),
                      _buildInfoItem(
                        Icons.people_outline,
                        "Servings",
                        recipe.servings.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Ingredients list
                  ...recipe.ingredients.map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 30),

                  const Text(
                    "Instructions",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Instructions list (indexed)
                  ...recipe.instructions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.orange,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              instruction,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tag Widget
Widget _buildTag(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.orange, size: 17),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.black, fontSize: 13)),
      ],
    ),
  );
}

// Information Card
Widget _buildInfoItem(IconData icon, String title, String value) {
  return Container(
    width: 170,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.orange),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.orange, size: 22),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 12)),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

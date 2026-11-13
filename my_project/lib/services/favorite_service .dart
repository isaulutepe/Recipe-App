import 'package:flutter/material.dart';

import '../models/recipe.dart';

//Diğer sayfalarında yapılan değişikliklerden haberdar olması için changeNotifier kullandım.
class FavoriteService extends ChangeNotifier {
  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  void addFavorite(Recipe recipe) {
    if (!isFavorite(recipe)) {
      _favorites.add(recipe);
      notifyListeners(); //Bu metot çalıştığında servisi dinleyen widget'lar değişiklikten haberdar olur.
    }
  }

  void removeFavorite(Recipe recipe) {
    _favorites.removeWhere((item) => item.id == recipe.id);
    notifyListeners();
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((item) => item.id == recipe.id);
  }
}

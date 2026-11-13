import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
class RecipeService {
  final String baseUrl = "https://dummyjson.com/recipes";
  //Future, Dart'ta asenkron işlemlerin sonucunu temsil eder.
  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode != 200) {
        throw Exception("Tarifler yüklenemedi.");
      }
      final jsonData = jsonDecode(response.body);
      final recipes = jsonData["recipes"];
      //map --> Listedeki her elemanı işler
      return recipes.map<Recipe>((recipe) {
        return Recipe.fromJson(recipe);
      }).toList();
    } catch (e) {
      print(e);
      rethrow; //hatayı yeniden firlatmak için
    }
  }
}

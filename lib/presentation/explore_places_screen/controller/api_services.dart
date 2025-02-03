import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cardslist_item_model.dart';

class ApiService {
  static const String apiUrl = "https://kings-egy.vercel.app/kimo";

  static Future<List<CardslistItemModel>> fetchPlaces() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => CardslistItemModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load places");
      }
    } catch (e) {
      print("Error fetching places: $e");
      return [];
    }
  }
}

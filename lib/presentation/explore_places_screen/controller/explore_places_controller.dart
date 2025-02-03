import 'package:get/get.dart';
import 'package:hierosecret/presentation/explore_places_screen/controller/api_services.dart';
import 'package:hierosecret/presentation/explore_places_screen/models/cardslist_item_model.dart';

class ExplorePlacesController extends GetxController {
  RxList<CardslistItemModel> explorePlacesList = <CardslistItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    try {
      print('Fetching places from API...');
      List<CardslistItemModel> places = await ApiService.fetchPlaces();

      // Clear the existing list before updating
      explorePlacesList.clear();

      // Add new places to the list
      explorePlacesList.addAll(places);

      print('Places fetched successfully: ${places.length}');
    } catch (e) {
      print('Error fetching places: $e');
      // Handle the error appropriately (e.g., show a message to the user)
    }
  }
}

class CardslistItemModel {
  final String name;
  final double latitude;
  final double longitude;
  final double rate;
  final String description;

  CardslistItemModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.description,
  });

  factory CardslistItemModel.fromJson(Map<String, dynamic> json) {
    return CardslistItemModel(
      name: json["Name"],
      latitude: json["Address"][0].toDouble(),
      longitude: json["Address"][1].toDouble(),
      rate: json["Rate"].toDouble(),
      description: json["Description"],
    );
  }
}

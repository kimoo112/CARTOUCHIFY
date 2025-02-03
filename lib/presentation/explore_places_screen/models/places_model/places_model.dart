class PlacesModel {
  String? name;
  List<double>? address;
  double? rate;
  String? description;

  PlacesModel({this.name, this.address, this.rate, this.description});

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      name: json['Name'] as String?,
      address: (json['Address'] as List<dynamic>?)
          ?.map((item) => (item as num).toDouble())
          .toList(),
      rate: (json['Rate'] as num?)?.toDouble(),
      description: json['Description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Address': address,
        'Rate': rate,
        'Description': description,
      };
}

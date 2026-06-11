class CardTypeModel {
  final int id;
  final String name;

  CardTypeModel({required this.id, required this.name});

  factory CardTypeModel.fromJson(Map<String, dynamic> json) {
    return CardTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }
  toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  
  @override
  toString() {
    return 'CardTypeModel{id: $id, name: $name}';
  }
}
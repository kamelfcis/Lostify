class ItemTypeModel {
  final String name;
  final int id;

  ItemTypeModel({required this.name, required this.id});
  factory ItemTypeModel.fromJson(Map<String, dynamic> json) {
    return ItemTypeModel(name: json['name'], id: json['id']);
  }
  toJson() => {'name': name, 'id': id};
}

class ChecklistItem {
  int id;
  String name;
  String description;
  String category;
  int quantity;
  String photos;

  ChecklistItem(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.quantity,
      this.photos});

  ChecklistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['photos'] = this.photos;
    return data;
  }

  bool hasPhotos() {
    return this.photos.isNotEmpty;
  }

  List<String> getPhotos() {
    if (!hasPhotos()) return [];

    return this.photos.split(',');
  }
}

class Category {
  String? name;
  String? image;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Category({this.name, this.image, this.sId, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

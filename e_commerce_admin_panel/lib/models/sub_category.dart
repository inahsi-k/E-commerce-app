class SubCategory {
  String? name;
  CategoryId? categoryId;
  String? sId;
  String? createdAt;
  String? updatedAt;

  SubCategory(
      {this.name, this.categoryId, this.sId, this.createdAt, this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['categoryId'] = categoryId;
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CategoryId {
  String? sId;
  String? name;

  CategoryId({this.sId, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
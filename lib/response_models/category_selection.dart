class CategorySelectionModel {
  String apiMethod;
  List<SelectedCategories> categories;
  String mobileUniqueCode;

  CategorySelectionModel(
      {this.apiMethod, this.categories, this.mobileUniqueCode});

  CategorySelectionModel.fromJson(Map<String, dynamic> json) {
    apiMethod = json['apiMethod'];
    if (json['categories'] != null) {
      categories = new List<SelectedCategories>();
      json['categories'].forEach((v) {
        categories.add(new SelectedCategories.fromJson(v));
      });
    }
    mobileUniqueCode = json['mobileUniqueCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiMethod'] = this.apiMethod;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['mobileUniqueCode'] = this.mobileUniqueCode;
    return data;
  }
}

class SelectedCategories {
  String categoryId;
  String isSelected;

  SelectedCategories({this.categoryId, this.isSelected});

  SelectedCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

class FilterSelection {
  String apiMethod;
  String productId;
  String searchString;
  List<Categories> categories;
  String priceFrom;
  String priceTo;
  String sorting;
  String mobileUniqueCode;

  FilterSelection(
      {this.apiMethod,
      this.productId,
      this.searchString,
      this.categories,
      this.priceFrom,
      this.priceTo,
      this.sorting,
      this.mobileUniqueCode});

  FilterSelection.fromJson(Map<String, dynamic> json) {
    apiMethod = json['apiMethod'];
    productId = json['productId'];
    searchString = json['searchString'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    priceFrom = json['priceFrom'];
    priceTo = json['priceTo'];
    sorting = json['sorting'];
    mobileUniqueCode = json['mobileUniqueCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiMethod'] = this.apiMethod;
    data['productId'] = this.productId;
    data['searchString'] = this.searchString;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['priceFrom'] = this.priceFrom;
    data['priceTo'] = this.priceTo;
    data['sorting'] = this.sorting;
    data['mobileUniqueCode'] = this.mobileUniqueCode;
    return data;
  }
}

class Categories {
  String categoryId;

  Categories({this.categoryId});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    return data;
  }
}

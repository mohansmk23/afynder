class FilterSelection {
  String apiMethod;
  String productId;
  String searchString;
  String pageNo;
  String apkPageName;
  List<Categories> categories;
  String listingType;
  String priceFrom;
  String priceTo;
  String sorting;
  String mobileUniqueCode;

  FilterSelection(
      {this.apiMethod,
      this.productId,
      this.searchString,
      this.pageNo,
      this.apkPageName,
      this.categories,
      this.listingType,
      this.priceFrom,
      this.priceTo,
      this.sorting,
      this.mobileUniqueCode});

  FilterSelection.fromJson(Map<String, dynamic> json) {
    apiMethod = json['apiMethod'];
    productId = json['productId'];
    searchString = json['searchString'];
    pageNo = json['pageNo'];
    apkPageName = json['apkPageName'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    listingType = json['ListingType'];
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
    data['pageNo'] = this.pageNo;
    data['apkPageName'] = this.apkPageName;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['ListingType'] = this.listingType;
    data['priceFrom'] = this.priceFrom;
    data['priceTo'] = this.priceTo;
    data['sorting'] = this.sorting;
    data['mobileUniqueCode'] = this.mobileUniqueCode;
    return data;
  }
}

class Categories {
  String categoryId;
  String categoryName;

  Categories({this.categoryId, this.categoryName});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    return data;
  }
}

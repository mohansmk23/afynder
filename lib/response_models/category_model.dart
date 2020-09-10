class CategoryModel {
  String status;
  String message;
  CategoryAllList categoryAllList;
  List<CategoryList> categoryList;

  CategoryModel(
      {this.status, this.message, this.categoryAllList, this.categoryList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    categoryAllList = json['categoryAllList'] != null
        ? new CategoryAllList.fromJson(json['categoryAllList'])
        : null;
    if (json['CategoryList'] != null) {
      categoryList = new List<CategoryList>();
      json['CategoryList'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categoryAllList != null) {
      data['categoryAllList'] = this.categoryAllList.toJson();
    }
    if (this.categoryList != null) {
      data['CategoryList'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryAllList {
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String s8;
  String s9;
  String s10;
  String s11;
  String s12;
  String s13;
  String s14;
  String s15;
  String s16;
  String s17;
  String s18;

  CategoryAllList(
      {this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.s5,
      this.s6,
      this.s7,
      this.s8,
      this.s9,
      this.s10,
      this.s11,
      this.s12,
      this.s13,
      this.s14,
      this.s15,
      this.s16,
      this.s17,
      this.s18});

  CategoryAllList.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
    s8 = json['8'];
    s9 = json['9'];
    s10 = json['10'];
    s11 = json['11'];
    s12 = json['12'];
    s13 = json['13'];
    s14 = json['14'];
    s15 = json['15'];
    s16 = json['16'];
    s17 = json['17'];
    s18 = json['18'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    data['8'] = this.s8;
    data['9'] = this.s9;
    data['10'] = this.s10;
    data['11'] = this.s11;
    data['12'] = this.s12;
    data['13'] = this.s13;
    data['14'] = this.s14;
    data['15'] = this.s15;
    data['16'] = this.s16;
    data['17'] = this.s17;
    data['18'] = this.s18;
    return data;
  }
}

class CategoryList {
  String categoryId;
  String categoryName;
  String description;
  String categoryImage;
  String activeStatus;
  String createdAt;
  String updatedAt;
  String noOfListing;
  String isSelected;

  CategoryList(
      {this.categoryId,
      this.categoryName,
      this.description,
      this.categoryImage,
      this.activeStatus,
      this.createdAt,
      this.updatedAt,
      this.noOfListing,
      this.isSelected});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    description = json['description'];
    categoryImage = json['categoryImage'];
    activeStatus = json['activeStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    noOfListing = json['noOfListing'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['categoryImage'] = this.categoryImage;
    data['activeStatus'] = this.activeStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['noOfListing'] = this.noOfListing;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

class HomeScreenModel {
  String status;
  String message;
  List<ProductList> productList;
  List<ChoosenList> choosenList;

  HomeScreenModel(
      {this.status, this.message, this.productList, this.choosenList});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['productList'] != null) {
      productList = new List<ProductList>();
      json['productList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
    if (json['choosenList'] != null) {
      choosenList = new List<ChoosenList>();
      json['choosenList'].forEach((v) {
        choosenList.add(new ChoosenList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productList != null) {
      data['productList'] = this.productList.map((v) => v.toJson()).toList();
    }
    if (this.choosenList != null) {
      data['choosenList'] = this.choosenList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String productId;
  String shopId;
  String merchantId;
  String shopName;
  String productName;
  String productCode;
  String categoryId;
  String shopCategoryName;
  String shopLogo;
  String productDetails;
  String specifications;
  String actualAmount;
  String isOffer;
  String offerType;
  String offerAmount;
  String sellingAmount;
  List<String> productImages;
  String activeStatus;
  String createdAt;
  String updatedAt;

  ProductList(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productCode,
      this.categoryId,
      this.shopCategoryName,
      this.shopLogo,
      this.productDetails,
      this.specifications,
      this.actualAmount,
      this.isOffer,
      this.offerType,
      this.offerAmount,
      this.sellingAmount,
      this.productImages,
      this.activeStatus,
      this.createdAt,
      this.updatedAt});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productCode = json['productCode'];
    categoryId = json['category_id'];
    shopCategoryName = json['shopCategoryName'];
    shopLogo = json['shopLogo'];
    productDetails = json['productDetails'];
    specifications = json['specifications'];
    actualAmount = json['actualAmount'];
    isOffer = json['isOffer'];
    offerType = json['offerType'];
    offerAmount = json['offerAmount'];
    sellingAmount = json['sellingAmount'];
    productImages = json['productImages'].cast<String>();
    activeStatus = json['activeStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['shopId'] = this.shopId;
    data['merchantId'] = this.merchantId;
    data['shopName'] = this.shopName;
    data['productName'] = this.productName;
    data['productCode'] = this.productCode;
    data['category_id'] = this.categoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopLogo'] = this.shopLogo;
    data['productDetails'] = this.productDetails;
    data['specifications'] = this.specifications;
    data['actualAmount'] = this.actualAmount;
    data['isOffer'] = this.isOffer;
    data['offerType'] = this.offerType;
    data['offerAmount'] = this.offerAmount;
    data['sellingAmount'] = this.sellingAmount;
    data['productImages'] = this.productImages;
    data['activeStatus'] = this.activeStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ChoosenList {
  String productId;
  String shopId;
  String merchantId;
  String shopName;
  String productName;
  String productCode;
  String categoryId;
  String shopCategoryName;
  String shopLogo;
  String productDetails;
  String specifications;
  String actualAmount;
  String isOffer;
  String offerType;
  String offerAmount;
  String sellingAmount;
  List<String> productImages;
  String activeStatus;
  String createdAt;
  String updatedAt;

  ChoosenList(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productCode,
      this.categoryId,
      this.shopCategoryName,
      this.shopLogo,
      this.productDetails,
      this.specifications,
      this.actualAmount,
      this.isOffer,
      this.offerType,
      this.offerAmount,
      this.sellingAmount,
      this.productImages,
      this.activeStatus,
      this.createdAt,
      this.updatedAt});

  ChoosenList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productCode = json['productCode'];
    categoryId = json['category_id'];
    shopCategoryName = json['shopCategoryName'];
    shopLogo = json['shopLogo'];
    productDetails = json['productDetails'];
    specifications = json['specifications'];
    actualAmount = json['actualAmount'];
    isOffer = json['isOffer'];
    offerType = json['offerType'];
    offerAmount = json['offerAmount'];
    sellingAmount = json['sellingAmount'];
    productImages = json['productImages'].cast<String>();
    activeStatus = json['activeStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['shopId'] = this.shopId;
    data['merchantId'] = this.merchantId;
    data['shopName'] = this.shopName;
    data['productName'] = this.productName;
    data['productCode'] = this.productCode;
    data['category_id'] = this.categoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopLogo'] = this.shopLogo;
    data['productDetails'] = this.productDetails;
    data['specifications'] = this.specifications;
    data['actualAmount'] = this.actualAmount;
    data['isOffer'] = this.isOffer;
    data['offerType'] = this.offerType;
    data['offerAmount'] = this.offerAmount;
    data['sellingAmount'] = this.sellingAmount;
    data['productImages'] = this.productImages;
    data['activeStatus'] = this.activeStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

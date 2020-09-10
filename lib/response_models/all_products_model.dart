class AllProducts {
  String status;
  String message;
  List<ProductList> productList;

  AllProducts({this.status, this.message, this.productList});

  AllProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['productList'] != null) {
      productList = new List<ProductList>();
      json['productList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
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
  String productDetails;
  String specifications;
  String actualAmount;
  String isOffer;
  String isFeature;
  String offerType;
  String offerAmount;
  String sellingAmount;
  String viewCount;
  List<String> productImages;
  String shortDescription;
  String longDescription;
  String activeStatus;
  String shopCategoryName;
  String shopLogo;
  String merchantName;
  String createdAt;
  String updatedAt;

  ProductList(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productCode,
      this.productDetails,
      this.specifications,
      this.actualAmount,
      this.isOffer,
      this.isFeature,
      this.offerType,
      this.offerAmount,
      this.sellingAmount,
      this.viewCount,
      this.productImages,
      this.shortDescription,
      this.longDescription,
      this.activeStatus,
      this.shopCategoryName,
      this.shopLogo,
      this.merchantName,
      this.createdAt,
      this.updatedAt});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productCode = json['productCode'];
    productDetails = json['productDetails'];
    specifications = json['specifications'];
    actualAmount = json['actualAmount'];
    isOffer = json['isOffer'];
    isFeature = json['is_feature'];
    offerType = json['offerType'];
    offerAmount = json['offerAmount'];
    sellingAmount = json['sellingAmount'];
    viewCount = json['view_count'];
    productImages = json['productImages'].cast<String>();
    shortDescription = json['shortDescription'];
    longDescription = json['longDescription'];
    activeStatus = json['activeStatus'];
    shopCategoryName = json['shopCategoryName'];
    shopLogo = json['shopLogo'];
    merchantName = json['merchantName'];
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
    data['productDetails'] = this.productDetails;
    data['specifications'] = this.specifications;
    data['actualAmount'] = this.actualAmount;
    data['isOffer'] = this.isOffer;
    data['is_feature'] = this.isFeature;
    data['offerType'] = this.offerType;
    data['offerAmount'] = this.offerAmount;
    data['sellingAmount'] = this.sellingAmount;
    data['view_count'] = this.viewCount;
    data['productImages'] = this.productImages;
    data['shortDescription'] = this.shortDescription;
    data['longDescription'] = this.longDescription;
    data['activeStatus'] = this.activeStatus;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopLogo'] = this.shopLogo;
    data['merchantName'] = this.merchantName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

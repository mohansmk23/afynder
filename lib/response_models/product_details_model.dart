class ProductDetailsModel {
  String status;
  String message;
  var allCount;
  var pageNo;
  String pageNoMsg;
  List<ProductList> productList;
  List<SameMerchantProducts> sameMerchantProducts;

  ProductDetailsModel(
      {this.status,
      this.message,
      this.allCount,
      this.pageNo,
      this.pageNoMsg,
      this.productList,
      this.sameMerchantProducts});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCount = json['allCount'];
    pageNo = json['pageNo'];
    pageNoMsg = json['pageNoMsg'];
    if (json['productList'] != null) {
      productList = new List<ProductList>();
      json['productList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
    if (json['sameMerchantProducts'] != null) {
      sameMerchantProducts = new List<SameMerchantProducts>();
      json['sameMerchantProducts'].forEach((v) {
        sameMerchantProducts.add(new SameMerchantProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['allCount'] = this.allCount;
    data['pageNo'] = this.pageNo;
    data['pageNoMsg'] = this.pageNoMsg;
    if (this.productList != null) {
      data['productList'] = this.productList.map((v) => v.toJson()).toList();
    }
    if (this.sameMerchantProducts != null) {
      data['sameMerchantProducts'] =
          this.sameMerchantProducts.map((v) => v.toJson()).toList();
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
  List<Specifications> specifications;
  List<String> features;
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
  String noOfRatings;
  String avgRatings;
  String shopeeRating;
  String wishlistStatus;
  String shopCategoryName;
  String shopLogo;
  String shopMailId;
  String merchantName;
  String shopClosingTime;
  String shopOpeningTime;
  String shopAddress;
  String shopContactNumber;
  String merchantCode;
  String shoplocation;
  String whatsappNumber;
  String lat;
  String lng;
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
      this.features,
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
      this.noOfRatings,
      this.avgRatings,
      this.shopeeRating,
      this.wishlistStatus,
      this.shopCategoryName,
      this.shopLogo,
      this.shopMailId,
      this.merchantName,
      this.shopClosingTime,
      this.shopOpeningTime,
      this.shopAddress,
      this.shopContactNumber,
      this.merchantCode,
      this.shoplocation,
      this.whatsappNumber,
      this.lat,
      this.lng,
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
    if (json['specifications'] != null) {
      specifications = new List<Specifications>();
      json['specifications'].forEach((v) {
        specifications.add(new Specifications.fromJson(v));
      });
    }
    features = json['features'].cast<String>();
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
    noOfRatings = json['noOfRatings'];
    avgRatings = json['avgRatings'];
    shopeeRating = json['shopeeRating'];
    wishlistStatus = json['wishlistStatus'];
    shopCategoryName = json['shopCategoryName'];
    shopLogo = json['shopLogo'];
    shopMailId = json['shopMailId'];
    merchantName = json['merchantName'];
    shopClosingTime = json['shopClosingTime'];
    shopOpeningTime = json['shopOpeningTime'];
    shopAddress = json['shopAddress'];
    shopContactNumber = json['shopContactNumber'];
    merchantCode = json['merchantCode'];
    shoplocation = json['shoplocation'];
    whatsappNumber = json['whatsappNumber'];
    lat = json['Lat'];
    lng = json['Lng'];
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
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications.map((v) => v.toJson()).toList();
    }
    data['features'] = this.features;
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
    data['noOfRatings'] = this.noOfRatings;
    data['avgRatings'] = this.avgRatings;
    data['shopeeRating'] = this.shopeeRating;
    data['wishlistStatus'] = this.wishlistStatus;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopLogo'] = this.shopLogo;
    data['shopMailId'] = this.shopMailId;
    data['merchantName'] = this.merchantName;
    data['shopClosingTime'] = this.shopClosingTime;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopAddress'] = this.shopAddress;
    data['shopContactNumber'] = this.shopContactNumber;
    data['merchantCode'] = this.merchantCode;
    data['shoplocation'] = this.shoplocation;
    data['whatsappNumber'] = this.whatsappNumber;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Specifications {
  String key;
  String value;

  Specifications({this.key, this.value});

  Specifications.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class SameMerchantProducts {
  String productId;
  String shopId;
  String merchantId;
  String shopName;
  String productName;
  String productCode;
  String productDetails;
  String specifications;
  String features;
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
  String wishlistStatus;
  String noOfRatings;
  String avgRatings;
  String shopeeRating;
  String shopLogo;
  String shopMailId;
  String merchantName;
  String shopClosingTime;
  String shopOpeningTime;
  String shopAddress;
  String shopContactNumber;
  String merchantCode;
  String shoplocation;
  String whatsappNumber;
  String lat;
  String lng;
  String createdAt;
  String updatedAt;

  SameMerchantProducts(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productCode,
      this.productDetails,
      this.specifications,
      this.features,
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
      this.wishlistStatus,
      this.noOfRatings,
      this.avgRatings,
      this.shopeeRating,
      this.shopLogo,
      this.shopMailId,
      this.merchantName,
      this.shopClosingTime,
      this.shopOpeningTime,
      this.shopAddress,
      this.shopContactNumber,
      this.merchantCode,
      this.shoplocation,
      this.whatsappNumber,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  SameMerchantProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productCode = json['productCode'];
    productDetails = json['productDetails'];
    specifications = json['specifications'];
    features = json['features'];
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
    wishlistStatus = json['wishlistStatus'];
    noOfRatings = json['noOfRatings'];
    avgRatings = json['avgRatings'];
    shopeeRating = json['shopeeRating'];
    shopLogo = json['shopLogo'];
    shopMailId = json['shopMailId'];
    merchantName = json['merchantName'];
    shopClosingTime = json['shopClosingTime'];
    shopOpeningTime = json['shopOpeningTime'];
    shopAddress = json['shopAddress'];
    shopContactNumber = json['shopContactNumber'];
    merchantCode = json['merchantCode'];
    shoplocation = json['shoplocation'];
    whatsappNumber = json['whatsappNumber'];
    lat = json['Lat'];
    lng = json['Lng'];
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
    data['features'] = this.features;
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
    data['wishlistStatus'] = this.wishlistStatus;
    data['noOfRatings'] = this.noOfRatings;
    data['avgRatings'] = this.avgRatings;
    data['shopeeRating'] = this.shopeeRating;
    data['shopLogo'] = this.shopLogo;
    data['shopMailId'] = this.shopMailId;
    data['merchantName'] = this.merchantName;
    data['shopClosingTime'] = this.shopClosingTime;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopAddress'] = this.shopAddress;
    data['shopContactNumber'] = this.shopContactNumber;
    data['merchantCode'] = this.merchantCode;
    data['shoplocation'] = this.shoplocation;
    data['whatsappNumber'] = this.whatsappNumber;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

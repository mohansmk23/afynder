class AllProducts {
  String status;
  String message;
  var allCount;
  var pageNo;
  String pageNoMsg;
  String isLastPage;
  List<ProductList> productList;

  AllProducts(
      {this.status,
      this.message,
      this.allCount,
      this.pageNo,
      this.pageNoMsg,
      this.isLastPage,
      this.productList});

  AllProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCount = json['allCount'];
    pageNo = json['pageNo'];
    pageNoMsg = json['pageNoMsg'];
    isLastPage = json['isLastPage'];
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
    data['allCount'] = this.allCount;
    data['pageNo'] = this.pageNo;
    data['pageNoMsg'] = this.pageNoMsg;
    data['isLastPage'] = this.isLastPage;
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
  String productUrl;
  String productCode;
  Null productDetails;
  String specifications;
  String features;
  String actualAmount;
  String isOffer;
  String isFeature;
  String offerType;
  String offerAmount;
  String sellingAmount;
  String ispricenotapplicable;
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
  String city;
  String merchantCode;
  String website;
  String description;
  String area;
  String shopPincode;
  String shopState;
  String shopCity;
  String shopArea;
  String shopLogo;
  String shopMailId;
  String merchantName;
  String shopClosingTime;
  String shopOpeningTime;
  String shopAddress;
  String shopContactNumber;
  String createdAt;
  String updatedAt;

  ProductList(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productUrl,
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
      this.ispricenotapplicable,
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
      this.city,
      this.merchantCode,
      this.website,
      this.description,
      this.area,
      this.shopPincode,
      this.shopState,
      this.shopCity,
      this.shopArea,
      this.shopLogo,
      this.shopMailId,
      this.merchantName,
      this.shopClosingTime,
      this.shopOpeningTime,
      this.shopAddress,
      this.shopContactNumber,
      this.createdAt,
      this.updatedAt});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productUrl = json['productUrl'];
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
    ispricenotapplicable = json['ispricenotapplicable'];
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
    city = json['City'];
    merchantCode = json['merchantCode'];
    website = json['website'];
    description = json['description'];
    area = json['Area'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    shopCity = json['shopCity'];
    shopArea = json['shopArea'];
    shopLogo = json['shopLogo'];
    shopMailId = json['shopMailId'];
    merchantName = json['merchantName'];
    shopClosingTime = json['shopClosingTime'];
    shopOpeningTime = json['shopOpeningTime'];
    shopAddress = json['shopAddress'];
    shopContactNumber = json['shopContactNumber'];
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
    data['productUrl'] = this.productUrl;
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
    data['ispricenotapplicable'] = this.ispricenotapplicable;
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
    data['City'] = this.city;
    data['merchantCode'] = this.merchantCode;
    data['website'] = this.website;
    data['description'] = this.description;
    data['Area'] = this.area;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['shopCity'] = this.shopCity;
    data['shopArea'] = this.shopArea;
    data['shopLogo'] = this.shopLogo;
    data['shopMailId'] = this.shopMailId;
    data['merchantName'] = this.merchantName;
    data['shopClosingTime'] = this.shopClosingTime;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopAddress'] = this.shopAddress;
    data['shopContactNumber'] = this.shopContactNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

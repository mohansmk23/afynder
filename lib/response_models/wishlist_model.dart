class WishListModel {
  String status;
  String message;
  List<WishlistProducts> wishlistProducts;

  WishListModel({this.status, this.message, this.wishlistProducts});

  WishListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishlistProducts'] != null) {
      wishlistProducts = new List<WishlistProducts>();
      json['wishlistProducts'].forEach((v) {
        wishlistProducts.add(new WishlistProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.wishlistProducts != null) {
      data['wishlistProducts'] =
          this.wishlistProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistProducts {
  String productId;
  String shopId;
  String merchantId;
  String shopName;
  String productName;
  String productCode;
  String categoryId;
  String shopCategoryName;
  String shopLogo;
  String shopMailId;
  String shopContactNumber;
  String shoplocation;
  String whatsappNumber;
  String lat;
  String lng;
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

  WishlistProducts(
      {this.productId,
      this.shopId,
      this.merchantId,
      this.shopName,
      this.productName,
      this.productCode,
      this.categoryId,
      this.shopCategoryName,
      this.shopLogo,
      this.shopMailId,
      this.shopContactNumber,
      this.shoplocation,
      this.whatsappNumber,
      this.lat,
      this.lng,
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

  WishlistProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopId = json['shopId'];
    merchantId = json['merchantId'];
    shopName = json['shopName'];
    productName = json['productName'];
    productCode = json['productCode'];
    categoryId = json['category_id'];
    shopCategoryName = json['shopCategoryName'];
    shopLogo = json['shopLogo'];
    shopMailId = json['shopMailId'];
    shopContactNumber = json['shopContactNumber'];
    shoplocation = json['shoplocation'];
    whatsappNumber = json['whatsappNumber'];
    lat = json['Lat'];
    lng = json['Lng'];
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
    data['shopMailId'] = this.shopMailId;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shoplocation'] = this.shoplocation;
    data['whatsappNumber'] = this.whatsappNumber;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
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

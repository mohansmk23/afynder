class MapModel {
  String status;
  String message;
  int allCount;
  String pageNo;
  String pageNoMsg;
  List<MerchantList> merchantList;

  MapModel(
      {this.status,
      this.message,
      this.allCount,
      this.pageNo,
      this.pageNoMsg,
      this.merchantList});

  MapModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCount = json['allCount'];
    pageNo = json['pageNo'];
    pageNoMsg = json['pageNoMsg'];
    if (json['merchantList'] != null) {
      merchantList = new List<MerchantList>();
      json['merchantList'].forEach((v) {
        merchantList.add(new MerchantList.fromJson(v));
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
    if (this.merchantList != null) {
      data['merchantList'] = this.merchantList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantList {
  String merchantId;
  String firstName;
  String lastName;
  var dob;
  String contactNumber;
  String mailId;
  String profileImage;
  String shopCategoryId;
  String shopCategoryName;
  String shopName;
  var shopNumber;
  String shopContactNumber;
  String shopWhatsappNumber;
  String shopMailId;
  String shopLogo;
  String description;
  String shopArea;
  String shopCity;
  String shopPincode;
  String shopState;
  String registrationStatus;
  String referalCode;
  String referenceNumber;
  String referenceCodeShareContent;
  String gstNumber;
  String shopAddress;
  String authKey;
  String rating;
  String ratingCount;
  String lat;
  String lng;
  String shopLocation;
  var shopOpeningTime;
  var shopClosingTime;
  String isOffer;
  String offerAmt;
  String offerUntil;
  String offerType;

  MerchantList(
      {this.merchantId,
      this.firstName,
      this.lastName,
      this.dob,
      this.contactNumber,
      this.mailId,
      this.profileImage,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopName,
      this.shopNumber,
      this.shopContactNumber,
      this.shopWhatsappNumber,
      this.shopMailId,
      this.shopLogo,
      this.description,
      this.shopArea,
      this.shopCity,
      this.shopPincode,
      this.shopState,
      this.registrationStatus,
      this.referalCode,
      this.referenceNumber,
      this.referenceCodeShareContent,
      this.gstNumber,
      this.shopAddress,
      this.authKey,
      this.rating,
      this.ratingCount,
      this.lat,
      this.lng,
      this.shopLocation,
      this.shopOpeningTime,
      this.shopClosingTime,
      this.isOffer,
      this.offerAmt,
      this.offerUntil,
      this.offerType});

  MerchantList.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    profileImage = json['profileImage'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopName = json['ShopName'];
    shopNumber = json['shopNumber'];
    shopContactNumber = json['shopContactNumber'];
    shopWhatsappNumber = json['shopWhatsappNumber'];
    shopMailId = json['shopMailId'];
    shopLogo = json['shopLogo'];
    description = json['description'];
    shopArea = json['shopArea'];
    shopCity = json['shopCity'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    registrationStatus = json['registrationStatus'];
    referalCode = json['referalCode'];
    referenceNumber = json['referenceNumber'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    gstNumber = json['gstNumber'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
    rating = json['rating'];
    ratingCount = json['ratingCount'];
    lat = json['Lat'];
    lng = json['Lng'];
    shopLocation = json['shopLocation'];
    shopOpeningTime = json['shopOpeningTime'];
    shopClosingTime = json['shopClosingTime'];
    isOffer = json['isOffer'];
    offerAmt = json['offerAmt'];
    offerUntil = json['offerUntil'];
    offerType = json['offerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['profileImage'] = this.profileImage;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['ShopName'] = this.shopName;
    data['shopNumber'] = this.shopNumber;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopWhatsappNumber'] = this.shopWhatsappNumber;
    data['shopMailId'] = this.shopMailId;
    data['shopLogo'] = this.shopLogo;
    data['description'] = this.description;
    data['shopArea'] = this.shopArea;
    data['shopCity'] = this.shopCity;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['registrationStatus'] = this.registrationStatus;
    data['referalCode'] = this.referalCode;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['gstNumber'] = this.gstNumber;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    data['rating'] = this.rating;
    data['ratingCount'] = this.ratingCount;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['shopLocation'] = this.shopLocation;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopClosingTime'] = this.shopClosingTime;
    data['isOffer'] = this.isOffer;
    data['offerAmt'] = this.offerAmt;
    data['offerUntil'] = this.offerUntil;
    data['offerType'] = this.offerType;
    return data;
  }
}

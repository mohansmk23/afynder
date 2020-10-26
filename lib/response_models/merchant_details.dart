class MerchantDetailsModel {
  String status;
  String message;
  MerchantInformations merchantInformations;

  MerchantDetailsModel({this.status, this.message, this.merchantInformations});

  MerchantDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    merchantInformations = json['merchantInformations'] != null
        ? new MerchantInformations.fromJson(json['merchantInformations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.merchantInformations != null) {
      data['merchantInformations'] = this.merchantInformations.toJson();
    }
    return data;
  }
}

class MerchantInformations {
  String merchantId;
  String merchantCode;
  String listings;
  String firstName;
  String lastName;
  String dob;
  String contactNumber;
  String mailId;
  String profileImage;
  String banner1;
  String shopCategoryId;
  String shopCategoryName;
  String shopName;
  String shopNumber;
  String shopContactNumber;
  String shopMailId;
  String description;
  String website;
  String shopLogo;
  String shopArea;
  String shopCity;
  String shopPincode;
  String shopState;
  String registrationStatus;
  String lat;
  String lng;
  String gstNumber;
  String shopLocation;
  String shopAddress;
  String authKey;
  String rating;
  String ratingCount;
  String shopOpeningTime;
  String shopClosingTime;
  String isOffer;
  String offerUntil;
  String offerAmt;

  MerchantInformations(
      {this.merchantId,
      this.merchantCode,
      this.listings,
      this.firstName,
      this.lastName,
      this.dob,
      this.contactNumber,
      this.mailId,
      this.profileImage,
      this.banner1,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopName,
      this.shopNumber,
      this.shopContactNumber,
      this.shopMailId,
      this.description,
      this.website,
      this.shopLogo,
      this.shopArea,
      this.shopCity,
      this.shopPincode,
      this.shopState,
      this.registrationStatus,
      this.lat,
      this.lng,
      this.gstNumber,
      this.shopLocation,
      this.shopAddress,
      this.authKey,
      this.rating,
      this.ratingCount,
      this.shopOpeningTime,
      this.shopClosingTime,
      this.isOffer,
      this.offerUntil,
      this.offerAmt});

  MerchantInformations.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantCode = json['merchantCode'];
    listings = json['Listings'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    profileImage = json['profileImage'];
    banner1 = json['Banner_1'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopName = json['ShopName'];
    shopNumber = json['shopNumber'];
    shopContactNumber = json['shopContactNumber'];
    shopMailId = json['shopMailId'];
    description = json['description'];
    website = json['website'];
    shopLogo = json['shopLogo'];
    shopArea = json['shopArea'];
    shopCity = json['shopCity'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    registrationStatus = json['registrationStatus'];
    lat = json['Lat'];
    lng = json['Lng'];
    gstNumber = json['gstNumber'];
    shopLocation = json['shopLocation'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
    rating = json['rating'];
    ratingCount = json['ratingCount'];
    shopOpeningTime = json['shopOpeningTime'];
    shopClosingTime = json['shopClosingTime'];
    isOffer = json['isOffer'];
    offerUntil = json['offerUntil'];
    offerAmt = json['offerAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['merchantCode'] = this.merchantCode;
    data['Listings'] = this.listings;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['profileImage'] = this.profileImage;
    data['Banner_1'] = this.banner1;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['ShopName'] = this.shopName;
    data['shopNumber'] = this.shopNumber;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopMailId'] = this.shopMailId;
    data['description'] = this.description;
    data['website'] = this.website;
    data['shopLogo'] = this.shopLogo;
    data['shopArea'] = this.shopArea;
    data['shopCity'] = this.shopCity;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['registrationStatus'] = this.registrationStatus;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['gstNumber'] = this.gstNumber;
    data['shopLocation'] = this.shopLocation;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    data['rating'] = this.rating;
    data['ratingCount'] = this.ratingCount;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopClosingTime'] = this.shopClosingTime;
    data['isOffer'] = this.isOffer;
    data['offerUntil'] = this.offerUntil;
    data['offerAmt'] = this.offerAmt;
    return data;
  }
}

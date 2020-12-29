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
  var dob;
  String contactNumber;
  String mailId;
  var description;
  String profileImage;
  String banner1;
  String shopCategoryId;
  String shopCategoryName;
  String shopName;
  var shopNumber;
  String shopContactNumber;
  String shopMailId;
  var website;
  String shopLogo;
  String shopArea;
  String shopCity;
  String shopPincode;
  String shopState;
  String registrationStatus;
  String address1;
  String address2;
  String location;
  String gstCertificate;
  String bannerImage3;
  String bannerImage2;
  String bannerImage1;
  ShopTimings shopTimings;
  String lat;
  String lng;
  String gstNumber;
  String shopLocation;
  String shopAddress;
  String authKey;
  String rating;
  String shopFullAddress;
  String ratingCount;
  var shopOpeningTime;
  var shopClosingTime;
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
      this.description,
      this.profileImage,
      this.banner1,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopName,
      this.shopNumber,
      this.shopContactNumber,
      this.shopMailId,
      this.website,
      this.shopLogo,
      this.shopArea,
      this.shopCity,
      this.shopPincode,
      this.shopState,
      this.registrationStatus,
      this.address1,
      this.address2,
      this.location,
      this.gstCertificate,
      this.bannerImage3,
      this.bannerImage2,
      this.bannerImage1,
      this.shopTimings,
      this.lat,
      this.lng,
      this.gstNumber,
      this.shopLocation,
      this.shopAddress,
      this.authKey,
      this.rating,
      this.shopFullAddress,
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
    description = json['description'];
    profileImage = json['profileImage'];
    banner1 = json['Banner_1'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopName = json['ShopName'];
    shopNumber = json['shopNumber'];
    shopContactNumber = json['shopContactNumber'];
    shopMailId = json['shopMailId'];
    website = json['website'];
    shopLogo = json['shopLogo'];
    shopArea = json['shopArea'];
    shopCity = json['shopCity'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    registrationStatus = json['registrationStatus'];
    address1 = json['address1'];
    address2 = json['address2'];
    location = json['location'];
    gstCertificate = json['gstCertificate'];
    bannerImage3 = json['bannerImage3'];
    bannerImage2 = json['bannerImage2'];
    bannerImage1 = json['bannerImage1'];
    shopTimings = json['shopTimings'] != null
        ? new ShopTimings.fromJson(json['shopTimings'])
        : null;
    lat = json['Lat'];
    lng = json['Lng'];
    gstNumber = json['gstNumber'];
    shopLocation = json['shopLocation'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
    rating = json['rating'];
    shopFullAddress = json['shopFullAddress'];
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
    data['description'] = this.description;
    data['profileImage'] = this.profileImage;
    data['Banner_1'] = this.banner1;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['ShopName'] = this.shopName;
    data['shopNumber'] = this.shopNumber;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopMailId'] = this.shopMailId;
    data['website'] = this.website;
    data['shopLogo'] = this.shopLogo;
    data['shopArea'] = this.shopArea;
    data['shopCity'] = this.shopCity;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['registrationStatus'] = this.registrationStatus;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['location'] = this.location;
    data['gstCertificate'] = this.gstCertificate;
    data['bannerImage3'] = this.bannerImage3;
    data['bannerImage2'] = this.bannerImage2;
    data['bannerImage1'] = this.bannerImage1;
    if (this.shopTimings != null) {
      data['shopTimings'] = this.shopTimings.toJson();
    }
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['gstNumber'] = this.gstNumber;
    data['shopLocation'] = this.shopLocation;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    data['rating'] = this.rating;
    data['shopFullAddress'] = this.shopFullAddress;
    data['ratingCount'] = this.ratingCount;
    data['shopOpeningTime'] = this.shopOpeningTime;
    data['shopClosingTime'] = this.shopClosingTime;
    data['isOffer'] = this.isOffer;
    data['offerUntil'] = this.offerUntil;
    data['offerAmt'] = this.offerAmt;
    return data;
  }
}

class ShopTimings {
  Monday monday;
  Monday tuesday;
  Monday wednesday;
  Monday thursday;
  Monday friday;
  Monday saturday;
  Monday sunday;

  ShopTimings(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  ShopTimings.fromJson(Map<String, dynamic> json) {
    monday =
        json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Monday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Monday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
    sunday =
        json['sunday'] != null ? new Monday.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['monday'] = this.monday.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday.toJson();
    }
    return data;
  }
}

class Monday {
  String openingTime;
  String closeingTime;

  Monday({this.openingTime, this.closeingTime});

  Monday.fromJson(Map<String, dynamic> json) {
    openingTime = json['openingTime'];
    closeingTime = json['closeingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingTime'] = this.openingTime;
    data['closeingTime'] = this.closeingTime;
    return data;
  }
}

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
  String firstName;
  String lastName;
  String dob;
  String contactNumber;
  String mailId;
  String profileImage;
  String shopCategoryId;
  String shopCategoryName;
  String shopName;
  String shopNumber;
  String shopContactNumber;
  String shopMailId;
  String shopLogo;
  String lat;
  String lng;
  String gstNumber;
  String shopLocation;
  String shopAddress;
  Null authKey;

  MerchantInformations(
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
      this.shopMailId,
      this.shopLogo,
      this.lat,
      this.lng,
      this.gstNumber,
      this.shopLocation,
      this.shopAddress,
      this.authKey});

  MerchantInformations.fromJson(Map<String, dynamic> json) {
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
    shopMailId = json['shopMailId'];
    shopLogo = json['shopLogo'];
    lat = json['Lat'];
    lng = json['Lng'];
    gstNumber = json['gstNumber'];
    shopLocation = json['shopLocation'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
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
    data['shopMailId'] = this.shopMailId;
    data['shopLogo'] = this.shopLogo;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['gstNumber'] = this.gstNumber;
    data['shopLocation'] = this.shopLocation;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    return data;
  }
}

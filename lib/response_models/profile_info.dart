class ProfileModel {
  String status;
  String message;
  ShopeeDetails shopeeDetails;

  ProfileModel({this.status, this.message, this.shopeeDetails});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopeeDetails = json['shopeeDetails'] != null
        ? new ShopeeDetails.fromJson(json['shopeeDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopeeDetails != null) {
      data['shopeeDetails'] = this.shopeeDetails.toJson();
    }
    return data;
  }
}

class ShopeeDetails {
  int shopeeId;
  int userId;
  String shopeeCode;
  String shopeeName;
  String userCode;
  String lastName;
  String mailId;
  var dob;
  String contactNumber;
  var address;
  var gender;
  String redeemCode;
  String profileImage;
  String refQrCode;
  int walletAmount;
  String referenceNumber;
  String referenceCodeShareContent;
  String userType;
  String wislistCount;

  ShopeeDetails(
      {this.shopeeId,
      this.userId,
      this.shopeeCode,
      this.shopeeName,
      this.userCode,
      this.lastName,
      this.mailId,
      this.dob,
      this.contactNumber,
      this.address,
      this.gender,
      this.redeemCode,
      this.profileImage,
      this.refQrCode,
      this.walletAmount,
      this.referenceNumber,
      this.referenceCodeShareContent,
      this.userType,
      this.wislistCount});

  ShopeeDetails.fromJson(Map<String, dynamic> json) {
    shopeeId = json['shopeeId'];
    userId = json['userId'];
    shopeeCode = json['shopeeCode'];
    shopeeName = json['shopeeName'];
    userCode = json['userCode'];
    lastName = json['lastName'];
    mailId = json['mailId'];
    dob = json['dob'];
    contactNumber = json['contactNumber'];
    address = json['address'];
    gender = json['gender'];
    redeemCode = json['RedeemCode'];
    profileImage = json['profileImage'];
    refQrCode = json['refQrCode'];
    walletAmount = json['walletAmount'];
    referenceNumber = json['referenceNumber'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    userType = json['userType'];
    wislistCount = json['wislistCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopeeId'] = this.shopeeId;
    data['userId'] = this.userId;
    data['shopeeCode'] = this.shopeeCode;
    data['shopeeName'] = this.shopeeName;
    data['userCode'] = this.userCode;
    data['lastName'] = this.lastName;
    data['mailId'] = this.mailId;
    data['dob'] = this.dob;
    data['contactNumber'] = this.contactNumber;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['RedeemCode'] = this.redeemCode;
    data['profileImage'] = this.profileImage;
    data['refQrCode'] = this.refQrCode;
    data['walletAmount'] = this.walletAmount;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['userType'] = this.userType;
    data['wislistCount'] = this.wislistCount;
    return data;
  }
}

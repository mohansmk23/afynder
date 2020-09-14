class LoginModel {
  String status;
  String message;
  ShoppeInformations shoppeInformations;

  LoginModel({this.status, this.message, this.shoppeInformations});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shoppeInformations = json['shoppeInformations'] != null
        ? new ShoppeInformations.fromJson(json['shoppeInformations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shoppeInformations != null) {
      data['shoppeInformations'] = this.shoppeInformations.toJson();
    }
    return data;
  }
}

class ShoppeInformations {
  String id;
  String firstName;
  String mailId;
  String lastName;
  String authKey;
  String profileImage;

  ShoppeInformations(
      {this.id,
      this.firstName,
      this.mailId,
      this.lastName,
      this.authKey,
      this.profileImage});

  ShoppeInformations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    mailId = json['mailId'];
    lastName = json['lastName'];
    authKey = json['authKey'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['mailId'] = this.mailId;
    data['lastName'] = this.lastName;
    data['authKey'] = this.authKey;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

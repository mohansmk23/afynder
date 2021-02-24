class WalletHistoryModel {
  String status;
  String message;
  List<WalletHistory> walletHistory;

  WalletHistoryModel({this.status, this.message, this.walletHistory});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['walletHistory'] != null) {
      walletHistory = new List<WalletHistory>();
      json['walletHistory'].forEach((v) {
        walletHistory.add(new WalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.walletHistory != null) {
      data['walletHistory'] =
          this.walletHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletHistory {
  String autoId;
  String referalLogId;
  String logType;
  String newMerchantId;
  String newMerchantCode;
  String newMerchantName;
  String referalPersonType;
  String referanceCode;
  String referarId;
  String referarCode;
  String referarName;
  String previousAmount;
  String creditedAmount;
  String action;
  String actionby;
  String actionAmount;
  var redeemMerchantPreviousAmount;
  var receiveMerchantPreviousAmount;
  String createdDate;
  String updatedDate;
  var updatedIpaddress;
  String shopLogo;
  String logDescription;

  WalletHistory(
      {this.autoId,
      this.referalLogId,
      this.logType,
      this.newMerchantId,
      this.newMerchantCode,
      this.newMerchantName,
      this.referalPersonType,
      this.referanceCode,
      this.referarId,
      this.referarCode,
      this.referarName,
      this.previousAmount,
      this.creditedAmount,
      this.action,
      this.actionby,
      this.actionAmount,
      this.redeemMerchantPreviousAmount,
      this.receiveMerchantPreviousAmount,
      this.createdDate,
      this.updatedDate,
      this.updatedIpaddress,
      this.shopLogo,
      this.logDescription});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    autoId = json['auto_id'];
    referalLogId = json['ReferalLogId'];
    logType = json['LogType'];
    newMerchantId = json['newMerchantId'];
    newMerchantCode = json['newMerchantCode'];
    newMerchantName = json[' newMerchantName'];
    referalPersonType = json['referalPersonType'];
    referanceCode = json['ReferanceCode'];
    referarId = json['referarId'];
    referarCode = json['referarCode'];
    referarName = json['referarName'];
    previousAmount = json['PreviousAmount'];
    creditedAmount = json['creditedAmount'];
    action = json['Action'];
    actionby = json['Actionby'];
    actionAmount = json['ActionAmount'];
    redeemMerchantPreviousAmount = json['RedeemMerchantPreviousAmount'];
    receiveMerchantPreviousAmount = json['ReceiveMerchantPreviousAmount'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    updatedIpaddress = json['UpdatedIpaddress'];
    shopLogo = json['shopLogo'];
    logDescription = json['logDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auto_id'] = this.autoId;
    data['ReferalLogId'] = this.referalLogId;
    data['LogType'] = this.logType;
    data['newMerchantId'] = this.newMerchantId;
    data['newMerchantCode'] = this.newMerchantCode;
    data[' newMerchantName'] = this.newMerchantName;
    data['referalPersonType'] = this.referalPersonType;
    data['ReferanceCode'] = this.referanceCode;
    data['referarId'] = this.referarId;
    data['referarCode'] = this.referarCode;
    data['referarName'] = this.referarName;
    data['PreviousAmount'] = this.previousAmount;
    data['creditedAmount'] = this.creditedAmount;
    data['Action'] = this.action;
    data['Actionby'] = this.actionby;
    data['ActionAmount'] = this.actionAmount;
    data['RedeemMerchantPreviousAmount'] = this.redeemMerchantPreviousAmount;
    data['ReceiveMerchantPreviousAmount'] = this.receiveMerchantPreviousAmount;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedDate'] = this.updatedDate;
    data['UpdatedIpaddress'] = this.updatedIpaddress;
    data['shopLogo'] = this.shopLogo;
    data['logDescription'] = this.logDescription;
    return data;
  }
}

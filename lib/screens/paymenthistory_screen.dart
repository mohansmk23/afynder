import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/response_models/wallet_history_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isEmptyState = true;
  Response response;
  List<WalletHistory> walletHistoryList = [];
  WalletHistoryModel model = WalletHistoryModel();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
  DateFormat requiredDateFormat = DateFormat("dd MMMM yyyy");

  void getWalletHistory() async {
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(walletHistory,
          data: {"apiMethod": "WalletHistory", "mobileUniqueCode": "jana1221"});

      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = WalletHistoryModel.fromJson(parsed);
        walletHistoryList = model.walletHistory.toList();
        isEmptyState = false;
      } else {
        isEmptyState = true;
      }
    } catch (e) {
      isEmptyState = true;
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  String changeDateFormat(String date) =>
      requiredDateFormat.format(dateFormat.parse(date));

  @override
  void initState() {
    // TODO: implement initState
    getWalletHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "All Transactions",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isEmptyState
                ? emptyState()
                : new ListView.builder(
                    itemCount: walletHistoryList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      WalletHistory history = walletHistoryList[index];

                      return historyCard(
                          merchantName: history.newMerchantName,
                          date: changeDateFormat(history.updatedDate),
                          isCredit: history.action == "add",
                          amount: history.actionAmount,
                          merchantLogo: history.shopLogo);
                    }));
  }

  Card historyCard(
      {String merchantName,
      String date,
      bool isCredit,
      String amount,
      String merchantLogo}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: ListTile(
            leading: ClipOval(
              child: FadeInImage.memoryNetwork(
                image: merchantLogo,
                placeholder: kTransparentImage,
              ),
            ),
            title: Text(merchantName),
            subtitle: Text(date),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      isCredit ? "Credit" : "Redeem",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                  color: isCredit ? Colors.green[300] : Colors.red[300],
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      isCredit ? "+" : "-",
                      style: TextStyle(
                          color:
                              isCredit ? Colors.green[300] : Colors.red[300]),
                    ),
                    Icon(
                      FontAwesome.rupee,
                      color: isCredit ? Colors.green[300] : Colors.red[300],
                      size: 18.0,
                    ),
                    Text(
                      "300",
                      style: TextStyle(
                        color: isCredit ? Colors.green[300] : Colors.red[300],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

Widget emptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/nodata.png',
          height: 400.0,
          width: double.maxFinite,
        ),
        Text("No History Found",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 24.0)),
        SizedBox(
          height: 8.0,
        ),
        Text("Try making transactions",
            style: TextStyle(color: Colors.blueGrey[600], fontSize: 16.0)),
      ],
    ),
  );
}

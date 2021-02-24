import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/wishlist_model.dart';
import 'package:afynder/screens/nointernet_screen.dart';
import 'package:afynder/screens/productdetails_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'home_screen.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isEmptyState = true;
  Response response;
  List<WishlistProducts> wishList = [];
  WishListModel model = WishListModel();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  void getWishList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rnm = await Navigator.pushNamed(context, NoInternet.routeName);

      getWishList();

      return;
    }
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(wishListmgmt, data: {
        "apiMethod": "Wishlist",
        "mobileUniqueCode": mobileUniqueCode
      });

      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = WishListModel.fromJson(parsed);
        wishList = model.wishlistProducts.toList();
        isEmptyState = false;
      } else {
        isEmptyState = true;
        _showSnackBar(parsed["message"]);
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

  void removeWishlist(String productId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }
    setState(() {});

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "removeFromWishlist",
        "productId": productId,
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        _showSnackBar("Removed From WishList");
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {});
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getWishList();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("resume");
    switch (state) {
      case AppLifecycleState.resumed:
        getWishList();

        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              "WishList",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : isEmptyState
                  ? emptyState()
                  : GridView.builder(
                      itemCount: wishList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        WishlistProducts product = wishList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  productId: product.productId,
                                ),
                              ),
                            ).then((flag) {
                              if (flag ?? true) {
                                getWishList();
                              }
                            });
                          },
                          child: WishListItem(
                            imagePath: product.productImages[0],
                            categoryName: product.shopCategoryName,
                            productName: product.productName,
                            price: product.sellingAmount,
                            productId: product.productId,
                            isOffer: product.isOffer == "yes",
                            actualPrice: product.actualAmount,
                            offerPercent: product.offerAmount,
                            isOfferTypePercent:
                                product.offerType == "percentage",
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.8),
                      ),
                    )),
    );
  }
}

class WishListItem extends StatelessWidget {
  final String imagePath,
      categoryName,
      productName,
      price,
      offerPercent,
      productId,
      actualPrice;
  final bool isOffer, isOfferTypePercent;

  const WishListItem(
      {this.imagePath,
      this.categoryName,
      this.productName,
      this.price,
      this.isOffer,
      this.offerPercent,
      this.actualPrice,
      this.productId,
      this.isOfferTypePercent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      image: imagePath,
                      placeholder: 'assets/loader.gif',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fitWidth,
                    ),
                    Visibility(
                      visible: isOffer,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                isOfferTypePercent
                                    ? "$offerPercent% OFF"
                                    : "₹$offerPercent OFF",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            color: ThemeColors.themeOrange,
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            productName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              isOffer
                                  ? Text(
                                      "₹ $actualPrice",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : SizedBox(),
                              isOffer
                                  ? SizedBox(
                                      width: 4.0,
                                    )
                                  : SizedBox(),
                              Text(
                                "₹ $price",
                                style: TextStyle(
                                    color: ThemeColors.themeColor5,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
          'assets/nofavourites.png',
          height: 200.0,
          width: 200.0,
        ),
        Text("Your WishList is Empty",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 24.0)),
        SizedBox(
          height: 16.0,
        ),
        Text("Try adding Products in WishList",
            style: TextStyle(color: Colors.blueGrey[600], fontSize: 16.0)),
      ],
    ),
  );
}

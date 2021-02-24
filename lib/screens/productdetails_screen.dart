import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/product_details_model.dart';
import 'package:afynder/screens/landing_screen.dart';
import 'package:afynder/screens/merchantprofile_screen.dart';
import 'package:afynder/screens/nointernet_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'connectmerchant.dart';
import 'nearme_screen.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  const ProductDetails({Key key, this.productId}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController();
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true, isWishListed = false, isSignedIn, isRated;
  Response response;
  ProductDetailsModel model = ProductDetailsModel();
  ProductList product = ProductList();
  String rating = '';
  bool isConnectClicked = false;

  void getProductDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rnm = await Navigator.pushNamed(context, NoInternet.routeName);

      getProductDetails();

      return;
    }
    setState(() {
      isLoading = true;
    });
    isSignedIn = await _sharedPrefManager.iSignedIn();
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "productList",
        "productId": widget.productId,
        "searchString": "",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = ProductDetailsModel.fromJson(parsed);
        product = model.productList[0];
        isWishListed = product.wishlistStatus == "yes";
        isRated = product.shopeeRating.isNotEmpty;
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getInterestedDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var rnm = await Navigator.pushNamed(context, NoInternet.routeName);

      getInterestedDetails();

      return;
    }
    setState(() {
      isLoading = true;
    });
    isSignedIn = await _sharedPrefManager.iSignedIn();
    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(interestedProduct, data: {
        "apiMethod": "interestedProduct",
        "productId": widget.productId,
        "callFor": "like",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        print(parsed);
      } else {
        // _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void getAddorRemoveWishlist() async {
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
        "apiMethod": isWishListed ? "removeFromWishlist" : "addtoWishlist",
        "productId": widget.productId,
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        isWishListed = !isWishListed;
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {});
  }

  void rateProduct(String rating) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }

    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(rateTheProduct, data: {
        "apiMethod": "shopeeProductRating",
        "productId": product.productId,
        "rating": rating,
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        getProductDetails();
        _showSnackBar("Thanks for your rating on this product!");
        product.shopeeRating = rating;
        isRated = true;
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
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

  @override
  void initState() {
    getProductDetails();
    super.initState();
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
        extendBodyBehindAppBar: true,
        floatingActionButton: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  curve: Curves.easeInOutQuint,
                  height: isConnectClicked ? 0.0 : 35.0,
                  width: isConnectClicked ? 0.0 : 140.0,
                  duration: Duration(milliseconds: 200),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      getInterestedDetails();
                      setState(() {
                        isConnectClicked = !isConnectClicked;
                      });
                    },
                    color: ThemeColors.themeOrange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Interested?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "o",
                        child: isConnectClicked ? Icon(Icons.call) : SizedBox(),
                        onPressed: () {
                          launch("tel:// ${product.shopContactNumber}");
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "1",
                        backgroundColor: Colors.indigo,
                        child: isConnectClicked ? Icon(Icons.mail) : SizedBox(),
                        onPressed: () {
                          var url =
                              'sms: ${product.shopContactNumber}?body=Hey i\'m interested in your product ${product.productName}. Sent via Afynder';
                          launch(url);
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "2",
                        backgroundColor: Colors.green,
                        child: isConnectClicked
                            ? Icon(Icons.directions)
                            : SizedBox(),
                        onPressed: () {
                          launch(
                              "https://www.google.com/maps/dir/?api=1&destination=${product.lat},${product.lng}&travelmode=driving");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(""),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 0.0,
                child: Icon(Icons.arrow_back, color: Colors.white),
                backgroundColor: Colors.black38,
              ),
            ),
          ),
          actions: <Widget>[
            Visibility(
              visible: product.isOffer == "yes",
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 6.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: ThemeColors.themeOrange,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          "Featured",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 0, bottom: 36.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: AspectRatio(
                              aspectRatio: 5 / 4,
                              child: Stack(
                                children: <Widget>[
                                  PageView.builder(
                                    physics: BouncingScrollPhysics(),
                                    controller: controller,
                                    onPageChanged: (pos) {
                                      print(pos);
                                    },
                                    itemCount:
                                        product.productImages.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.network(
                                        product.productImages[index],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 36.0,
                                    left: 16.0,
                                    child: SmoothPageIndicator(
                                        controller: controller,
                                        count: product.productImages.length,
                                        effect: WormEffect(
                                            spacing: 4.0,
                                            radius: 5.0,
                                            dotWidth: 10.0,
                                            activeDotColor: Colors.blue,
                                            dotHeight:
                                                10.0), // your preferred effect
                                        onDotClicked: (index) {}),
                                  ),
                                  Visibility(
                                    visible: product.isOffer == "yes",
                                    child: Positioned(
                                      bottom: 30.0,
                                      right: 16.0,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            product.offerType == 'percentage'
                                                ? "${product.offerAmount}% OFF"
                                                : "₹ ${product.offerAmount} OFF",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        color: ThemeColors.themeOrange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0.0, -24.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32.0),
                                    topRight: Radius.circular(32.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32.0),
                                          topRight: Radius.circular(32.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 16.0,
                                                ),
                                                Text(
                                                  product.shopCategoryName,
                                                  style: TextStyle(
                                                    color:
                                                        ThemeColors.themeColor5,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Text(
                                                  product.productName,
                                                  style: TextStyle(
                                                      color: ThemeColors
                                                          .themeColor5,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    RatingBarIndicator(
                                                      rating: double.parse(
                                                          product.avgRatings),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 16.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                    Text(
                                                      "${product.noOfRatings} Ratings",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 14.0, 0, 2),
                                                child: Text(
                                                  product.isOffer == "yes"
                                                      ? "₹ ${product.actualAmount}"
                                                      : "",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color:
                                                        ThemeColors.themeColor5,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "₹ ${product.sellingAmount}",
                                                style: TextStyle(
                                                  color:
                                                      ThemeColors.themeColor5,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8.0, 0, 2),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (isSignedIn) {
                                                      getAddorRemoveWishlist();
                                                    } else {
                                                      Navigator.pushNamed(
                                                          context,
                                                          LandingScreen
                                                              .routeName);
                                                    }
                                                  },
                                                  child: Icon(
                                                    isWishListed
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Description",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color:
                                                      ThemeColors.themeColor5,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              product.shortDescription,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ThemeColors.themeColor5,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  product.features.isNotEmpty
                                      ? Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Features",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: ThemeColors
                                                          .themeColor5,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        product.features.isEmpty
                                                            ? 0
                                                            : product.features
                                                                .length,
                                                    itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                      print(product
                                                          .features.length);

                                                      return new Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                FontAwesome
                                                                    .circle,
                                                                size: 8.0,
                                                              ),
                                                              SizedBox(
                                                                width: 8.0,
                                                              ),
                                                              Text(
                                                                product.features[
                                                                    index],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.0),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8.0,
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  product.specifications.isNotEmpty
                                      ? Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Specifications",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: ThemeColors
                                                          .themeColor5,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    shrinkWrap: true,
                                                    itemCount: product
                                                        .specifications.length,
                                                    itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                  flex: 4,
                                                                  child: Text(
                                                                    product
                                                                        .specifications[
                                                                            index]
                                                                        .key,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  )),
                                                              Expanded(
                                                                  flex: 6,
                                                                  child: Text(
                                                                    product
                                                                        .specifications[
                                                                            index]
                                                                        .value,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1.0,
                                                          ),
                                                        ],
                                                      );
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  AnimatedCrossFade(
                                    crossFadeState: isRated
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 200),
                                    firstChild: SizedBox(
                                      width: double.maxFinite,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Rate this Product",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ThemeColors.themeColor5,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  RatingBar(
                                                    minRating: 1,
                                                    initialRating: 0,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate:
                                                        (newrating) {
                                                      rating =
                                                          newrating.toString();
                                                    },
                                                    itemCount: 5,
                                                    itemSize: 32.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                  Spacer(),
                                                  RaisedButton(
                                                    color: Colors.amber,
                                                    onPressed: () {
                                                      if (isSignedIn) {
                                                        if (rating.isEmpty) {
                                                          _showSnackBar(
                                                              "Please select your rating and then submit!");
                                                        } else {
                                                          rateProduct(rating);
                                                        }
                                                      } else {
                                                        Navigator.pushNamed(
                                                            context,
                                                            LandingScreen
                                                                .routeName);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Rate This Product",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    secondChild: SizedBox(
                                      width: double.maxFinite,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Your Rating",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color:
                                                        ThemeColors.themeColor5,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              RatingBarIndicator(
                                                rating: double.parse(
                                                    product.shopeeRating.isEmpty
                                                        ? "0"
                                                        : product.shopeeRating),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 32.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Products from the seller",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ThemeColors.themeColor5,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/merchantdetails');
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MerchantProfile(
                                                    merchantId:
                                                        product.merchantId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "View Seller Info",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color:
                                                      ThemeColors.themeColor5,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  GridView.builder(
                                      padding: EdgeInsets.only(top: 0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.8),
                                      ),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      // crossAxisCount: 2,
                                      itemCount: model
                                              .sameMerchantProducts.isEmpty
                                          ? 0
                                          : model.sameMerchantProducts.length,
                                      itemBuilder: (context, index) =>
                                          NearbyItem(
                                            imagePath: model
                                                .sameMerchantProducts[index]
                                                .productImages[0],
                                            productName: model
                                                .sameMerchantProducts[index]
                                                .productName,
                                            isOffer: model
                                                    .sameMerchantProducts[index]
                                                    .isOffer ==
                                                "yes",
                                            isFeatured: model
                                                    .sameMerchantProducts[index]
                                                    .isFeature ==
                                                "yes",
                                            actualPrice: model
                                                .sameMerchantProducts[index]
                                                .actualAmount,
                                            price: model
                                                .sameMerchantProducts[index]
                                                .sellingAmount,
                                            offerPercent: model
                                                .sameMerchantProducts[index]
                                                .offerAmount,
                                            category: model
                                                .sameMerchantProducts[index]
                                                .shopCategoryName,
                                            productId: model
                                                .sameMerchantProducts[index]
                                                .productId,
                                            isOfferTypePercent: model
                                                    .sameMerchantProducts[index]
                                                    .offerType ==
                                                "percentage",
                                          )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isConnectClicked,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConnectClicked = false;
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
